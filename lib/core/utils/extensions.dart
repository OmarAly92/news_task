import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:expressive_snack/expressive_snack.dart';
import 'package:news_task/core/app_routes/app_router.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/helpers/localization/app_localization.dart';
import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  double get toPadding => MediaQuery.of(this).viewPadding.top;

  double get bottom => MediaQuery.of(this).viewInsets.bottom;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;
}

extension AppLocaization on BuildContext {
  bool get isArabic =>
      EasyLocalization.of(this)?.currentLocale == AppLocalization.arLocal;

  Future<void>? get setLocale async =>
      await EasyLocalization.of(this)?.setLocale(locale);

  Locale get currentLocale =>
      EasyLocalization.of(this)?.currentLocale ?? AppLocalization.enLocal;
}

extension AppTheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

extension HandleNullOrEmptyString on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);

  bool get isNotNullOrEmpty => this != null && (this?.isNotEmpty ?? false);
}

extension HandleNullOrEmptyList on List? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);

  bool get isNotNullOrEmpty => this != null && (this?.isNotEmpty ?? false);
}

extension HandleNullOrEmptyMap on Map? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);

  bool get isNotNullOrEmpty => this != null && (this?.isNotEmpty ?? false);
}

extension HandleNullInt on int? {
  bool get isNull => this == null;

  bool get isNotNull => this != null;
}

extension HandleNullNum on num? {
  bool get isNull => this == null;

  bool get isNotNull => this != null;
}

extension HandleNullDouble on double? {
  bool get isNull => this == null;

  bool get isNotNull => this != null;
}

extension ShowSnakbarExtension on BuildContext {
  void showSnackBar(
    String text, {
    IconData? icon,
    Color? snackColor,
    Color? textColor,
    String? actionLabel,
    VoidCallback? onAction,
    Duration? duration,
  }) {
    AppRouter.scaffoldMessengerKey.currentState?.showAppSnackBar(
      text,
      icon: icon,
      snackColor: snackColor,
      textColor: textColor,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  void showErrorSnackBar(
    String text, {
    IconData? icon,
    String? actionLabel,
    VoidCallback? onAction,
    Duration? duration,
  }) {
    showSnackBar(
      text,
      icon: icon,
      snackColor: skin.error,
      textColor: skin.dangerButtonText,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  void clearSnackBars() => clearExpressiveSnacks();
}

extension ShowSnackbarMessengerExtension on ScaffoldMessengerState {
  void showAppSnackBar(
    String text, {
    IconData? icon,
    Color? snackColor,
    Color? textColor,
    String? actionLabel,
    VoidCallback? onAction,
    Duration? duration,
  }) {
    showExpressiveSnack(
      // MaterialApp mounts the messenger above the navigator, so this
      // context has no overlay ancestor of its own to insert into.
      context: context,
      overlay: AppRouter.navigationKey.currentState?.overlay,
      message: text,
      icon: icon,
      maxLines: 3,
      backgroundColor: snackColor,
      foregroundColor: textColor,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration ?? const Duration(milliseconds: 2000),
    );
  }
}

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
      rootNavigator: true,
    ).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
      rootNavigator: true,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(
      this,
      rootNavigator: true,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop<T>([T? result]) => Navigator.pop(this, result);

  /// 🔹 Pop until a condition is met
  void popUntil(RoutePredicate predicate) {
    Navigator.of(this, rootNavigator: true).popUntil(predicate);
  }

  /// 🔹 Pop all routes and go back to first (root)
  void popToRoot() {
    Navigator.of(this, rootNavigator: true).popUntil((route) => route.isFirst);
  }
}

extension DatePicker on BuildContext {
  Future<DateTime?> showDatePickerDialog({DateTime? initialDate}) async {
    final DateTime today = DateTime.now();
    final DateTime initial = initialDate ?? today;

    final DateTime? pickedDate = await showDatePicker(
      context: this,
      initialDate: initial,
      firstDate: today,
      lastDate: today.add(const Duration(days: 356)),
    );

    return pickedDate;
  }
}
