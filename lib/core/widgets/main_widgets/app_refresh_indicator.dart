import 'package:expressive_refresh_indicator/expressive_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';

class AppRefreshIndicator extends StatelessWidget {
  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.notificationPredicate,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final ScrollNotificationPredicate? notificationPredicate;

  @override
  Widget build(BuildContext context) {
    return buildNewRefreshIndicator(context);
  }

  ExpressiveRefreshIndicator buildNewRefreshIndicator(BuildContext context) {
    return ExpressiveRefreshIndicator(
      backgroundColor: context.skin.refreshIndicatorBackground,
      color: context.skin.refreshIndicator,
      onRefresh: onRefresh,
      notificationPredicate:
          notificationPredicate ?? defaultScrollNotificationPredicate,
      child: child,
    );
  }

  RefreshIndicator buildOldRefreshIndicator(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: context.skin.refreshIndicatorBackground,
      color: context.skin.refreshIndicator,
      onRefresh: onRefresh,
      notificationPredicate:
          notificationPredicate ?? defaultScrollNotificationPredicate,
      child: child,
    );
  }
}
