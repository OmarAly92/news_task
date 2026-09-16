import 'package:flutter/material.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_content.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_new_stories_pill.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_offline_banner.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_stale_banner.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_topic_chips.dart';
import 'package:news_task/feature/sync/presentation/widgets/sync_status_banner.dart';

class FeedBody extends StatelessWidget {
  const FeedBody({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    children: [
      FeedOfflineBanner(),
      SyncStatusBanner(),
      FeedStaleBanner(),
      FeedTopicChips(),
      Expanded(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [FeedContent(), FeedNewStoriesPill()],
        ),
      ),
    ],
  );
}
