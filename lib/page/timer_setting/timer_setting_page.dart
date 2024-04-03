import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/const/color.dart';
import 'package:reminder/const/font.dart';
import 'package:reminder/utils/widgets/appbar.dart';
import 'package:reminder/utils/widgets/button.dart';

class TimerSettingPage extends StatelessWidget {
  const TimerSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Timer Settings"),
      backgroundColor: bg1Color,
      body: Column(
        children: [
          TimerSettingTile(
            time: const TimeOfDay(hour: 0, minute: 55),
            title: "Cycle",
            changeSetting: () {
              showDialog(
                context: context,
                builder: (_) => const TimeSettingDialog(),
              );
            },
          ),
          TimerSettingTile(
            time: const TimeOfDay(hour: 0, minute: 55),
            title: "Break Time",
            changeSetting: () {},
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

class TimeSettingDialog extends StatelessWidget {
  const TimeSettingDialog({super.key});

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
                    child: _picker(),
                  ),
                  Text(
                    ":",
                    style: bodytext2.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: _picker(),
                  ),
                  Text(
                    ":",
                    style: bodytext2.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: _picker(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buttons()
          ],
        ),
      ),
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            buttonSize: ButtonSize.size40,
            onPressed: () {},
            title: 'Cancel',
            isEnable: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PrimaryButton(
            buttonSize: ButtonSize.size40,
            onPressed: () {},
            title: 'Save',
            isEnable: true,
          ),
        )
      ],
    );
  }

  Widget _picker() {
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
      onSelectedItemChanged: (e) {},
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
