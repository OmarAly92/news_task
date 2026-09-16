import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_disable_widget.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    super.key,
    this.isLoading = false,
    this.disable = false,
    this.failureMessage,
    required this.items,
    required this.title,
    this.onSelected,
    this.retryRequestOnFailure,
    required this.selectedItem,
    this.child,
    this.maxWidth,
    this.minWidth,
  });

  final bool isLoading;
  final bool disable;
  final String? failureMessage;
  final String title;

  // final List<PopupMenuEntry<T>> items;
  final void Function(T value)? onSelected;
  final void Function()? retryRequestOnFailure;
  final T selectedItem;
  final List<T> items;
  final Widget? child;
  final double? maxWidth, minWidth;

  @override
  Widget build(BuildContext context) {
    return AppDisableWidget(
      disable: disable,
      iconSize: 21,
      child: PopupMenuButton<T>(
        position: PopupMenuPosition.under,
        // padding: EdgeInsets.symmetric(horizontal: 8),
        // menuPadding: EdgeInsets.symmetric(horizontal: 12),
        // icon: Icon(Icons.arrow_drop_down),
        iconColor: context.skin.textPrimary,
        elevation: 2,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? context.width - 100,
          minWidth: minWidth ?? context.width - 100,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        itemBuilder: (BuildContext context) => items.map((item) {
          return PopupMenuItem<T>(
            value: item,
            child: Container(
              color: item == selectedItem
                  ? context.skin.primaryLight
                  : Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                children: [
                  AppText(
                    item.toString(), // or your own widget
                    style: AppTextStyle.style14Regular,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        onSelected: onSelected,
        child:
            child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  title,
                  style: AppTextStyle.style14Regular.copyWith(
                    color: context.skin.textPrimary,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
      ),
    );
  }

  // Widget buildTrailing() {
  //   if (isLoading) {
  //     return const SizedBox(
  //       height: 20,
  //       width: 20,
  //       child: CircularProgressIndicator(strokeWidth: 3),
  //     );
  //   } else if (failureMessage != null) {
  //     return SizedBox(
  //       height: 20,
  //       width: 20,
  //       child: IconButton(
  //         onPressed: retryRequestOnFailure,
  //         tooltip: failureMessage,
  //         style: IconButton.styleFrom(
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           padding: EdgeInsets.zero,
  //         ),
  //       ),
  //     );
  //   } else {
  //     return const Icon(Icons.keyboard_arrow_down, size: 20);
  //   }
  // }
}
