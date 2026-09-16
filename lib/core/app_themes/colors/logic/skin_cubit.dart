import 'dart:ui';

import 'package:news_task/core/app_themes/colors/app_skin.dart';
import 'package:news_task/core/app_themes/colors/dark_skin.dart';
import 'package:news_task/core/app_themes/colors/light_skin.dart';
import 'package:news_task/core/helpers/cache/cache_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'skin_state.dart';

class SkinCubit extends Cubit<SkinState> with WidgetsBindingObserver {
  SkinCubit() : skin = _resolveSkin(), super(const SkinInitialState()) {
    WidgetsBinding.instance.addObserver(this);
  }

  AppSkin skin;

  bool get followsSystem => CacheHelper.get(CacheKeys.currentTheme) == null;

  ThemeMode get preference => followsSystem ? ThemeMode.system : skin.themeMode;

  static AppSkin _resolveSkin() {
    final saved = CacheHelper.get(CacheKeys.currentTheme);
    if (saved == ThemeMode.dark.name) return const DarkSkin();
    if (saved == ThemeMode.light.name) return const LightSkin();
    return _systemSkin();
  }

  static AppSkin _systemSkin() =>
      PlatformDispatcher.instance.platformBrightness == Brightness.dark
      ? const DarkSkin()
      : const LightSkin();

  @override
  void didChangePlatformBrightness() {
    if (!followsSystem) return;
    _apply(_systemSkin());
  }

  void setSkin(AppSkin newSkin) {
    CacheHelper.save(CacheKeys.currentTheme, newSkin.themeMode.name);
    _apply(newSkin);
  }

  void followSystem() {
    CacheHelper.remove(CacheKeys.currentTheme);
    _apply(_systemSkin());
  }

  void setPreference(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        followSystem();
      case ThemeMode.light:
        setSkin(const LightSkin());
      case ThemeMode.dark:
        setSkin(const DarkSkin());
    }
  }

  void toggleSkin() {
    setSkin(
      skin.themeMode == ThemeMode.dark ? const LightSkin() : const DarkSkin(),
    );
  }

  void _apply(AppSkin newSkin) {
    skin = newSkin;
    emit(SkinChangedState(newSkin, preference));
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}

extension SkinSwitcherContext on BuildContext {
  void setSkin(AppSkin skin) => read<SkinCubit>().setSkin(skin);

  void followSystemSkin() => read<SkinCubit>().followSystem();

  void setSkinPreference(ThemeMode mode) =>
      read<SkinCubit>().setPreference(mode);

  void toggleSkin() => read<SkinCubit>().toggleSkin();
}
