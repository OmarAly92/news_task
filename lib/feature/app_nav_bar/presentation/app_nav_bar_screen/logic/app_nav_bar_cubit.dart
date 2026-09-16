import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/logic/app_nav_tab.dart';

part 'app_nav_bar_state.dart';

class AppNavBarCubit extends Cubit<AppNavBarState> {
  AppNavBarCubit() : super(const AppNavBarInitialState());

  AppNavTab currentTab = AppNavTab.feed;

  void changeTab(AppNavTab tab) {
    if (tab == currentTab) return;
    currentTab = tab;
    emit(ChangeTabSuccessState(tab));
  }
}
