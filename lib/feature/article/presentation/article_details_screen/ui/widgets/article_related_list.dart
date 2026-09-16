import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_routes/routes_strings.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_related_card.dart';

class ArticleRelatedList extends StatelessWidget {
  const ArticleRelatedList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleDetailsCubit>();
    return BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
      buildWhen: (previous, current) => current is GetRelatedSuccessState,
      builder: (context, state) {
        if (cubit.related.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpace(24),
            Padding(
              padding: AppConstants.horizontalPaddingEdge,
              child: AppText(
                LocaleKeys.relatedStories.tr(),
                style: AppTextStyle.headingSm,
              ),
            ),
            const VerticalSpace(12),
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: AppConstants.horizontalPaddingEdge,
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.related.length,
                separatorBuilder: (_, _) => const HorizontalSpace(12),
                itemBuilder: (context, index) {
                  final item = cubit.related[index];
                  return ArticleRelatedCard(
                    title: item.title ?? '',
                    source: item.source ?? '',
                    imageUrl: item.image,
                    onTap: () => context.pushNamed(
                      RoutesStrings.articleDetailsScreen,
                      arguments: item.id,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
