import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/topic_icons.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/suggestion_chip.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';

class FeedTopicChips extends StatelessWidget {
  const FeedTopicChips({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedCubit>();
    return BlocBuilder<FeedCubit, FeedState>(
      buildWhen: (previous, current) =>
          current is GetTopicsSuccessState ||
          current is SelectTopicSuccessState,
      builder: (context, state) => SizedBox(
        height: 56,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding,
            vertical: 4,
          ),
          children: [
            SuggestionChip(
              text: LocaleKeys.allTopics.tr(),
              isSelected: cubit.selectedTopicId == null,
              onTap: () => cubit.selectTopic(null),
            ),
            for (final topic in cubit.topics) ...[
              const HorizontalSpace(8),
              SuggestionChip(
                text: topic.name ?? '',
                icon: TopicIcons.resolve(topic.icon),
                isSelected: cubit.selectedTopicId == topic.id,
                onTap: () => cubit.selectTopic(topic.id),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
