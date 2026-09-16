import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;

abstract class AppSkin {
  const AppSkin();

  /// The Material [ThemeMode] this skin drives — [ThemeMode.light] or
  /// [ThemeMode.dark]. [MaterialApp] receives it as its themeMode so the
  /// framework picks the matching [ThemeData]. Example: LightSkin returns
  /// [ThemeMode.light], DarkSkin returns [ThemeMode.dark].
  ThemeMode get themeMode;

  /// The base color of every screen, painted by [AppScaffold] behind all
  /// content. Example: the cream paper page in light mode and the
  /// near-black midnight page in dark mode.
  Color get background;

  /// The color of elevated blocks sitting on top of [background]: cards,
  /// list containers, chat bubbles, inputs. Example: the white card
  /// holding a task row on the Today screen.
  Color get surface;

  /// A sunken variant of [surface] for blocks that should blend with the
  /// page instead of popping. Example: the tinted fill behind the
  /// week-strip days that are not selected.
  Color get card;

  /// The most raised surface, used by floating elements. Example: the fill
  /// of the add-task bottom sheet and popover menus.
  Color get surfaceElevated;

  /// The default outline drawn around cards, inputs, and pills. Example:
  /// the hairline stroke around a suggestion chip above the chat composer.
  Color get border;

  /// A more visible outline for elements that need clearer separation.
  /// Example: the stroke around the segmented switcher's track.
  Color get borderStrong;

  /// The faintest outline, for separators inside grouped lists. Example:
  /// the line between two rows of the Profile preferences card.
  Color get borderSubtle;

  /// The brand green used for primary actions and emphasis. Example: the
  /// glowing Continue button and the selected day of the week strip.
  Color get primary;

  /// The pressed/hover shade of [primary]. Example: the Continue button
  /// while the finger is down on it.
  Color get primaryHover;

  /// The readable brand shade for text sitting on [primaryLight] fills.
  /// Example: the label of the 'AI' badge on a calendar event.
  Color get primaryDark;

  /// A soft translucent tint of [primary] used as a background behind
  /// green content. Example: the fill behind the 'AI' badge and the
  /// selected setup-wizard option card.
  Color get primaryLight;

  /// The sky-blue secondary color for highlights that must not read as
  /// primary. Example: the bell icon tile on the 'Dinner with Laila'
  /// calendar event.
  Color get accent;

  /// A soft tint of [accent] used as a background behind blue content.
  /// Example: the square behind the video-call icon on an event row.
  Color get accentLight;

  /// The ink drawn on top of an [accent] fill — light on the mid blue of
  /// light mode, dark on the pale blue of dark mode. Example: a glyph
  /// inside a filled accent tile.
  Color get onAccent;

  /// The strongest text color for headings and titles. Example: the
  /// 'Meet your assistant' onboarding headline.
  Color get textPrimary;

  /// The medium-emphasis text color for supporting copy. Example: the
  /// subtitle under an onboarding headline.
  Color get textSecondary;

  /// The lowest-emphasis text color for timestamps and fine print.
  /// Example: the '9:41' timestamp next to an assistant chat bubble.
  Color get textMuted;

  /// The text color used on top of [primary] fills — dark ink in both
  /// modes, per the design. Example: the near-black 'Continue' label on
  /// the green button.
  Color get textOnPrimary;

  /// The color communicating a positive outcome. Example: the check inside
  /// a completed task's circle.
  Color get success;

  /// A soft tint of [success] used as a background. Example: the fill of
  /// the completed-task check circle.
  Color get successLight;

  /// The color communicating a failure or destructive state. Example: the
  /// red 'Log out' row on the Profile screen.
  Color get error;

  /// A soft tint of [error] used as a background. Example: the fill behind
  /// a destructive action's icon tile.
  Color get errorLight;

  /// The color communicating caution. Example: the amber icon of a
  /// schedule that needs attention.
  Color get warning;

  /// A soft tint of [warning] used as a background. Example: the fill
  /// behind a caution badge.
  Color get warningLight;

  /// The color of neutral informational highlights. Example: the blue icon
  /// on an informational banner.
  Color get info;

  /// The unfilled track of progress bars and rings. Example: the grey arc
  /// of the Today screen's 2/6 progress ring.
  Color get progressTrack;

  /// The fill of the small rounded square holding a row's leading icon.
  /// Example: the tile behind the notifications bell on Profile.
  Color get tileIconBackground => card;

  /// The outline of standalone cards, fainter than [border] so cards read
  /// as soft blocks. Example: the stroke around a task card on Today.
  Color get cardBorder => borderSubtle;

  /// The fill of the user's own chat bubbles. Example: the raised bubble
  /// holding 'Plan my day' on the chat screen.
  Color get chatUserBubble => surfaceElevated;

  /// The outline of the user's own chat bubbles. Example: the faint stroke
  /// around the user bubble.
  Color get chatUserBubbleBorder => borderSubtle;

  /// The translucent fill of the chat composer, blurred over the content
  /// scrolling behind it. Example: the 'Ask Sahla anything…' pill.
  Color get composerBackground => surfaceElevated.withValues(alpha: 0.92);

  /// The radial gradient of the assistant's green orb. Example: the
  /// floating sphere on onboarding and the wizard's final step.
  Gradient get orbGradient => const RadialGradient(
    center: Alignment(-0.36, -0.44),
    colors: [Color(0xFF6CDB97), Color(0xFF15A552), Color(0xFF0C5C2E)],
    stops: [0.0, 0.62, 1.0],
  );

  /// The soft halo glowing under the orb. Example: the green light bleed
  /// beneath the onboarding sphere.
  Color get orbGlow => primary.withValues(alpha: 0.35);

  /// The fill of the top app bar. Example: the bar behind the screen title
  /// in [GlobalAppbar].
  Color get appBarBackground => background;

  /// The color of the title text inside the app bar. Example: the 'Today'
  /// title at the top of the tasks screen.
  Color get appBarTitle => textPrimary;

  /// The color of tappable icons inside the app bar. Example: the search
  /// icon on the Calendar screen.
  Color get appBarIcon => textPrimary;

  /// The thin line separating the app bar from the page content when the
  /// page is scrolled. Example: the hairline under [GlobalAppbar].
  Color get appBarDivider => border;

  /// The hairline separating rows inside a list. Example: the line between
  /// two Profile preference rows.
  Color get divider => border;

  /// The drop shadow under elevated cards. Example: the soft shadow below
  /// the month calendar card.
  Color get shadow => textPrimary.withValues(alpha: 0.05);

  /// The deep shadow cast by the app shell's push layer as it slides open
  /// to reveal the navigation drawer. Example: the dark halo around the
  /// rounded content while the drawer is open.
  Color get pushLayerShadow => shadow;

  /// The soft green halo under primary buttons. Example: the glow beneath
  /// the Continue button on onboarding.
  Color get primaryGlow => primary.withValues(alpha: 0.25);

  /// The soft red halo under destructive buttons. Example: the glow beneath
  /// the Log out button on the logout sheet.
  Color get dangerGlow => error.withValues(alpha: 0.22);

  /// The ring drawn around a focused element. Example: the green halo
  /// around the name input on the setup wizard.
  Color get focusRing => primary.withValues(alpha: 0.22);

  /// The dimmed layer covering the screen behind dialogs and bottom
  /// sheets. Example: the scrim behind the add-schedule sheet.
  Color get overlayBarrier => const Color(0x80000000);

  /// A surface that inverts against the page, for transient overlays that
  /// must read as separate from the content beneath them. Defaults to
  /// [textPrimary] — the page's darkest ink in light mode, its lightest in
  /// dark mode. Example: the expressive snackbar pill.
  Color get inverseSurface => textPrimary;

  /// The ink drawn on [inverseSurface]. Defaults to [background], so the
  /// pairing is always the page's own two extremes swapped. Example: the
  /// snackbar's message text.
  Color get onInverseSurface => background;

  /// The translucent fill of the floating bottom navigation pill, blurred
  /// over the content scrolling behind it. Example: the bar holding the
  /// Chat, Today, Calendar, and Profile tabs.
  Color get navBarBackground => surfaceElevated.withValues(alpha: 0.86);

  /// The color of the selected tab's icon and label in the bottom nav.
  /// Example: the green Chat icon while the chat tab is open.
  Color get navBarItemActive => primaryDark;

  /// The color of unselected tabs' icons and labels in the bottom nav.
  /// Example: the greyed-out Calendar icon while on Chat.
  Color get navBarItemInactive => textMuted;

  /// The highlight marking the selected tab. Example: the soft green pill
  /// behind the active nav icon.
  Color get navBarIndicator => primaryLight;

  /// The color of small attention dots and counters. Example: the unread
  /// dot on a day of the week strip.
  Color get badge => accent;

  /// The fill of [PrimaryButton]. Example: the solid green 'Log in'
  /// button.
  Color get buttonBackground => primary;

  /// The label color inside [PrimaryButton]. Example: the dark 'Log in'
  /// text on the green button.
  Color get buttonText => textOnPrimary;

  /// The color of icons drawn inside [PrimaryButton]. Example: the arrow
  /// next to the 'Continue' label.
  Color get buttonIcon => textOnPrimary;

  /// The fill of a disabled [PrimaryButton]. Example: the muted 'Continue'
  /// button before a wizard step is answered.
  Color get buttonDisabledBackground => border;

  /// The label color of a disabled [PrimaryButton]. Example: the faded
  /// text on the disabled button.
  Color get buttonDisabledText => textMuted;

  /// The track of an on-but-not-editable switch. Example: the daily-brief
  /// schedule row, which is owned by the profile's brief hour.
  Color get switchTrackDisabled => primary.withValues(alpha: 0.4);

  /// The color of the loading spinner inside a busy button. Example: the
  /// dots while login submits.
  Color get buttonLoader => textOnPrimary;

  /// The fill of [SecondaryButton] — the design's ghost button. Example:
  /// the 'Continue with Apple' button on the auth screen.
  Color get secondaryButtonBackground => surface;

  /// The outline of [SecondaryButton]. Example: the hairline stroke around
  /// 'Continue with Google'.
  Color get secondaryButtonBorder => border;

  /// The label color inside [SecondaryButton]. Example: the strong
  /// 'Continue with Apple' text.
  Color get secondaryButtonText => textPrimary;

  /// The fill of destructive action buttons. Example: the solid red
  /// background of the 'Log out' button on the logout sheet.
  Color get dangerButtonBackground => error;

  /// The label and icon color of destructive action buttons. Example: the
  /// 'Log out' text sitting on [dangerButtonBackground].
  Color get dangerButtonText;

  /// The soft wash behind the offline strip. Example: the muted red band that
  /// appears above the tab content when the device has no internet.
  Color get offlineStripBackground;

  /// The label color of the offline strip. Example: the 'No connection' text
  /// sitting on [offlineStripBackground].
  Color get offlineStripForeground;

  Color get stopButtonBackground => CupertinoColors.destructiveRed;

  /// The fill of the floating action button. Example: the round green mic
  /// button inside the chat composer.
  Color get fabBackground => primary;

  /// The icon color inside the floating action button. Example: the dark
  /// mic glyph on the green voice button.
  Color get fabIcon => textOnPrimary;

  /// The color of tappable inline text. Example: the 'Forgot password?'
  /// link on the auth screen.
  Color get link => primary;

  /// The fill inside [AppTextField]. Example: the body of the email input
  /// on the auth screen.
  Color get textFieldFill => surface;

  /// The resting outline of [AppTextField]. Example: the stroke around an
  /// untouched input.
  Color get textFieldBorder => border;

  /// The outline of a focused [AppTextField]. Example: the green stroke
  /// while typing your name in the setup wizard.
  Color get textFieldFocusedBorder => primary;

  /// The outline of an [AppTextField] that failed validation. Example: the
  /// red stroke around an empty required field after submit.
  Color get textFieldErrorBorder => error;

  /// The color of the small label above or inside an [AppTextField].
  /// Example: the 'Email' label over the email input.
  Color get textFieldLabel => textSecondary;

  /// The placeholder text color inside an empty [AppTextField]. Example:
  /// 'Ask Sahla anything…' before the user types.
  Color get textFieldHint => textMuted;

  /// The blinking cursor color inside [AppTextField]. Example: the green
  /// caret while typing.
  Color get textFieldCursor => primary;

  /// The color of text the user has typed into an [AppTextField].
  /// Example: the entered email address.
  Color get textFieldText => textPrimary;

  /// The fill of the dedicated search bar, slightly different from a
  /// normal input. Example: the search field on the Calendar screen.
  Color get searchFieldFill => surface;

  /// The default fill of [AppContainer] blocks. Example: the tinted box
  /// wrapping a highlighted section.
  Color get containerBackground => primaryLight;

  /// The default color of the icon inside the row's leading rounded
  /// square. Example: the language glyph on the Profile rows.
  Color get tileIcon => textSecondary;

  /// The fill of small rounded label pills. Example: the soft green fill
  /// behind the 'AI' badge on a calendar event.
  Color get chipBackground => primaryLight;

  /// The text color inside those pills. Example: the 'AI' label inside the
  /// badge.
  Color get chipText => primaryDark;

  /// The fill of the segmented switcher's track. Example: the sunken bar
  /// holding the All / Routines / One-time filters.
  Color get segmentedBackground => card;

  /// The fill of the selected segment's sliding thumb. Example: the raised
  /// pill behind 'All' while that filter is active.
  Color get segmentedThumb => surface;

  /// The label color of the selected segment. Example: the strong 'All'
  /// text on the raised thumb.
  Color get segmentedActiveText => textPrimary;

  /// The label color of unselected segments. Example: the muted 'Routines'
  /// and 'One-time' texts.
  Color get segmentedInactiveText => textSecondary;

  /// The fill of bottom sheets. Example: the sheet that slides up when
  /// adding a task.
  Color get bottomSheetBackground => surface;

  /// The color of the small drag handle at the top of a bottom sheet.
  /// Example: the rounded bar in [BottomSheetContainer].
  Color get bottomSheetHandle => borderStrong;

  /// The fill of [AppDialog]. Example: the box of the new-chat
  /// confirmation dialog.
  Color get dialogBackground => surface;

  /// The filled portion of progress bars and rings. Example: the green arc
  /// of the Today screen's progress ring.
  Color get progressFill => primary;

  /// The color of the full-screen loading indicator. Example: the spinner
  /// shown by [AppLoader] while data loads.
  Color get loader => primary;

  /// The base color of shimmer placeholders. Example: the blocks where
  /// task rows will appear.
  Color get shimmerBase => progressTrack;

  /// The moving highlight of shimmer placeholders. Example: the light
  /// sweep passing over the blocks.
  Color get shimmerHighlight => surface;

  /// The spinner color of the pull-to-refresh indicator. Example: the
  /// green arc when pulling the chat down.
  Color get refreshIndicator => primary;

  /// The circle behind the pull-to-refresh spinner. Example: the disc
  /// holding the green arc.
  Color get refreshIndicatorBackground => surface;

  /// The color of the current page's dot in a dots indicator. Example:
  /// the filled pill under the onboarding slide being viewed.
  Color get pageIndicatorActive => primary;

  /// The color of the remaining dots in a dots indicator. Example: the
  /// faded dots for onboarding slides not yet reached.
  Color get pageIndicatorInactive => borderStrong;
}
