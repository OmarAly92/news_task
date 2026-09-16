import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_assets.dart';

enum AppNavTab {
  feed(iconPath: AppAsset.homeIcon, labelKey: LocaleKeys.feed),
  search(iconPath: AppAsset.searchIcon, labelKey: LocaleKeys.search),
  bookmarks(iconPath: AppAsset.starIcon, labelKey: LocaleKeys.bookmarks);

  const AppNavTab({required this.iconPath, required this.labelKey});

  final String iconPath;
  final String labelKey;
}
