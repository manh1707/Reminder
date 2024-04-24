import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:reminder/const/assets.dart';
import 'package:reminder/const/color.dart';
import 'package:reminder/const/font.dart';
import 'package:reminder/helper/alarm_helper.dart';
import 'package:reminder/helper/storage_helpe.dart';
import 'package:reminder/page/stand_up/widget/bg_paint.dart';
import 'package:reminder/utils/router.dart';
import 'package:reminder/utils/widgets/appbar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class StandUpPage extends StatefulWidget {
  const StandUpPage({super.key});

  @override
  State<StandUpPage> createState() => _StandUpPageState();
}

class _StandUpPageState extends State<StandUpPage> {
  int countDown = 0;
  int cycleTime = 0;
  int breakTime = 0;
  bool isStanding = false;
  @override
  void initState() {
    super.initState();
    AlarmHelper.checkAndroidScheduleExactAlarmPermission();
    // AlarmHelper.stopAlarm();
    Alarm.ringStream.stream.listen((event) async {
      if (await Alarm.isRinging(event.id)) {
        Alarm.stop(event.id);
      }
    });
    setUpCountDown();
  }

  void setUpCountDown() async {
    cycleTime = await StorageHelper.getCycleSettings();
    breakTime = await StorageHelper.getBreakTimeSettings();
    int nowHour = DateTime.now().hour;
    if (nowHour < 9) {
      return;
    }
    nowHour = nowHour - 9;
    final nowMinute = DateTime.now().minute;
    final nowSecond = DateTime.now().second;
    final compareInt = Duration(hours: nowHour, minutes: nowMinute).inMinutes;
    final n = compareInt % (cycleTime + breakTime);
    if (n < cycleTime) {
      isStanding = false;
      countDown = (cycleTime - n - 1) * 60 + 60 - nowSecond;
    } else {
      isStanding = true;
      countDown = (breakTime - n - 1) * 60 + 60 - nowSecond;
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown == 0) {
        setUpCountDown();
        timer.cancel();
      }
      countDown--;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: const CustomAppbar(title: "Standup"),
      drawer: _drawer(context),
      body: Column(
        children: [
          SizedBox(
            height: 350,
            width: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Image.asset(
                    MyImageAssets.group4,
                    // color: Colors.black,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Image.asset(
                    MyImageAssets.group3,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: screenSize.width / 2 - 96,
                  child: Container(
                    height: 192,
                    width: 192,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: Center(
                        child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 20,
                          child: SleekCircularSlider(
                            min: 0,
                            max: 100,
                            initialValue: isStanding
                                ? (countDown / (breakTime * 60)) * 100
                                : (countDown / (cycleTime * 60)) * 100,
                            appearance: CircularSliderAppearance(
                              customWidths: CustomSliderWidths(
                                trackWidth: 10,
                                progressBarWidth: 10,
                                shadowWidth: 0,
                              ),
                              customColors: CustomSliderColors(
                                dotColor: neutualShapeColor10,
                                trackColor:
                                    neutualShapeColor10.withOpacity(0.3),
                                progressBarColor: neutualShapeColor10,
                                shadowColor: neutualShapeColor10,
                                shadowMaxOpacity: 0.3,
                              ),

                              // startAngle: 270,
                              // angleRange: 360,
                              // size: 210.0,
                              animationEnabled: false,
                            ),
                            innerWidget: (percentage) => Center(
                              child: Text(
                                isStanding
                                    ? "Continue to work"
                                    : "You are sitting now",
                                style: bodytext1.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: neutualShapeColor10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                // Positioned(
                //   bottom: 70,
                //   child: SizedBox(
                //     height: 200,
                //     width: MediaQuery.of(context).size.width,
                //     child: CustomPaint(
                //       painter: BgPaint2(),
                //       child: Center(
                //         child: Container(
                //           height: 200,
                //           decoration: const BoxDecoration(),
                //           clipBehavior: Clip.none,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  bottom: -30,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter: BgPaint1(),
                      child: Center(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Stand up after:",
                                style: bodytext1.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "${countDown ~/ 60}:${(countDown % 60).toInt() < 10 ? "0${countDown % 60}" : countDown % 60}",
                                style: heading1.copyWith(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _buildBody(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 120),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(MyImageAssets.centerCireclePath),
              Text(
                'You are sitting now',
                style: bodytext1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: neutualShapeColor10,
                ),
              ),
            ],
          ),
        ),
        Image.asset(MyImageAssets.middleLayer, width: screenSize.width),
      ],
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 60),
          ListTile(
            title: Text(
              'MENU',
              style: heading3.copyWith(
                color: neutualShapeColor10,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          _buildDrawerOption(
            title: "Timer settings",
            iconAsset: MyIconAssets.clock,
            ontap: () {
              Navigator.pushNamed(context, AppRoutepath.timerSetting);
            },
          ),
          // ListTile(
          //   title: const Text('Item 2'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  _buildDrawerOption({
    required String title,
    required String iconAsset,
    required VoidCallback ontap,
  }) {
    return ListTile(
      title: Row(
        children: [
          Image.asset(
            iconAsset,
            color: neutualShapeColor10,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: bodytext2.copyWith(
              color: neutualShapeColor10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      onTap: ontap,
    );
  }
}
