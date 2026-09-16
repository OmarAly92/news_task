import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/text_style/font_weight_helper.dart';

class SearchHighlightedText extends StatelessWidget {
  const SearchHighlightedText({
    super.key,
    required this.text,
    required this.query,
    required this.style,
    required this.highlightColor,
    this.maxLines,
  });

  final String text;
  final String query;
  final TextStyle style;
  final Color highlightColor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final needle = query.trim().toLowerCase();
    final spans = <TextSpan>[];
    if (needle.isEmpty) {
      spans.add(TextSpan(text: text));
    } else {
      final lower = text.toLowerCase();
      var start = 0;
      var index = lower.indexOf(needle);
      while (index != -1) {
        if (index > start)
          spans.add(TextSpan(text: text.substring(start, index)));
        spans.add(
          TextSpan(
            text: text.substring(index, index + needle.length),
            style: style.copyWith(
              color: highlightColor,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
        );
        start = index + needle.length;
        index = lower.indexOf(needle, start);
      }
      if (start < text.length) spans.add(TextSpan(text: text.substring(start)));
    }
    return Text.rich(
      TextSpan(style: style, children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
