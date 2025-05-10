import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/theme.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(_controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = AppTheme.backgroundColor,
    );

    // Draw animated shapes
    _drawShapes(canvas, size, paint);
  }

  void _drawShapes(Canvas canvas, Size size, Paint paint) {
    final shapes = 15;
    final random = math.Random(42); // Fixed seed for consistent pattern

    for (int i = 0; i < shapes; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 20.0 + random.nextDouble() * 60.0;
      
      // Animate position
      final offsetX = math.sin((animationValue * 2 * math.pi) + i) * 20;
      final offsetY = math.cos((animationValue * 2 * math.pi) + i * 0.5) * 20;
      
      // Choose shape type
      final shapeType = i % 3;
      
      // Choose color
      Color color;
      switch (i % 4) {
        case 0:
          color = AppTheme.primaryColor.withOpacity(0.1);
          break;
        case 1:
          color = AppTheme.secondaryColor.withOpacity(0.1);
          break;
        case 2:
          color = AppTheme.accentColor.withOpacity(0.1);
          break;
        default:
          color = Colors.purple.withOpacity(0.1);
      }
      
      paint.color = color;
      
      // Draw shape
      switch (shapeType) {
        case 0: // Circle
          canvas.drawCircle(
            Offset(x + offsetX, y + offsetY),
            radius,
            paint,
          );
          break;
        case 1: // Square
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset(x + offsetX, y + offsetY),
              width: radius * 1.5,
              height: radius * 1.5,
            ),
            paint,
          );
          break;
        case 2: // Triangle
          final path = Path();
          path.moveTo(x + offsetX, y + offsetY - radius);
          path.lineTo(x + offsetX + radius, y + offsetY + radius);
          path.lineTo(x + offsetX - radius, y + offsetY + radius);
          path.close();
          canvas.drawPath(path, paint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => true;
}
