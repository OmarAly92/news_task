import 'package:flutter/material.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/primary_button.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

sealed class AppDialogs {
  static void showErrorDialog(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: AppText(
            message,
            // style: AppTextStyle.style18Weight600,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                // textStyle: AppTextStyle.style16Weight600,
              ),
              child: const AppText('Ok'),
            ),
          ],
        );
      },
    );
  }

  static void showSuccessDialog(
    BuildContext context, {
    required String message,
    Function()? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              // AppAssetsImage(
              //   AppAsset.successImage,
              //   height: 160.sp,
              //   width: 160.sp,
              // ),
              const VerticalSpace(5),
              AppText(
                message,
                // style: AppTextStyle.style16Weight600,
              ),
            ],
          ),
          actions: [
            PrimaryButton.expand(
              onPressed: onPressed ?? () => context.pop(),
              // text: LocaleKeys.ok.tr(),
              text: 'LocaleKeys.ok.tr()',
            ),
          ],
        );
      },
    );
  }
}
