import 'package:news_task/core/app_themes/colors/app_skin.dart';
import 'package:flutter/material.dart';

class LightSkin extends AppSkin {
  const LightSkin();

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  Color get background => const Color(0xFFFAF7F2);

  @override
  Color get surface => const Color(0xFFFFFFFF);

  @override
  Color get card => const Color(0xFFF4EFE6);

  @override
  Color get surfaceElevated => const Color(0xFFFFFFFF);

  @override
  Color get border => const Color(0xFFEBE4D6);

  @override
  Color get borderStrong => const Color(0xFFD8CEBD);

  @override
  Color get borderSubtle => const Color(0x0F1A1612);

  @override
  Color get primary => const Color(0xFF1ACB64);

  @override
  Color get primaryHover => const Color(0xFF15A552);

  @override
  Color get primaryDark => const Color(0xFF117E3F);

  @override
  Color get primaryLight => const Color(0xFFD2F5DE);

  @override
  Color get accent => const Color(0xFF1F8EE0);

  @override
  Color get accentLight => const Color(0xFFE8F6FF);

  @override
  Color get onAccent => const Color(0xFFFAF7F2);

  @override
  Color get textPrimary => const Color(0xFF1A1612);

  @override
  Color get textSecondary => const Color(0xFF6B6354);

  @override
  Color get textMuted => const Color(0xFF9C9381);

  @override
  Color get dangerButtonText => const Color(0xFFFAF7F2);

  @override
  Color get offlineStripBackground => const Color(0xFFF3E3E1);

  @override
  Color get offlineStripForeground => const Color(0xFFA32F2B);

  @override
  Color get textOnPrimary => const Color(0xFF18171C);

  @override
  Color get success => const Color(0xFF1F8A5B);

  @override
  Color get successLight => const Color(0xFFD6F0E1);

  @override
  Color get error => const Color(0xFFC43A3A);

  @override
  Color get errorLight => const Color(0xFFFAD9D9);

  @override
  Color get warning => const Color(0xFFC47A18);

  @override
  Color get warningLight => const Color(0xFFFAE8C8);

  @override
  Color get info => const Color(0xFF1F8EE0);

  @override
  Color get progressTrack => const Color(0xFFEBE4D6);

  @override
  Color get pushLayerShadow => const Color(0x2E1A1612);
}
