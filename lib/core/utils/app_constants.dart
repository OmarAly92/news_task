import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

sealed class AppConstants {
  static const int slideAnimation = 350;
  static const int fadInAnimation = 350;

  /// Design radius scale — xs 4, sm 6, md 10, lg 14 (inputs), xl 20
  /// (cards), 2xl 28 (sheets), pill for buttons/chips/bars.
  static const double radiusXs = 4;
  static const double radiusSm = 6;
  static const double radiusMd = 10;
  static const double radiusLg = 14;
  static const double radiusXl = 20;
  static const double radius2xl = 28;
  static const double radiusPill = 999;

  /// Apply this on all project
  static const double borderRadius = radiusLg;
  static BorderRadius borderRadiusCircular = BorderRadius.circular(radiusXl);
  static BorderRadius borderRadiusCircularButton = BorderRadius.circular(
    radiusPill,
  );
  static BorderRadius textFormBorderRadius = BorderRadius.circular(radiusLg);
  static const double horizontalPadding = 20;
  static const horizontalPaddingEdge = EdgeInsets.symmetric(
    horizontal: horizontalPadding,
  );

  /// Say design system spacing — keep every screen's edge padding and
  /// inter-widget gaps on these values instead of ad-hoc numbers.
  static const double screenTopPadding = 20;
  static const double screenBottomPadding = 20;
  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(
    horizontalPadding,
    screenTopPadding,
    horizontalPadding,
    screenBottomPadding,
  );

  /// Vertical gap between major sections/cards on a screen.
  static const double sectionSpacing = 16;

  /// Gap between items within a row (icon + text block, row of stat cards).
  static const double itemSpacing = 12;

  /// Small gap between an icon and its adjacent label.
  static const double smallSpacing = 8;

  /// Standard internal padding for surface cards.
  static const double cardPadding = 16;

  /// Standard corner radius for surface cards vs. pill-shaped buttons/chips.
  static const double cardBorderRadius = 20;
  static const double pillBorderRadius = 16;

  static const double bottomNavBarHeight = 80;
  static const String appVersion = '1.0.0';
}
