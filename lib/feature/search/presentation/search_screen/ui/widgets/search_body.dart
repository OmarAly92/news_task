import 'package:flutter/material.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_content.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_field.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_filter_bar.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_suggestions_row.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    children: [
      SearchField(),
      SearchFilterBar(),
      SearchSuggestionsRow(),
      Expanded(child: SearchContent()),
    ],
  );
}
