import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/package_widgets/app_network_image.dart';
import 'package:news_task/core/widgets/page_view_dots_indicator.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';

class ArticleGallery extends StatelessWidget {
  const ArticleGallery({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleDetailsCubit>();
    if (images.isEmpty) return ColoredBox(color: context.skin.card);
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: cubit.galleryController,
          onPageChanged: cubit.changeGalleryPage,
          itemCount: images.length,
          itemBuilder: (context, index) => AppNetworkImage(
            images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            semanticLabel:
                '${LocaleKeys.articleImage.tr()} ${index + 1}/${images.length}',
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 96,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    context.skin.background.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (images.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 14,
            child: BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
              buildWhen: (previous, current) =>
                  current is ChangeGalleryPageSuccessState,
              builder: (context, state) => PageViewDotsIndicator(
                pageCount: images.length,
                currentPageIndex: cubit.galleryIndex.toDouble(),
              ),
            ),
          ),
      ],
    );
  }
}
