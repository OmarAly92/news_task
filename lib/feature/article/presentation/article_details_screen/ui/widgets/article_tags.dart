import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/widgets/app_badge.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';

class ArticleTags extends StatelessWidget {
  const ArticleTags({super.key});

  @override
  Widget build(BuildContext context) {
    final tags = context.read<ArticleDetailsCubit>().article?.tags ?? [];
    if (tags.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final tag in tags)
            AppBadge.neutral(text: tag, icon: Icons.tag_rounded),
        ],
      ),
    );
  }
}
