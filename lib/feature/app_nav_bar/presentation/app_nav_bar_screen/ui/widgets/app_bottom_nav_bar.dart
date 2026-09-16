import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/logic/app_nav_bar_cubit.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/logic/app_nav_tab.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/ui/widgets/app_nav_bar_item.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppNavBarCubit>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.skin.navBarBackground,
        border: Border(top: BorderSide(color: context.skin.appBarDivider)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppConstants.bottomNavBarHeight,
          child: BlocBuilder<AppNavBarCubit, AppNavBarState>(
            buildWhen: (previous, current) => current is ChangeTabSuccessState,
            builder: (context, state) => Row(
              children: [
                for (final tab in AppNavTab.values)
                  Expanded(
                    child: AppNavBarItem(
                      iconPath: tab.iconPath,
                      labelKey: tab.labelKey,
                      isActive: tab == cubit.currentTab,
                      onTap: () => cubit.changeTab(tab),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
