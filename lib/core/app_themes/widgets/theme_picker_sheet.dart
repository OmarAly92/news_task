import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/logic/skin_cubit.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/app_bottom_sheet.dart';
import 'package:news_task/core/widgets/bottom_sheet_container.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class ThemePickerSheet extends StatelessWidget {
  const ThemePickerSheet({super.key, required this.cubit});

  final SkinCubit cubit;

  static Future<void> show(BuildContext context) {
    final cubit = context.read<SkinCubit>();
    return showAppSheet<void>(
      context: context,
      builder: (_) => ThemePickerSheet(cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: cubit,
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.horizontalPadding,
          12,
          AppConstants.horizontalPadding,
          16,
        ),
        child: BlocBuilder<SkinCubit, SkinState>(
          builder: (context, state) {
            final selected = cubit.preference;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BottomSheetContainer.centered(),
                const VerticalSpace(16),
                AppText(
                  LocaleKeys.appearance.tr(),
                  style: AppTextStyle.headingSm,
                ),
                const VerticalSpace(4),
                AppText(
                  LocaleKeys.appearanceSubtitle.tr(),
                  style: AppTextStyle.style14Regular.copyWith(
                    color: context.skin.textSecondary,
                  ),
                ),
                const VerticalSpace(20),
                _ThemeOptionTile(
                  mode: ThemeMode.light,
                  icon: Icons.light_mode_rounded,
                  title: LocaleKeys.themeLight.tr(),
                  subtitle: LocaleKeys.themeLightDescription.tr(),
                  isSelected: selected == ThemeMode.light,
                  onTap: () => _select(context, ThemeMode.light),
                ),
                const VerticalSpace(10),
                _ThemeOptionTile(
                  mode: ThemeMode.dark,
                  icon: Icons.dark_mode_rounded,
                  title: LocaleKeys.themeDark.tr(),
                  subtitle: LocaleKeys.themeDarkDescription.tr(),
                  isSelected: selected == ThemeMode.dark,
                  onTap: () => _select(context, ThemeMode.dark),
                ),
                const VerticalSpace(10),
                _ThemeOptionTile(
                  mode: ThemeMode.system,
                  icon: Icons.brightness_auto_rounded,
                  title: LocaleKeys.themeSystem.tr(),
                  subtitle: LocaleKeys.themeSystemDescription.tr(),
                  isSelected: selected == ThemeMode.system,
                  onTap: () => _select(context, ThemeMode.system),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );

  void _select(BuildContext context, ThemeMode mode) {
    cubit.setPreference(mode);
    context.pop();
  }
}

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.mode,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final ThemeMode mode;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final radius = BorderRadius.circular(AppConstants.radiusXl);
    return Semantics(
      button: true,
      selected: isSelected,
      label: '$title. $subtitle',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected ? skin.primaryLight : skin.card,
          borderRadius: radius,
          border: Border.all(
            color: isSelected ? skin.primary : skin.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: AppInkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected ? skin.primary : skin.surfaceElevated,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 22,
                      color: isSelected ? skin.textOnPrimary : skin.tileIcon,
                    ),
                  ),
                  const HorizontalSpace(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          title,
                          style: AppTextStyle.style16SemiBold.copyWith(
                            color: skin.textPrimary,
                          ),
                        ),
                        const VerticalSpace(2),
                        AppText(
                          subtitle,
                          style: AppTextStyle.style12Regular.copyWith(
                            color: skin.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HorizontalSpace(8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: isSelected
                        ? Icon(
                            Icons.check_circle_rounded,
                            key: const ValueKey('selected'),
                            color: skin.primaryDark,
                            size: 22,
                          )
                        : Icon(
                            Icons.circle_outlined,
                            key: const ValueKey('unselected'),
                            color: skin.borderStrong,
                            size: 22,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
