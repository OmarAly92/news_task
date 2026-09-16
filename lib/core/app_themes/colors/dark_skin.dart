import 'package:news_task/core/app_themes/colors/app_skin.dart';
import 'package:flutter/material.dart';

class DarkSkin extends AppSkin {
  const DarkSkin();

  @override
  ThemeMode get themeMode => ThemeMode.dark;

  @override
  Color get background => const Color(0xFF18171C);

  @override
  Color get surface => const Color(0xFF1F1E24);

  @override
  Color get card => const Color(0xFF131218);

  @override
  Color get surfaceElevated => const Color(0xFF28262E);

  @override
  Color get border => const Color(0x12FFFFFF);

  @override
  Color get borderStrong => const Color(0x1FFFFFFF);

  @override
  Color get borderSubtle => const Color(0x0AFFFFFF);

  @override
  Color get primary => const Color(0xFF1ACB64);

  @override
  Color get primaryHover => const Color(0xFF34D77B);

  @override
  Color get primaryDark => const Color(0xFF4DDB8A);

  @override
  Color get primaryLight => const Color(0x241ACB64);

  @override
  Color get accent => const Color(0xFF7ED4FF);

  @override
  Color get accentLight => const Color(0x1A47BFFF);

  @override
  Color get onAccent => const Color(0xFF18171C);

  @override
  Color get textPrimary => const Color(0xFFFFFFFF);

  @override
  Color get textSecondary => const Color(0xFFA09EA8);

  @override
  Color get textMuted => const Color(0xFF6F6D78);

  @override
  Color get dangerButtonText => const Color(0xFF18171C);

  @override
  Color get offlineStripBackground => const Color(0xFF3A1F1E);

  @override
  Color get offlineStripForeground => const Color(0xFFF2A9A5);

  @override
  Color get textOnPrimary => const Color(0xFF18171C);

  @override
  Color get success => const Color(0xFF4DDB8A);

  @override
  Color get successLight => const Color(0x291ACB64);

  @override
  Color get error => const Color(0xFFFF7575);

  @override
  Color get errorLight => const Color(0x24FF7575);

  @override
  Color get warning => const Color(0xFFF5B347);

  @override
  Color get warningLight => const Color(0x29E89527);

  @override
  Color get info => const Color(0xFF7ED4FF);

  @override
  Color get progressTrack => const Color(0xFF2A2832);

  @override
  Color get shadow => const Color(0x80000000);

  @override
  Color get pushLayerShadow => const Color(0x73000000);

  @override
  Color get focusRing => primary.withValues(alpha: 0.30);

  @override
  Color get segmentedThumb => surfaceElevated;

  @override
  Color get bottomSheetHandle => const Color(0xFF3A3845);

  @override
  Color get dialogBackground => surfaceElevated;

  @override
  Color get bottomSheetBackground => surfaceElevated;

  @override
  Color get shimmerHighlight => surfaceElevated;
}
