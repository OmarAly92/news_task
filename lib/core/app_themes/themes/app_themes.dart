import 'package:news_task/core/app_themes/colors/app_skin.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

sealed class AppThemes {
  static ThemeData fromSkin(AppSkin skin) {
    final brightness = skin.themeMode == ThemeMode.dark
        ? Brightness.dark
        : Brightness.light;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: skin.textFieldCursor,
        selectionColor: skin.primary.withValues(alpha: .3),
      ),
      scaffoldBackgroundColor: skin.background,
      fontFamily: AppStrings.enFont,
      fontFamilyFallback: [AppStrings.arFont],
      // The M3 Expressive route transition, matching the springs the rest of
      // the app moved to. iOS keeps its platform back-swipe by falling through
      // to the framework default.
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: skin.appBarBackground,
        titleTextStyle: AppTextStyle.style20SemiBold.copyWith(
          color: skin.appBarTitle,
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 16,
        shape: Border(bottom: BorderSide(color: skin.appBarDivider, width: 1)),
        iconTheme: IconThemeData(color: skin.appBarIcon),
        actionsIconTheme: IconThemeData(color: skin.appBarIcon),
        surfaceTintColor: Colors.transparent,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: skin.primary,
        labelStyle: AppTextStyle.style16Medium,
        unselectedLabelColor: skin.textMuted,
        unselectedLabelStyle: AppTextStyle.style16Medium,
        dividerColor: skin.divider,
        indicatorColor: skin.primary,
        overlayColor: WidgetStatePropertyAll<Color>(skin.primaryLight),
        splashFactory: InkRipple.splashFactory,
      ),
      // Every role is mapped to an AppSkin slot. Anything left to
      // ColorScheme.fromSeed would be invented by the tonal-palette algorithm
      // from skin.primary — cool grey-green neutrals that clash with the warm
      // cream palette — and Material's own widgets plus the packages/ read
      // these roles directly. See docs/design/theming-gaps.md.
      colorScheme: ColorScheme.fromSeed(
        seedColor: skin.primary,
        brightness: brightness,

        primary: skin.primary,
        onPrimary: skin.textOnPrimary,
        primaryContainer: skin.primaryLight,
        onPrimaryContainer: skin.primaryDark,
        inversePrimary: skin.primary,

        // Sahla has one accent hue, so secondary and tertiary share it rather
        // than letting the algorithm invent a sage and a teal.
        secondary: skin.accent,
        onSecondary: skin.onAccent,
        secondaryContainer: skin.accentLight,
        onSecondaryContainer: skin.accent,
        tertiary: skin.accent,
        onTertiary: skin.onAccent,
        tertiaryContainer: skin.accentLight,
        onTertiaryContainer: skin.accent,

        surface: skin.surface,
        onSurface: skin.textPrimary,
        onSurfaceVariant: skin.textSecondary,
        // The ramp follows sahla's own elevation ladder — sunken card, page,
        // surface, elevated — rather than M3's light-mode convention of
        // lower emphasis being lighter.
        surfaceContainerLowest: skin.card,
        surfaceContainerLow: skin.background,
        surfaceContainer: skin.surface,
        surfaceContainerHigh: skin.surfaceElevated,
        surfaceContainerHighest: skin.surfaceElevated,
        surfaceTint: skin.primary,
        inverseSurface: skin.inverseSurface,
        onInverseSurface: skin.onInverseSurface,

        outline: skin.border,
        outlineVariant: skin.borderSubtle,

        error: skin.error,
        onError: skin.dangerButtonText,
        errorContainer: skin.errorLight,
        onErrorContainer: skin.error,

        // shadow and scrim are deliberately NOT mapped: skin.shadow and
        // skin.overlayBarrier bake their alpha in for direct use, while
        // Material composites these roles itself. Mapping skin.shadow here
        // would flatten elevation on Material, FilledButton and
        // ElevatedButton.
      ),
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Icon(Icons.check, color: skin.primary, size: 20)
              : const Icon(Icons.close, size: 20),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? skin.primary
              : skin.surface,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? skin.textOnPrimary
              : skin.primary,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? null : skin.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: skin.buttonBackground,
          foregroundColor: skin.buttonText,
          shape: const StadiumBorder(),
        ),
      ),
      badgeTheme: BadgeThemeData(backgroundColor: skin.badge),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(skin.textOnPrimary),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return skin.primary;
          }
          return skin.surface;
        }),
        side: BorderSide(color: skin.border),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 74,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => AppTextStyle.style14Light.copyWith(
            color: states.contains(WidgetState.selected)
                ? skin.navBarItemActive
                : skin.navBarItemInactive,
          ),
        ),
        backgroundColor: skin.navBarBackground,
        indicatorColor: skin.navBarIndicator,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: skin.dialogBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusXl),
        ),
        barrierColor: skin.overlayBarrier,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: skin.bottomSheetBackground,
        surfaceTintColor: Colors.transparent,
        modalBarrierColor: skin.overlayBarrier,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radius2xl),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: skin.navBarBackground,
        selectedItemColor: skin.navBarItemActive,
        unselectedItemColor: skin.navBarItemInactive,
        selectedLabelStyle: AppTextStyle.style14Light,
        unselectedLabelStyle: AppTextStyle.style14Light,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return skin.primary;
          }
          return skin.textMuted;
        }),
      ),
      dividerColor: skin.divider,
      datePickerTheme: DatePickerThemeData(
        confirmButtonStyle: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll<Color>(skin.primary),
        ),
        cancelButtonStyle: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll<Color>(skin.primary),
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: skin.surfaceElevated,
        hourMinuteColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? skin.primaryLight
              : skin.card,
        ),
        hourMinuteTextColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? skin.primaryDark
              : skin.textPrimary,
        ),
        dayPeriodColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? skin.primary
              : Colors.transparent,
        ),
        dayPeriodTextColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? skin.textOnPrimary
              : skin.textSecondary,
        ),
        dayPeriodBorderSide: BorderSide(color: skin.border),
        dialBackgroundColor: skin.card,
        dialHandColor: skin.primary,
        dialTextColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? skin.textOnPrimary
              : skin.textPrimary,
        ),
        entryModeIconColor: skin.textSecondary,
        helpTextStyle: AppTextStyle.bodySm.copyWith(color: skin.textSecondary),
        confirmButtonStyle: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll<Color>(skin.primary),
        ),
        cancelButtonStyle: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll<Color>(skin.primary),
        ),
      ),
    );
  }
}
