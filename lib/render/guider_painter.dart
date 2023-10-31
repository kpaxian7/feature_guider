import 'package:feature_guider/model/overlay_description.dart';
import 'package:flutter/material.dart';

class GuiderPainter extends CustomPainter {
  final OverlayDescription start;
  final OverlayDescription? next;
  final AnimationController controller;

  GuiderPainter(
    this.start,
    this.controller, {
    this.next,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    double left = 0;
    double top = 0;
    double right = 0;
    double bottom = 0;

    left = start.drawRect.left +
        (((next?.drawRect.left ?? 0) - start.drawRect.left) * controller.value);
    top = start.drawRect.top +
        (((next?.drawRect.top ?? 0) - start.drawRect.top) * controller.value);
    right = start.drawRect.right +
        (((next?.drawRect.right ?? 0) - start.drawRect.right) * controller.value);
    bottom = start.drawRect.bottom +
        (((next?.drawRect.bottom ?? 0) - start.drawRect.bottom) * controller.value);
    print("start=${start.drawRect}, next=${next?.drawRect}, controllerVal=${controller.value}");
    print("left=$left,top=$top,right=$right,bottom=$bottom");

    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final innerPath = Path()
      ..addRRect(RRect.fromLTRBAndCorners(
        left,
        top,
        right,
        bottom,
        topLeft: const Radius.circular(4),
        topRight: const Radius.circular(4),
        bottomLeft: const Radius.circular(4),
        bottomRight: const Radius.circular(4),
      ));

    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    final paint = Paint()..color = Colors.black.withOpacity(0.4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(GuiderPainter oldDelegate) {
    return oldDelegate.controller != controller;
  }
}
