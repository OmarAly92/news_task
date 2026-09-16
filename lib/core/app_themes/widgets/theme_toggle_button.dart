import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/logic/skin_cubit.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/widgets/theme_picker_sheet.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  IconData _iconFor(ThemeMode preference) => switch (preference) {
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
    ThemeMode.system => Icons.brightness_auto_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    return BlocBuilder<SkinCubit, SkinState>(
      builder: (context, state) {
        final preference = context.read<SkinCubit>().preference;
        return Semantics(
          button: true,
          label: LocaleKeys.themeToggle.tr(),
          child: Material(
            color: Colors.transparent,
            child: AppInkWell(
              onTap: () => ThemePickerSheet.show(context),
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: skin.card,
                    shape: BoxShape.circle,
                    border: Border.all(color: skin.cardBorder),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: Icon(
                      _iconFor(preference),
                      key: ValueKey(preference),
                      size: 20,
                      color: skin.appBarIcon,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
