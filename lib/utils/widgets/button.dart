import 'package:flutter/material.dart';
import 'package:reminder/const/color.dart';
import 'package:reminder/const/font.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.buttonSize,
      required this.onPressed,
      required this.title,
      required this.isEnable});
  final ButtonSize buttonSize;
  final VoidCallback onPressed;
  final String title;
  final bool isEnable;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: buttonSize.size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: isEnable ? primaryColor : neutualShapeColor6,
      ),
      child: Text(
        title,
        style: buttonSize.textStyle.copyWith(
          color: isEnable ? neutualShapeColor10 : neutualShapeColor2,
        ),
      ),
    );
  }
}

extension ButtonSizeExtension on ButtonSize {
  double get size {
    switch (this) {
      case ButtonSize.size40:
        return 40;
      case ButtonSize.size48:
        return 48;
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case ButtonSize.size40:
        return heading4.copyWith(
            color: neutualShapeColor10, fontWeight: FontWeight.w600);
      case ButtonSize.size48:
        return heading4.copyWith(
            color: neutualShapeColor10, fontWeight: FontWeight.w600);
    }
  }
}

enum ButtonSize { size40, size48 }
