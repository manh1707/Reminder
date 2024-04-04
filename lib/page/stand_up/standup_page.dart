import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reminder/const/assets.dart';
import 'package:reminder/const/color.dart';
import 'package:reminder/const/font.dart';
import 'package:reminder/page/stand_up/widget/bg_paint.dart';
import 'package:reminder/utils/router.dart';
import 'package:reminder/utils/widgets/appbar.dart';

class StandUpPage extends StatelessWidget {
  const StandUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: const CustomAppbar(title: "Standup"),
      drawer: _drawer(context),
      body: Column(
        children: [
          // CustomPaint(
          //   painter: BgPaint2(),
          //   child: Center(
          //     child: SizedBox(
          //       height: 200,
          //       child: Center(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Stand up after:",
          //               style: bodytext1.copyWith(fontWeight: FontWeight.w700),
          //             ),
          //             Text(
          //               "21:05",
          //               style: heading1.copyWith(fontWeight: FontWeight.bold),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Stack(
            children: [
              CustomPaint(
                painter: BgPaint2(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0.5,
                    sigmaY: 0.5,
                  ),
                  child: Center(
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(),
                      clipBehavior: Clip.none,
                    ),
                  ),
                ),
              ),
            ],
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
