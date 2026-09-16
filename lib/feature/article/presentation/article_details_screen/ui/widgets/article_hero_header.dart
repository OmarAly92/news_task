import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/widgets/app_pop_icon.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_collapsed_title.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_gallery.dart';

class ArticleHeroHeader extends StatelessWidget {
  const ArticleHeroHeader({super.key});

  static const double _expandedHeight = 340;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final article = context.read<ArticleDetailsCubit>().article;
    final images = article?.images ?? [];
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: images.isEmpty ? 0 : _expandedHeight,
      backgroundColor: skin.background,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 64,
      leading: Center(
        child: Material(
          color: skin.surface.withValues(alpha: 0.9),
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: const AppPopIcon(),
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = MediaQuery.paddingOf(context).top;
          final collapsedHeight = kToolbarHeight + topPadding;
          final progress = images.isEmpty
              ? 1.0
              : 1 -
                    ((constraints.maxHeight - collapsedHeight) /
                            (_expandedHeight - kToolbarHeight))
                        .clamp(0.0, 1.0);
          return Stack(
            fit: StackFit.expand,
            children: [
              FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                background: ArticleGallery(images: images),
              ),
              Positioned(
                top: topPadding,
                left: 64,
                right: 16,
                height: kToolbarHeight,
                child: ArticleCollapsedTitle(
                  title: article?.title ?? '',
                  progress: progress,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
