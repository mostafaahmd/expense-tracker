import 'package:flutter/material.dart';

class HeaderDecoPainter extends CustomPainter {
 @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 213, 216, 241).withOpacity(0.09)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13;

    final center = Offset(size.width - 30, size.height - 85);
    final radius = 65.toDouble();

    // القوس الرئيسي (كل الدائرة ما عدا الفتحة عند كلمة Expenses)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.20 * 3.14,    // البداية من أسفل يمين
      1.3 * 3.14,     // كل الدائرة تقريبًا مع ترك فتحة من فوق لليمين (مكان كلمة Expenses)
      false,
      paint,
    );

        // القوس الصغير
    final smallPaint = Paint()
      ..color = const Color.fromARGB(255, 213, 216, 241).withOpacity(0.09)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final smallCenter = Offset(size.width - -35, size.height - 110);
    final smallRadius = 50.0;

    // خلي الفتحة بتاعت القوس الصغير تقريبًا نفس اتجاه الكبيرة بس أقل شوية
    canvas.drawArc(
      Rect.fromCircle(center: smallCenter, radius: smallRadius),
      -0.30 * 3.14,   // نفس اتجاه القوس الكبير
      1.2 * 3.14,    // قوس شبه كامل مع gap صغير فوق
      false,
      smallPaint,
    );

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
