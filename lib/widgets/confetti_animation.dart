import 'package:flutter/material.dart';
import 'dart:math' as math;

class ConfettiAnimation extends StatefulWidget {
  const ConfettiAnimation({Key? key}) : super(key: key);

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Confetti> _confetti;
  final int _confettiCount = 50;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _confetti = List.generate(_confettiCount, (index) => Confetti());
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
          painter: ConfettiPainter(_confetti, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class Confetti {
  final double x;
  final double y;
  final double size;
  final Color color;
  final double speed;
  final double angle;
  final ConfettiShape shape;

  Confetti()
      : x = math.Random().nextDouble() * 1.2 - 0.1, // -0.1 to 1.1
        y = -0.2 - math.Random().nextDouble() * 0.8, // -0.2 to -1.0
        size = 5.0 + math.Random().nextDouble() * 10.0,
        color = _randomColor(),
        speed = 0.2 + math.Random().nextDouble() * 0.3,
        angle = math.Random().nextDouble() * 2 * math.pi,
        shape = _randomShape();

  static Color _randomColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
    ];
    return colors[math.Random().nextInt(colors.length)];
  }

  static ConfettiShape _randomShape() {
    final shapes = [
      ConfettiShape.circle,
      ConfettiShape.square,
      ConfettiShape.triangle,
    ];
    return shapes[math.Random().nextInt(shapes.length)];
  }
}

enum ConfettiShape { circle, square, triangle }

class ConfettiPainter extends CustomPainter {
  final List<Confetti> confetti;
  final double animationValue;

  ConfettiPainter(this.confetti, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final piece in confetti) {
      final paint = Paint()
        ..color = piece.color
        ..style = PaintingStyle.fill;

      // Calculate position
      final x = piece.x * size.width;
      final y = (piece.y + piece.speed * animationValue * 5) % 1.2 * size.height;

      // Calculate rotation
      final angle = piece.angle + animationValue * 2 * math.pi;

      // Save canvas state
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);

      // Draw shape
      switch (piece.shape) {
        case ConfettiShape.circle:
          canvas.drawCircle(Offset.zero, piece.size / 2, paint);
          break;
        case ConfettiShape.square:
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: piece.size,
              height: piece.size,
            ),
            paint,
          );
          break;
        case ConfettiShape.triangle:
          final path = Path();
          path.moveTo(0, -piece.size / 2);
          path.lineTo(piece.size / 2, piece.size / 2);
          path.lineTo(-piece.size / 2, piece.size / 2);
          path.close();
          canvas.drawPath(path, paint);
          break;
      }

      // Restore canvas state
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}