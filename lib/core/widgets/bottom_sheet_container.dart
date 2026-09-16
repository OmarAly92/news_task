import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    super.key,
    this.centered = false,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });

  const BottomSheetContainer.centered({
    super.key,
    this.centered = true,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });

  final bool centered;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (centered) {
      return Center(
        child: Container(
          width: width ?? 40,
          height: height ?? 4,
          decoration: buildBoxDecoration(context),
        ),
      );
    } else {
      return Container(
        width: width ?? 40,
        height: height ?? 4,
        decoration: buildBoxDecoration(context),
      );
    }
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: color ?? context.skin.bottomSheetHandle,
      borderRadius: borderRadius ?? BorderRadius.circular(2),
    );
  }
}
