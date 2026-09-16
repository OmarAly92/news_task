import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/package_widgets/app_shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
    this.imageUrl, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.errorWidget,
    this.placeholder,
    this.semanticLabel,
  });

  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final LoadingErrorWidgetBuilder? errorWidget;
  final PlaceholderWidgetBuilder? placeholder;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.contain,
      width: width ?? context.width,
      height: height ?? context.width,
      errorWidget:
          errorWidget ??
          (context, url, error) => const Icon(Icons.broken_image_outlined),
      placeholder:
          placeholder ??
          (context, url) =>
              AppShimmer(child: ColoredBox(color: context.skin.shimmerBase)),
    );
    if (semanticLabel == null) return ExcludeSemantics(child: image);
    return Semantics(image: true, label: semanticLabel, child: image);
  }
}
