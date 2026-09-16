import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_task/core/app_themes/text_style/font_weight_helper.dart';
import 'package:news_task/core/utils/app_strings.dart';

sealed class AppTextStyle {
  /// Style Generator
  static TextStyle _textStyle(
    double size,
    FontWeight weight, {
    String? family,
    double? height,
    double tracking = 0,
  }) {
    return TextStyle(
      fontSize: size.spMin,
      fontWeight: weight,
      fontFamily: family,
      fontFamilyFallback: family == null ? null : const [AppStrings.arFont],
      height: height,
      letterSpacing: tracking == 0 ? null : size.spMin * tracking,
    );
  }

  /// Display styles — Anthropic Sans Display, for hero headlines.
  /// Sizes/line-heights/tracking mirror the design's display tokens.
  static TextStyle get displayXl => _textStyle(
    64,
    FontWeightHelper.bold,
    family: AppStrings.displayFont,
    height: 1.05,
    tracking: -0.02,
  );

  static TextStyle get displayLg => _textStyle(
    48,
    FontWeightHelper.bold,
    family: AppStrings.displayFont,
    height: 1.08,
    tracking: -0.02,
  );

  static TextStyle get displayMd => _textStyle(
    36,
    FontWeightHelper.bold,
    family: AppStrings.displayFont,
    height: 1.15,
    tracking: -0.015,
  );

  static TextStyle get displaySm => _textStyle(
    28,
    FontWeightHelper.bold,
    family: AppStrings.displayFont,
    height: 1.2,
    tracking: -0.01,
  );

  /// Heading styles — Anthropic Sans Text semibold.
  static TextStyle get headingLg =>
      _textStyle(22, FontWeightHelper.semiBold, height: 1.3, tracking: -0.005);

  static TextStyle get headingMd =>
      _textStyle(18, FontWeightHelper.semiBold, height: 1.35, tracking: -0.003);

  static TextStyle get headingSm =>
      _textStyle(16, FontWeightHelper.semiBold, height: 1.4);

  /// Body styles — Anthropic Sans Text regular.
  static TextStyle get bodyLg =>
      _textStyle(16, FontWeightHelper.regular, height: 1.55);

  static TextStyle get bodyMd =>
      _textStyle(14, FontWeightHelper.regular, height: 1.55);

  static TextStyle get bodySm =>
      _textStyle(13, FontWeightHelper.regular, height: 1.5);

  static TextStyle get caption =>
      _textStyle(12, FontWeightHelper.regular, height: 1.4);

  /// Uppercase section labels like 'PREFERENCES' — pair with
  /// toUpperCase() at the call site.
  static TextStyle get overline =>
      _textStyle(11, FontWeightHelper.medium, height: 1.3, tracking: 0.08);

  /// Mono styles — JetBrains Mono, for badges, timestamps, and code-like
  /// accents ('AI', 'runs for you', schedule times).
  static TextStyle get codeMd => _textStyle(
    13,
    FontWeightHelper.regular,
    family: AppStrings.monoFont,
    height: 1.55,
  );

  static TextStyle get codeSm => _textStyle(
    12,
    FontWeightHelper.regular,
    family: AppStrings.monoFont,
    height: 1.5,
  );

  static TextStyle get badge => _textStyle(
    11,
    FontWeightHelper.medium,
    family: AppStrings.monoFont,
    height: 1.3,
  );

  /// The italic display style of the 'Sahla' wordmark.
  static TextStyle get wordmark => _textStyle(
    24,
    FontWeightHelper.extraBold,
    family: AppStrings.displayFont,
    height: 1.05,
    tracking: -0.02,
  ).copyWith(fontStyle: FontStyle.italic);

  /// Text Styles from size 10 to 32
  static TextStyle get style10Light => _textStyle(10, FontWeightHelper.light);

  static TextStyle get style12Light => _textStyle(12, FontWeightHelper.light);

  static TextStyle get style12SemiBold =>
      _textStyle(12, FontWeightHelper.semiBold);

  static TextStyle get style14Light => _textStyle(14, FontWeightHelper.light);

  static TextStyle get style16Light => _textStyle(16, FontWeightHelper.light);
  static TextStyle get style20Light => _textStyle(20, FontWeightHelper.light);

  static TextStyle get style12Regular =>
      _textStyle(12, FontWeightHelper.regular);

  static TextStyle get style14Regular =>
      _textStyle(14, FontWeightHelper.regular);

  static TextStyle get style16Regular =>
      _textStyle(16, FontWeightHelper.regular);

  static TextStyle get style20Regular =>
      _textStyle(20, FontWeightHelper.regular);

  static TextStyle get style14Medium => _textStyle(14, FontWeightHelper.medium);

  static TextStyle get style16Medium => _textStyle(16, FontWeightHelper.medium);

  static TextStyle get style14SemiBold =>
      _textStyle(14, FontWeightHelper.semiBold);

  static TextStyle get style16SemiBold =>
      _textStyle(16, FontWeightHelper.semiBold);

  static TextStyle get style14Bold => _textStyle(14, FontWeightHelper.bold);

  static TextStyle get style16Bold => _textStyle(16, FontWeightHelper.bold);

  static TextStyle get style18Medium => _textStyle(18, FontWeightHelper.medium);

  static TextStyle get style24Medium => _textStyle(24, FontWeightHelper.medium);

  static TextStyle get style18SemiBold =>
      _textStyle(18, FontWeightHelper.semiBold);

  static TextStyle get style18Regular =>
      _textStyle(18, FontWeightHelper.regular);

  static TextStyle get style20SemiBold =>
      _textStyle(20, FontWeightHelper.semiBold);

  static TextStyle get style20Medium => _textStyle(20, FontWeightHelper.medium);

  static TextStyle get style20Bold => _textStyle(20, FontWeightHelper.bold);

  static TextStyle get style24Bold => _textStyle(24, FontWeightHelper.bold);

  static TextStyle get style28Bold => _textStyle(28, FontWeightHelper.bold);

  static TextStyle get style32Bold => _textStyle(32, FontWeightHelper.bold);
}
