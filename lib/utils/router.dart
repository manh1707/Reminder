import 'package:flutter/material.dart';
import 'package:reminder/page/standup_page.dart';
import 'package:reminder/page/timer_setting.dart';

class AppRoutepath {
  static const String home = '/home';
  static const String timerSetting = '/timerSetting';
}

class MyAppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutepath.home:
        return MaterialPageRoute(builder: (ctx) => const StandUpPage());
      case AppRoutepath.timerSetting:
        return MaterialPageRoute(builder: (ctx) => const TimerSettingPage());
      default:
        return MaterialPageRoute(builder: (ctx) => const StandUpPage());
    }
  }
}
