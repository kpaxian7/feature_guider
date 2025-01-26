import 'dart:ui' as ui;

import 'package:feature_guider/guide_item.dart';
import 'package:feature_guider/render/model/masking_option.dart';
import 'package:feature_guider/utils.dart';
import 'package:flutter/material.dart';

class MaskingPainter extends CustomPainter {
  final MaskingOption show;
  final MaskingOption? next;
  final AnimationController controller;

  double descWidth = 0;
  double descHeight = 0;

  double opacity;

  MaskingPainter(
    this.show,
    this.controller, {
    this.next,
    this.opacity = 0.4,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _drawMasking(canvas, size);
    // _drawDescription(canvas, size);
  }

  _drawMasking(Canvas canvas, Size size) {
    double left = 0;
    double top = 0;
    double right = 0;
    double bottom = 0;

    left = show.drawRect.left - show.rectPadding.left;
    if (next != null) {
      double nextLeft = next!.drawRect.left - next!.rectPadding.left;
      left = left + (nextLeft - left) * controller.value;
    }

    top = show.drawRect.top - show.rectPadding.top;
    if (next != null) {
      double nextTop = next!.drawRect.top - next!.rectPadding.top;
      top = top + (nextTop - top) * controller.value;
    }

    right = show.drawRect.right + show.rectPadding.right;
    if (next != null) {
      double nextRight = next!.drawRect.right + next!.rectPadding.right;
      right = right + (nextRight - right) * controller.value;
    }

    bottom = show.drawRect.bottom + show.rectPadding.bottom;
    if (next != null) {
      double nextBottom = next!.drawRect.bottom + next!.rectPadding.bottom;
      bottom = bottom + (nextBottom - bottom) * controller.value;
    }

    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final innerPath = Path()
      ..addRRect(RRect.fromLTRBAndCorners(
        left,
        top,
        right,
        bottom,
        topLeft: show.borderRadius.topLeft,
        topRight: show.borderRadius.topRight,
        bottomLeft: show.borderRadius.bottomLeft,
        bottomRight: show.borderRadius.bottomRight,
      ));

    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    final paint = Paint()..color = Colors.black.withOpacity(opacity);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MaskingPainter oldDelegate) {
    return oldDelegate.controller != controller;
  }
}
