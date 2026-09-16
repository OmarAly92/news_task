import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.isCentered = false, this.strokeWidth = 4})
    : isPagination = false;

  const AppLoader.center({super.key, this.strokeWidth = 4})
    : isCentered = true,
      isPagination = false;

  const AppLoader.pagination({super.key, this.strokeWidth = 4})
    : isCentered = true,
      isPagination = true;

  final bool isCentered;
  final bool isPagination;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    if (isPagination) {
      return const CupertinoActivityIndicator();
    }
    if (isCentered) {
      return Center(child: buildNewCircularProgressIndicator(context));
    }
    return buildNewCircularProgressIndicator(context);
  }

  // The expressive indicator is a morphing filled shape rather than a stroked
  // arc, so [strokeWidth] has no counterpart here.
  Widget buildNewCircularProgressIndicator(BuildContext context) {
    return LoadingIndicator(activeIndicatorColor: context.skin.loader);
  }

  CircularProgressIndicator buildOldCircularProgressIndicator(
    BuildContext context,
  ) {
    return CircularProgressIndicator(
      color: context.skin.loader,
      strokeWidth: strokeWidth,
    );
  }
}
