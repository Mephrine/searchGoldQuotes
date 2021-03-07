import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme {
  system, light, dark
}

extension Theme on AppTheme {
  String value() {
    switch(this) {
      case AppTheme.system:
        return 'system';
      case AppTheme.light:
        return 'light';
      case AppTheme.dark:
        return 'dark';
      default:
        return 'light';
    }
  }
}

class ThemeNotifier with ChangeNotifier {
  static const String KEY_THEME_MODE = 'themeMode';
  final SharedPreferences preferences;

  final darkTheme = CupertinoThemeData(

    primaryContrastingColor: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF212121),
    barBackgroundColor : Colors.white,
    textTheme: CupertinoTextThemeData(
      primaryColor: Colors.white,

    ),

  );

  final lightTheme = CupertinoThemeData(
    primaryContrastingColor: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFE5E5E5),
    barBackgroundColor: Colors.black,
    textTheme: CupertinoTextThemeData(
        primaryColor: Colors.black
    ),
  );

  CupertinoThemeData _themeData;
  CupertinoThemeData getTheme() => _themeData;

  ThemeNotifier({
    @required this.preferences
  }) {
    AppTheme themeMode = getThemeMode();
    if (themeMode == AppTheme.system) {
      themeMode = _getSystemAppTheme();
    }

    if (themeMode == AppTheme.light) {
      print('setting light theme');
      _themeData = lightTheme;
    } else {
      print('setting dark theme');
      _themeData = darkTheme;
    }
    notifyListeners();
  }

  AppTheme _getSystemAppTheme() {
    try {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.light ? AppTheme.light : AppTheme.dark;
    } catch(nullPointException) {
      return AppTheme.light;
    }
  }

  AppTheme getThemeMode() {
    String themeMode = preferences.get(KEY_THEME_MODE);
    if (null == themeMode) {
      return AppTheme.system;
    }

    if (themeMode == AppTheme.light.value()) {
      return AppTheme.light;
    } else if (themeMode == AppTheme.dark.value()) {
      return AppTheme.dark;
    }

    return AppTheme.system;
  }

  bool getThemeIsDark() {
    String themeMode = preferences.get(KEY_THEME_MODE);
    if (themeMode == AppTheme.dark.value()) {
      return true;
    }
    return false;
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    preferences.setString(KEY_THEME_MODE, AppTheme.dark.value());
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    preferences.setString(KEY_THEME_MODE, AppTheme.light.value());
    notifyListeners();
  }

  void setSystemMode() async {
    _themeData =  _getSystemAppTheme() == AppTheme.light ? lightTheme : darkTheme;
    preferences.setString(KEY_THEME_MODE, AppTheme.system.value());
    notifyListeners();
  }
}