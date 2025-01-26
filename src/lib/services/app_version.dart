import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class AppVersion {
  static Map<String, dynamic> appData = {};
  static String category({String suffix = ""}) 
    => appData["packageName"] + (suffix.isNotEmpty ? ".$suffix" : "");
  static String version() => appData["version"];
  static String name() => appData["appName"];
  static SharedPreferences? data;
  static void log(String from, String message) 
    => developer.log(message, name: category(suffix: from), level: 7);
}