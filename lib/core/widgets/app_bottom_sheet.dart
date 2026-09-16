import 'package:expressive_sheet/expressive_sheet.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';

/// Shows [builder]'s content as a spring-driven modal sheet on the app's
/// standard sheet surface. The route lifts the sheet above the keyboard, so
/// content must not add its own view-inset padding.
Future<T?> showAppSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  return showExpressiveSheet<T>(
    context: context,
    barrierColor: context.skin.overlayBarrier,
    builder: (sheetContext) => AppBottomSheet(child: builder(sheetContext)),
  );
}

/// The sheet surface: full width, the skin's sheet background and a rounded
/// top. [ExpressiveSheetRoute] renders its builder bare, so unlike
/// [showModalBottomSheet] the container comes from here rather than the theme.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: context.skin.bottomSheetBackground,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radius2xl),
          ),
        ),
        child: child,
      ),
    );
  }
}
