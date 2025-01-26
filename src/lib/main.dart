import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:mudakir/app.dart';
import 'package:mudakir/services/app_version.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppVersion.appData = packageInfo.data;

  AppVersion.data = await SharedPreferences.getInstance();  
  String? localeName = AppVersion.data!.getString("preferredLocale");
  Locale? locale = localeName != null ? Locale(localeName) : null;

  AppVersion.log("com.github.devsnaith.mudakir.main", "Pre-Run saved locale: $localeName");

  AdaptiveThemeMode? themeMode = await AdaptiveTheme.getThemeMode();
  String? themeSeed = AppVersion.data!.getString("ThemeColorSchemeSeed");
  AppVersion.log("com.github.devsnaith.mudakir.main", "Pre-Run saved theme: $themeMode, ${themeSeed ?? "Unkown"}");
  
  runApp(Mudakir((themeMode) ?? AdaptiveThemeMode.system, 
    locale, themeSeed != null ? Color(int.parse(themeSeed, radix: 16)): null));
  
}