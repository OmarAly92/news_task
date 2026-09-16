import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/animation/tap_bounce_effect.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_task/core/widgets/package_widgets/app_svg_image.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.textStyle,
    this.borderColor,
    this.foregroundColor,
    this.textColor,
    this.borderRadius,
    required this.onPressed,
    this.isExpand = false,
    this.padding,
    this.isLoading = false,
    this.fixedSize,
    this.svgIconPath,
    this.backgroundColor,
    this.icon,
  });

  const SecondaryButton.expand({
    super.key,
    required this.text,
    this.textStyle,
    this.borderColor,
    this.foregroundColor,
    this.textColor,
    this.borderRadius,
    required this.onPressed,
    this.isExpand = true,
    this.padding,
    this.isLoading = false,
    this.fixedSize,
    this.svgIconPath,
    this.backgroundColor,
    this.icon,
  });

  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? fixedSize;
  final bool isExpand;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onPressed;
  final String? svgIconPath;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (isExpand) {
      return SizedBox(
        height: 50,
        child: TapBounceEffect(
          child: Row(children: [Expanded(child: buildButton(context))]),
        ),
      );
    } else {
      return TapBounceEffect(child: buildButton(context));
    }
  }

  Widget buildButton(BuildContext context) {
    return ElevatedButton(
      style: buildSecondaryStyleFrom(context),
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? Center(
              child: SpinKitThreeBounce(
                color: context.skin.secondaryButtonText,
                size: 35,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 10)],
                AppText(
                  text,
                  style:
                      textStyle ??
                      AppTextStyle.style16SemiBold.copyWith(
                        color: textColor ?? context.skin.secondaryButtonText,
                      ),
                ),
                Visibility(
                  visible: svgIconPath != null,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      AppSvgImage(
                        color: context.skin.secondaryButtonText,
                        path: svgIconPath ?? '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  ButtonStyle buildSecondaryStyleFrom(BuildContext context) {
    return ElevatedButton.styleFrom(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
      fixedSize: fixedSize ?? const Size.fromHeight(50),
      foregroundColor: foregroundColor ?? context.skin.secondaryButtonText,
      backgroundColor:
          backgroundColor ?? context.skin.secondaryButtonBackground,
      elevation: 0,
      disabledBackgroundColor: context.skin.secondaryButtonBackground,
      disabledForegroundColor: foregroundColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppConstants.borderRadiusCircularButton,
        side: BorderSide(
          color: borderColor ?? context.skin.secondaryButtonBorder,
          width: 1,
        ),
      ),
    );
  }
}
