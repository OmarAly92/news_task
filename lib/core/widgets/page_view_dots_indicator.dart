import 'package:news_task/core/widgets/dot_item.dart';
import 'package:flutter/material.dart';

class PageViewDotsIndicator extends StatelessWidget {
  const PageViewDotsIndicator({
    super.key,
    required this.pageCount,
    required this.currentPageIndex,
  });

  final int pageCount;
  final double currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return DotItem(isActive: index == currentPageIndex.round());
      }),
    );
  }
}
