import 'package:flutter/material.dart';
import 'package:tasareeh/helpers/theme.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class _CompletedPainter extends CustomPainter {
  _CompletedPainter(this.animation) : super(repaint: animation);
  final Animation<double> animation;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final circlePath = Path();
    circlePath.addArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: size.height,
        width: size.width,
      ),
      vector.radians(-90.0),
      vector.radians(360.0 * animation.value),
    );

    final leftLine = size.width * 0.2;
    final rightLine = size.width * 0.3;
    final leftPercent = animation.value > 0.5 ? 1.0 : animation.value / 0.5;
    final rightPercent = animation.value < 0.57 ? 0.0 : (animation.value - 0.5) / 0.5;
    canvas.save();
    canvas.translate(size.width / 3, size.height / 2);
    canvas.rotate(vector.radians(-45));
    canvas.drawLine(Offset.zero, Offset(0.0, leftLine * leftPercent), paint);
    canvas.drawLine(Offset(0.0, leftLine), Offset(rightLine * rightPercent, leftLine), paint);
    canvas.restore();
    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DataBackupCompletedPage extends AnimatedWidget {
  final Function()? okAction;
  DataBackupCompletedPage({required Animation<double> endingAnimation, required this.okAction}) : super(listenable: endingAnimation);
  Animation<double> get animation => (listenable as Animation<double>);
  @override
  Widget build(BuildContext context) {
    return animation.value > 0
        ? Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomPaint(
                        foregroundPainter: _CompletedPainter(animation),
                        child: SizedBox(width: 100, height: 100),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Expanded(
                    child: TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 400),
                      builder: (_, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0.0, 50 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text('تمت العملية بنجاح', style: TextStyle(fontSize: 17), textAlign: TextAlign.center),
                          Spacer(),
                          if (okAction != null)
                            OutlinedButton(
                              onPressed: okAction,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                                child: Text('حسنا', style: TextStyle(color: primaryColor)),
                              ),
                            ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
