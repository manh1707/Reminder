import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/const/color.dart';
import 'package:reminder/const/font.dart';
import 'package:reminder/helper/alarm_helper.dart';
import 'package:reminder/helper/storage_helpe.dart';
import 'package:reminder/utils/widgets/appbar.dart';
import 'package:reminder/utils/widgets/button.dart';

class TimerSettingPage extends StatefulWidget {
  const TimerSettingPage({super.key});

  @override
  State<TimerSettingPage> createState() => _TimerSettingPageState();
}

class _TimerSettingPageState extends State<TimerSettingPage> {
  int cycleSetting = 0;
  int breakSetting = 0;
  void saveAlarm() async {
    final cycleTime = await StorageHelper.getCycleSettings();
    final breakTime = await StorageHelper.getBreakTimeSettings();
    final breakDuration = Duration(minutes: breakTime);
    final cycleDuration = Duration(minutes: cycleTime);
    AlarmHelper.caculateStartTime(
        breakTime: breakDuration, cycleTime: cycleDuration);
  }

  @override
  void initState() {
    super.initState();
    getSetting();
  }

  void getSetting() async {
    cycleSetting = await StorageHelper.getCycleSettings();
    breakSetting = await StorageHelper.getBreakTimeSettings();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Timer Settings"),
      backgroundColor: bg1Color,
      body: Column(
        children: [
          TimerSettingTile(
            time: TimeOfDay(
              hour: cycleSetting ~/ 60,
              minute: (cycleSetting % 60).toInt(),
            ),
            title: "Cycle",
            changeSetting: () {
              showDialog(
                context: context,
                builder: (_) => TimeSettingDialog(onSave: (duration) async {
                  await StorageHelper.saveCyCleSettings(duration.inMinutes);
                  saveAlarm();
                }),
              );
            },
          ),
          TimerSettingTile(
            time: TimeOfDay(
              hour: breakSetting ~/ 60,
              minute: (breakSetting % 60).toInt(),
            ),
            title: "Break Time",
            changeSetting: () {
              showDialog(
                context: context,
                builder: (_) => TimeSettingDialog(onSave: (duration) async {
                  await StorageHelper.saveBreakTimeSettings(duration.inMinutes);
                  saveAlarm();
                }),
              );
            },
          )
        ],
      ),
    );
  }
}

class TimerSettingTile extends StatelessWidget {
  const TimerSettingTile({
    super.key,
    required this.title,
    required this.changeSetting,
    required this.time,
  });
  final String title;
  final TimeOfDay time;
  final VoidCallback changeSetting;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: bodytext2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: changeSetting,
                child: Text(
                  "Change",
                  style: bodytext1.copyWith(
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: neutualShapeColor10,
            ),
            child: Text(
              "${time.hour.toString().padLeft(2, '0')} : ${time.minute.toString().padLeft(2, '0')}",
              style: heading1.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

const double _kItemExtent = 40;

class TimeSettingDialog extends StatefulWidget {
  const TimeSettingDialog({super.key, required this.onSave});
  final Function(Duration duration) onSave;
  @override
  State<TimeSettingDialog> createState() => _TimeSettingDialogState();
}

class _TimeSettingDialogState extends State<TimeSettingDialog> {
  int hour = 0;
  int minute = 0;
  int second = 0;
  void saveSetting() {
    final duration = Duration(hours: hour, minutes: minute, seconds: second);
    widget.onSave(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Timer setting",
              style: bodytext2.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: _picker(
                      onSelectedItemChanged: (value) {
                        hour = value;
                      },
                    ),
                  ),
                  Text(
                    ":",
                    style: bodytext2.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: _picker(
                      onSelectedItemChanged: (value) {
                        minute = value;
                      },
                    ),
                  ),
                  Text(
                    ":",
                    style: bodytext2.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: _picker(
                      onSelectedItemChanged: (value) {
                        second = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buttons(context)
          ],
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            buttonSize: ButtonSize.size40,
            onPressed: () {
              saveSetting();
              Navigator.of(context).pop();
            },
            title: 'Cancel',
            isEnable: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PrimaryButton(
            buttonSize: ButtonSize.size40,
            onPressed: () {
              saveSetting();
              Navigator.of(context).pop();
            },
            title: 'Save',
            isEnable: true,
          ),
        )
      ],
    );
  }

  Widget _picker({required Function(int) onSelectedItemChanged}) {
    const divider = SizedBox(
      width: 42,
      child: Divider(
        height: 1,
        thickness: 1,
        color: primaryColor,
      ),
    );
    return CupertinoPicker(
      itemExtent: _kItemExtent,
      looping: true,
      onSelectedItemChanged: onSelectedItemChanged,
      selectionOverlay: const Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 1,
          ),
          divider,
          Spacer(),
          divider,
          SizedBox(
            height: 1,
          )
        ],
      ),
      children: List.from([for (var i = 0; i < 60; i++) i])
          .map(
            (e) => Center(
              child: Text(
                e.toString(),
                style: heading3.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          )
          .toList(),
    );
  }
}
