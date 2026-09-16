# Colors & theming

Everything about how colour works in sahla: where a colour lives, how it reaches a widget, and
how the app's palette is bridged into Flutter's `ColorScheme`.

**The one rule:** feature code uses `context.skin.<slot>`. Never a raw `Color(0x…)`, never
`Theme.of(context).colorScheme.…`.

---

## 1. The files

```
lib/core/app_themes/colors/
├── app_skin.dart      # AppSkin — the abstract palette contract (98 slots)
├── light_skin.dart    # LightSkin — "cream paper"
├── dark_skin.dart     # DarkSkin  — "midnight"
├── skin_scope.dart    # SkinScope InheritedWidget + the `context.skin` extension
├── logic/
│   ├── skin_cubit.dart  # SkinCubit — holds the active skin, persists it
│   └── skin_state.dart  # SkinInitialState / SkinChangedState
└── README.md          # this file

lib/core/app_themes/themes/app_themes.dart   # AppSkin -> Flutter ThemeData
```

## 2. How a colour reaches a widget

```
CacheHelper (CacheKeys.currentTheme)
      │  restores "light" | "dark" on launch
      ▼
  SkinCubit ─────────────────── holds `AppSkin skin`
      │  emits SkinChangedState on toggleSkin()
      ▼
   MyApp rebuilds
      ├──► SkinScope(skin: skin) ───────────────► context.skin.<slot>   ← feature code
      └──► MaterialApp(
             theme:     AppThemes.fromSkin(LightSkin()),
             darkTheme: AppThemes.fromSkin(DarkSkin()),
             themeMode: skin.themeMode,
           ) ────────────────────────────────────► Theme.of(context)    ← Material widgets
                                                                          + packages/
```

Two consumers, one source of truth:

| Consumer | Reads via | Example |
|---|---|---|
| Sahla's own widgets | `context.skin.surface` | `AppScaffold`, `PrimaryButton` |
| Material's widgets | `Theme.of(context).colorScheme` | `Chip`, `FilledButton`, `Divider` |
| `packages/expressive_*` | `Theme.of(context).colorScheme` | the snackbar pill, `LoadingIndicator` |

Section 5 is entirely about keeping those two consumers in agreement.

### Switching skins

```dart
context.toggleSkin();               // light <-> dark, persisted
context.setSkin(const DarkSkin());  // explicit
```

`SkinCubit.setSkin` writes `themeMode.name` to `CacheKeys.currentTheme`, so the choice survives a
restart. `MyApp` sits under a `BlocBuilder<SkinCubit, SkinState>`, so `SkinScope` and
`MaterialApp.themeMode` rebuild together — the two consumers can never disagree about which skin
is active.

## 3. `AppSkin` — the contract

`AppSkin` is an abstract class of **98 colour slots**. Each carries a doc comment naming a real
place in the UI ("the glowing Continue button", "the '9:41' timestamp next to a chat bubble").
That is deliberate: it makes *"which green goes here?"* answerable without opening the design
file.

Slots come in two kinds.

**30 abstract slots** — the raw palette. Every skin must supply them:

```
background  surface  card  surfaceElevated
border  borderStrong  borderSubtle
primary  primaryHover  primaryDark  primaryLight
accent  accentLight  onAccent
textPrimary  textSecondary  textMuted  textOnPrimary
success  successLight  error  errorLight  warning  warningLight  info
progressTrack  dangerButtonText
offlineStripBackground  offlineStripForeground
```

**68 derived slots** — semantic aliases with defaults, overridable per skin:

```dart
Color get bottomSheetBackground => surface;
Color get chipBackground        => primaryLight;
Color get shadow                => textPrimary.withValues(alpha: 0.05);
```

`DarkSkin` overrides 8 of these where the derivation doesn't hold — e.g.
`bottomSheetBackground => surfaceElevated`, because in dark mode a sheet has to lift off the page
rather than match it.

This split is why the palette scales. A new component slot (`chipBackground`, `navBarIndicator`)
costs one line with a sensible default, and only the skins that disagree override it.

## 4. The palette

### Brand ramp — identical in both skins

| Token | Hex | Use |
|---|---|---|
| brand-300 | `#6CDB97` | orb gradient highlight |
| **brand-500 → `primary`** | **`#1ACB64`** | THE green — buttons, selection, dots |
| brand-600 | `#15A552` | orb mid; light-mode hover |
| brand-800 | `#0C5C2E` | orb edge |

### Core slots

| Slot | Light ("cream paper") | Dark ("midnight") |
|---|---|---|
| `background` | `#FAF7F2` | `#18171C` |
| `surface` | `#FFFFFF` | `#1F1E24` |
| `card` (sunken) | `#F4EFE6` | `#131218` |
| `surfaceElevated` | `#FFFFFF` | `#28262E` |
| `border` | `#EBE4D6` | white @7% |
| `borderStrong` | `#D8CEBD` | white @12% |
| `borderSubtle` | `#1A1612` @6% | white @4% |
| `primary` | `#1ACB64` | `#1ACB64` |
| `primaryHover` | `#15A552` | `#34D77B` |
| `primaryDark` | `#117E3F` | `#4DDB8A` |
| `primaryLight` | `#D2F5DE` | `#1ACB64` @14% |
| `accent` | `#1F8EE0` | `#7ED4FF` |
| `accentLight` | `#E8F6FF` | `#47BFFF` @10% |
| `onAccent` | `#FAF7F2` | `#18171C` |
| `textPrimary` | `#1A1612` | `#FFFFFF` |
| `textSecondary` | `#6B6354` | `#A09EA8` |
| `textMuted` | `#9C9381` | `#6F6D78` |
| `textOnPrimary` | `#18171C` | `#18171C` |
| `success` | `#1F8A5B` | `#4DDB8A` |
| `error` | `#C43A3A` | `#FF7575` |
| `warning` | `#C47A18` | `#F5B347` |
| `info` | `#1F8EE0` | `#7ED4FF` |
| `progressTrack` | `#EBE4D6` | `#2A2832` |
| `dangerButtonText` | `#FAF7F2` | `#18171C` |
| `offlineStripBackground` | `#F3E3E1` | `#3A1F1E` |
| `offlineStripForeground` | `#A32F2B` | `#F2A9A5` |

### Three things that look like mistakes and aren't

- **`textOnPrimary` is `#18171C` in both skins.** Dark ink on green, always. The brand green is
  bright enough that white on it fails contrast. A design decision, not an oversight.
- **Light-mode elevation runs *lighter*, not darker.** `card` (sunken) `#F4EFE6` → `background`
  `#FAF7F2` → `surface` `#FFFFFF`. More elevated = whiter. This is the inverse of M3's own
  light-mode convention, and it drives the surface mapping in §5.
- **Several dark slots are translucent** (`primaryLight`, `border`, `borderStrong`,
  `borderSubtle`, `accentLight`, `errorLight`). In dark mode sahla layers alpha over the page
  instead of mixing opaque tints. See the caveat at the end of §5.

## 5. The `ColorScheme` bridge

`AppThemes.fromSkin(skin)` turns an `AppSkin` into `ThemeData`. Most of that file is component
themes (`appBarTheme`, `dialogTheme`, `timePickerTheme`, …). The part that matters here is the
`ColorScheme`.

### Why it needs care

`ColorScheme.fromSeed` generates ~30 roles from a single seed colour. **Every role you don't pass
explicitly is invented by the M3 tonal-palette algorithm.** Sahla's seed is the brand green, so
the algorithm derived *cool grey-green* neutrals — for a *warm cream* app.

This was invisible while only sahla's own widgets drew colour, because they read `context.skin`.
It stopped being invisible when `packages/expressive_*` arrived: those read `ColorScheme`
directly and have no idea `AppSkin` exists.

What the unmapped roles used to resolve to, versus what the skin actually says:

| Role | Was (algorithm) | Now (skin) |
|---|---|---|
| `surfaceContainer` | `#EBEFE7` cool grey-green | `#FFFFFF` ← `surface` |
| `outline` | `#727970` grey | `#EBE4D6` ← `border` |
| `onSurfaceVariant` | `#414941` | `#6B6354` ← `textSecondary` |
| `secondary` | `#506351` sage | `#1F8EE0` ← `accent` |
| `tertiary` | `#39656D` teal | `#1F8EE0` ← `accent` |
| `inverseSurface` | `#2D322C` | `#1A1612` ← `textPrimary` |

Sage and teal appear nowhere in sahla's design. They were tonal-palette output that nobody chose.

### The mapping

Every role is now explicit:

| ColorScheme role | AppSkin slot |
|---|---|
| `primary` / `onPrimary` | `primary` / `textOnPrimary` |
| `primaryContainer` / `onPrimaryContainer` | `primaryLight` / `primaryDark` |
| `inversePrimary` | `primary` |
| `secondary` / `onSecondary` | `accent` / `onAccent` |
| `secondaryContainer` / `onSecondaryContainer` | `accentLight` / `accent` |
| `tertiary` / `onTertiary` | `accent` / `onAccent` |
| `tertiaryContainer` / `onTertiaryContainer` | `accentLight` / `accent` |
| `surface` / `onSurface` | `surface` / `textPrimary` |
| `onSurfaceVariant` | `textSecondary` |
| `surfaceContainerLowest` | `card` |
| `surfaceContainerLow` | `background` |
| `surfaceContainer` | `surface` |
| `surfaceContainerHigh` / `surfaceContainerHighest` | `surfaceElevated` |
| `surfaceTint` | `primary` |
| `inverseSurface` / `onInverseSurface` | `inverseSurface` / `onInverseSurface` |
| `outline` / `outlineVariant` | `border` / `borderSubtle` |
| `error` / `onError` | `error` / `dangerButtonText` |
| `errorContainer` / `onErrorContainer` | `errorLight` / `error` |

Three decisions worth knowing about:

1. **`secondary` and `tertiary` share `accent`.** Sahla has one accent hue (sky blue). Rather
   than invent a third, both point at it — a widget that distinguishes them gets the same blue,
   which looks intentional, instead of a teal that belongs to nothing.
2. **The surface ramp follows sahla's ladder, not M3's convention.** `Lowest → card` (sunken)
   up to `Highest → surfaceElevated`. In light mode that makes lower rungs *darker*, the opposite
   of stock M3 — because sahla's design makes elevated things whiter (§4).
3. **`inverseSurface` defaults to `textPrimary`, `onInverseSurface` to `background`.** The
   inverted surface is the page's own two extremes, swapped: light → dark pill with cream text;
   dark → white pill with near-black text. Either skin can override for a softer pairing.

### Two roles deliberately NOT mapped

**`shadow` and `scrim` stay at their opaque defaults.** They look mappable and are not, because
the two sides disagree about alpha:

- `skin.shadow` bakes alpha in (`textPrimary` @5% light, black @50% dark) — it is handed straight
  to a `BoxShadow`. `colorScheme.shadow` is a **base** colour that `Material`, `FilledButton` and
  `ElevatedButton` composite themselves. Mapping a 5%-alpha colour there would flatten elevation
  app-wide.
- `skin.overlayBarrier` is likewise pre-alpha'd (black @50%) for direct use as a barrier — and no
  Flutter widget reads `colorScheme.scrim` in the current version anyway.

> **The rule:** map roles used *as-is* (surfaces, text, borders, containers). Never map a role
> that Material alpha-composites itself when the skin slot already bakes alpha in.

### Caveat: translucent dark slots

`primaryContainer → primaryLight` is `#1ACB64` @14% in dark mode. That is right for `outline`
(Material draws borders, and translucency is how sahla draws them), but `primaryContainer` is
treated by Material as an **opaque fill** — `LoadingIndicator.contained`, for example, paints it
as a solid circle. If a see-through container ever reads wrong, add an opaque `primaryContainer`
slot to `AppSkin` rather than reusing `primaryLight`.

### The guardrail

`test/core/color_scheme_mapping_test.dart` asserts every role above equals its skin slot, in both
skins, plus that `shadow`/`scrim` stay opaque. A role dropped from the mapping silently falls
back to the algorithm — this test is what makes that loud instead of invisible.

## 6. Recipes

### Use a colour

```dart
final skin = context.skin;
Container(color: skin.surface, child: AppText('hi', style: AppTextStyle.bodyMd));
```

`context.skin` registers a `SkinScope` dependency, so the widget rebuilds on skin change.

### Add a new colour

1. **Prefer a derived slot.** If it can be expressed from the raw palette, add it to `AppSkin`
   with a default and a doc comment naming where it's used:
   ```dart
   /// The fill behind a pinned task row. Example: the highlighted row at the
   /// top of Today.
   Color get pinnedRowBackground => primaryLight;
   ```
   Nothing else changes — both skins inherit it.
2. **Only add an abstract slot** when the colour genuinely differs per skin and can't be derived.
   Then implement it in `LightSkin` *and* `DarkSkin`; the compiler enforces this.
3. **Never** put a raw `Color(0x…)` in feature code. Reaching for one means the slot is missing.

### Add a new skin

Extend `AppSkin`, implement the 30 abstract slots, override any derived slot that doesn't hold,
then register it in `SkinCubit._savedSkin` / `toggleSkin` and in `MyApp`'s `theme` / `darkTheme`.
Add it to the loop in `color_scheme_mapping_test.dart` and the mapping is verified for free.

### Change how a role maps to Material

Edit the `ColorScheme.fromSeed` block in `themes/app_themes.dart`, then update the matching
expectation in `color_scheme_mapping_test.dart`. The test failing is the reminder that the two
must move together.

## 7. Related

- `docs/design/colors.md` — the design-side token table (source of these hex values)
- `docs/design/theming-gaps.md` — why this mapping exists, plus the three remaining theming gaps
  (real springs, page physics, shape tokens)
- `lib/core/app_themes/text_style/` — `AppTextStyle`, the same idea for type
- `lib/core/app_themes/app_motion.dart` — `AppMotion`, the same idea for durations and curves
