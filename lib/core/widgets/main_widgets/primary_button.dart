import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/animation/tap_bounce_effect.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_svg_image.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.borderRadius,
    required this.onPressed,
    this.isExpand = false,
    this.padding,
    this.isLoading = false,
    this.fixedSize,
    this.svgIconPath,
    this.icon,
    this.trailingIcon,
    this.glowColor,
  });

  const PrimaryButton.expand({
    super.key,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.borderRadius,
    required this.onPressed,
    this.isExpand = true,
    this.padding,
    this.isLoading = false,
    this.fixedSize,
    this.svgIconPath,
    this.icon,
    this.trailingIcon,
    this.glowColor,
  });

  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final Size? fixedSize;
  final bool isExpand;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onPressed;
  final String? svgIconPath;
  final Widget? icon;
  final Widget? trailingIcon;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    if (isExpand) {
      return SizedBox(
        height: 50,
        child: TapBounceEffect(
          child: Row(
            children: [
              Expanded(
                child: buildGlowingButton(
                  context,
                  ElevatedButton(
                    style: buildButtonStyleFrom(context),
                    onPressed: isLoading ? () {} : onPressed,
                    child: isLoading
                        ? Center(
                            child: SpinKitThreeBounce(
                              color: context.skin.buttonLoader,
                              size: 35,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (icon != null) ...[
                                icon!,
                                const HorizontalSpace(8),
                              ],
                              AppText(
                                text,
                                style:
                                    textStyle ??
                                    AppTextStyle.style16SemiBold.copyWith(
                                      color:
                                          textColor ?? context.skin.buttonText,
                                    ),
                              ),
                              if (trailingIcon != null) ...[
                                const HorizontalSpace(8),
                                trailingIcon!,
                              ],
                              if (svgIconPath != null) ...[
                                const HorizontalSpace(8),
                                AppSvgImage(
                                  color: context.skin.buttonIcon,
                                  path: svgIconPath!,
                                ),
                              ],
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return TapBounceEffect(
        child: buildGlowingButton(
          context,
          ElevatedButton(
            style: buildButtonStyleFrom(context),
            onPressed: isLoading ? () {} : onPressed,
            child: isLoading
                ? SpinKitThreeBounce(color: context.skin.buttonLoader, size: 35)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[icon!, const SizedBox(width: 8)],
                      AppText(
                        text,
                        style:
                            textStyle ??
                            AppTextStyle.style16SemiBold.copyWith(
                              color: textColor ?? context.skin.buttonText,
                            ),
                      ),
                      if (trailingIcon != null) ...[
                        const SizedBox(width: 8),
                        trailingIcon!,
                      ],
                      if (svgIconPath != null) ...[
                        const SizedBox(width: 8),
                        AppSvgImage(
                          color: context.skin.buttonIcon,
                          path: svgIconPath!,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Widget buildGlowingButton(BuildContext context, Widget button) {
    if (onPressed == null) return button;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? AppConstants.borderRadiusCircularButton,
        boxShadow: [
          BoxShadow(
            color: glowColor ?? context.skin.primaryGlow,
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: button,
    );
  }

  ButtonStyle buildButtonStyleFrom(BuildContext context) {
    return ElevatedButton.styleFrom(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
      fixedSize: fixedSize ?? const Size.fromHeight(50),
      foregroundColor: foregroundColor ?? context.skin.buttonText,
      backgroundColor: backgroundColor ?? context.skin.buttonBackground,
      elevation: 0,
      disabledBackgroundColor:
          backgroundColor ?? context.skin.buttonDisabledBackground,
      disabledForegroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppConstants.borderRadiusCircularButton,
      ),
    );
  }
}
