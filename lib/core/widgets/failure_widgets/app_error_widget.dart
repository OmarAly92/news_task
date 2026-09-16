import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/primary_button.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.fallbackMessage,
    this.failure,
    this.onRetry,
    this.retryLabel,
  });

  final String fallbackMessage;
  final Failure? failure;
  final void Function()? onRetry;
  final String? retryLabel;

  String get _message {
    final message = failure?.message ?? '';
    return message.isEmpty ? fallbackMessage : message;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.horizontalPadding,
        vertical: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            _message,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: AppTextStyle.bodyMd.copyWith(
              color: context.skin.textSecondary,
            ),
          ),
          if (onRetry != null) ...[
            const VerticalSpace(16),
            PrimaryButton(text: retryLabel ?? '', onPressed: onRetry),
          ],
        ],
      ),
    );
  }
}
