import 'package:flutter/material.dart';
import 'package:reminder/const/color.dart';

class BgPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = neutualShapeColor10;
    paint.strokeWidth = 2.0;
    Path path = Path();
    path.moveTo(
      0,
      size.height * 0.2,
    );

    path.quadraticBezierTo(
      size.width * 0.1,
      -size.height * 0.1,
      size.width * 0.25,
      size.height * 0.15,
    );

    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.2,
    );

    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.01,
      size.width * 0.7,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.3,
      size.width * 0.9,
      size.height * 0.05,
    );

    path.quadraticBezierTo(
      size.width * 0.95,
      0,
      size.width,
      size.height * 0.1,
    );
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(0, size.height * 0.5);
    path.close();

    path.moveTo(
      size.width,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height,
      size.width * 0.4,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.6,
      0,
      size.height * 0.8,
    );
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
