import 'package:act_cms/config/theme.dart';
import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WelcomeBackgroundPainter(color: AppTheme.primaryColor.withAlpha(25)),
      size: MediaQuery.of(context).size,
    );
  }
}

class WelcomeBackgroundPainter extends CustomPainter {
  final Color color;

  const WelcomeBackgroundPainter({Key? key, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width * 1.5;
    Paint paint = Paint()..color = color;
    canvas.drawCircle(Offset(size.width * 0.5, 0), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
