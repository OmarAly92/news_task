import 'package:flutter/material.dart';
import 'package:news_task/core/widgets/main_widgets/app_scaffold.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/ui/widgets/app_bottom_nav_bar.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/ui/widgets/app_nav_bar_body.dart';

class AppNavBarScreen extends StatelessWidget {
  const AppNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: AppNavBarBody(),
      bottomNavigationBar: AppBottomNavBar(),
    );
  }
}
