import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';

class PaginationWidget<T extends Cubit> extends StatelessWidget {
  final int totalItems;
  final int visibleCount;
  final Function(int page) onPageChanged;
  final T cubit;

  const PaginationWidget({
    super.key,
    required this.totalItems,
    this.visibleCount = 5,
    required this.onPageChanged,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final dynamic cubitInstance = cubit;

    int startPage = cubitInstance.currentPage - (visibleCount ~/ 2);
    if (startPage < 1) startPage = 1;

    int endPage = startPage + visibleCount - 1;
    if (endPage > totalItems) {
      endPage = totalItems;
      startPage = totalItems - visibleCount + 1;
      if (startPage < 1) startPage = 1;
    }

    final List<int> pages = List.generate(
      endPage - startPage + 1,
      (index) => startPage + index,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Arrow
        IconButton(
          onPressed: cubitInstance.currentPage > 1
              ? () {
                  cubitInstance.changePageInPagination(
                    cubitInstance.currentPage - 1,
                  );
                  onPageChanged(cubitInstance.currentPage);
                }
              : null,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        // Page Numbers
        ...pages.map((page) {
          return GestureDetector(
            onTap: () {
              cubitInstance.changePageInPagination(page);
              onPageChanged(cubitInstance.currentPage);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: page == cubitInstance.currentPage
                    ? context.skin.pageIndicatorActive
                    : context.skin.tileIconBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppText(
                page.toString(),
                style: TextStyle(
                  color: page == cubitInstance.currentPage
                      ? context.skin.textOnPrimary
                      : context.skin.textPrimary,
                ),
              ),
            ),
          );
        }),
        // Right Arrow
        IconButton(
          onPressed: cubitInstance.currentPage < totalItems
              ? () {
                  cubitInstance.changePageInPagination(
                    cubitInstance.currentPage + 1,
                  );
                  onPageChanged(cubitInstance.currentPage);
                }
              : null,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
