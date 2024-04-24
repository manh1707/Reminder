import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class AlarmHelper {
  static Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    print('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      print('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      print(
          'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
    }
  }

  static void caculateStartTime(
      {required Duration breakTime, required Duration cycleTime}) {
    //8h working time
    final n = (60 * 8) / (cycleTime.inMinutes + breakTime.inMinutes);
    DateTime startTime = DateTime.now().copyWith(hour: 9, minute: 0, second: 0);
    for (var i = 0; i < n; i++) {
      startTime = startTime.add(cycleTime);
      final alarmTime = startTime.add(cycleTime);
      startTime = startTime.add(breakTime);
      setAlarm(alarmTime, i + 1);
    }
  }

  static setAlarm(DateTime alarmTime, int id) async {
    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: alarmTime,
      assetAudioPath: 'assets/audio/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'Dậy đi',
      notificationBody: 'Thức tỉnh đi',
      enableNotificationOnKill: true,
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }

  static void stopAlarm() async {
    // Alarm.stop(1);
  }
}
