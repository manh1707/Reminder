import 'package:shared_preferences/shared_preferences.dart';

const String cycleTimeKey = "cycleTimeKey";
const String breakTimeKey = "breakTimeKey";

class StorageHelper {
  static Future<void> saveCyCleSettings(int value) async {
    final sharedInstances = await SharedPreferences.getInstance();
    sharedInstances.setInt(cycleTimeKey, value);
  }

  static Future<void> saveBreakTimeSettings(int value) async {
    final sharedInstances = await SharedPreferences.getInstance();
    sharedInstances.setInt(breakTimeKey, value);
  }

  static Future<int> getCycleSettings() async {
    final sharedInstances = await SharedPreferences.getInstance();
    return sharedInstances.getInt(cycleTimeKey) ?? 45;
  }

  static Future<int> getBreakTimeSettings() async {
    final sharedInstances = await SharedPreferences.getInstance();
    return sharedInstances.getInt(breakTimeKey) ?? 5;
  }
}
