import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/app_themes/text_style/font_weight_helper.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';

class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    this.height = 38,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final double height;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppConstants.radiusPill);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.skin.segmentedBackground,
        borderRadius: radius,
        border: Border.all(color: context.skin.borderSubtle),
      ),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            AnimatedAlign(
              duration: AppMotion.base,
              curve: AppMotion.easeOut,
              alignment: labels.length == 1
                  ? AlignmentDirectional.center
                  : AlignmentDirectional(
                      -1 + 2 * selectedIndex / (labels.length - 1),
                      0,
                    ),
              child: FractionallySizedBox(
                widthFactor: 1 / labels.length,
                heightFactor: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.skin.segmentedThumb,
                    borderRadius: radius,
                    boxShadow: [
                      BoxShadow(
                        color: context.skin.shadow,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: List.generate(labels.length, (index) {
                final isActive = index == selectedIndex;
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(index),
                    child: Center(
                      child: AppText(
                        labels[index],
                        style: AppTextStyle.bodySm.copyWith(
                          fontWeight: FontWeightHelper.medium,
                          color: isActive
                              ? context.skin.segmentedActiveText
                              : context.skin.segmentedInactiveText,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
