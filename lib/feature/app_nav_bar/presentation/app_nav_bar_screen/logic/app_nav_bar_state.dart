part of 'app_nav_bar_cubit.dart';

sealed class AppNavBarState extends Equatable {
  const AppNavBarState();

  @override
  List<Object?> get props => [];
}

final class AppNavBarInitialState extends AppNavBarState {
  const AppNavBarInitialState();
}

final class ChangeTabSuccessState extends AppNavBarState {
  const ChangeTabSuccessState(this.tab);

  final AppNavTab tab;

  @override
  List<Object?> get props => [tab];
}
