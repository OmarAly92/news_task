import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/widgets/app_pop_icon.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppbar({
    this.leading,
    this.title,
    this.titleText,
    this.actions,
    this.backgroundColor,
    this.centerTitle = false,
    this.elevation,
    this.leadingWidth,
    this.surfaceTintColor,
    this.bottom,
    this.hasBorder = false,
    super.key,
    this.leadingText,
    this.onAppPopIconPressed,
  }) : _isSub = false;

  const GlobalAppbar.sub({
    this.leading,
    this.title,
    this.titleText,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.elevation,
    this.leadingWidth,
    this.surfaceTintColor,
    this.bottom,
    super.key,
    this.hasBorder = false,
    this.leadingText,
    this.onAppPopIconPressed,
  }) : _isSub = true;

  final bool _isSub;
  final Widget? leading;
  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final double? leadingWidth;
  final Color? surfaceTintColor;
  final bool? centerTitle;
  final bool hasBorder;
  final PreferredSizeWidget? bottom;
  final String? leadingText;
  final void Function()? onAppPopIconPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? context.skin.appBarBackground,
      centerTitle: centerTitle,
      leadingWidth: leadingWidth ?? 120,
      leading: _isSub
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                leading ?? AppPopIcon(onPressed: onAppPopIconPressed),
                if (leadingText != null)
                  Expanded(
                    child: AppText(
                      leadingText!,
                      style: AppTextStyle.style12Light.copyWith(
                        color: context.skin.textSecondary,
                      ),
                    ),
                  ),
              ],
            )
          : leading,
      title: buildTitle(),
      actions: actions,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      bottom: bottom,
      shape: hasBorder
          ? Border(bottom: BorderSide(color: context.skin.appBarDivider))
          : const Border(bottom: BorderSide(color: Colors.transparent)),
    );
  }

  Widget? buildTitle() {
    if (title != null) {
      return title!;
    }

    if (titleText != null) {
      return AppText(
        titleText!,
        style: _isSub
            ? AppTextStyle.style16SemiBold
            : AppTextStyle.style20SemiBold,
      );
    }

    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? 56 : 56 + 50);
}
