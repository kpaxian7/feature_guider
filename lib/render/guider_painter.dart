import 'package:feature_guider/model/overlay_description.dart';
import 'package:feature_guider/render/render_helper.dart';
import 'package:feature_guider/render/position.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GuiderPainter extends CustomPainter {
  final OverlayDescription start;
  final OverlayDescription? next;
  final AnimationController controller;

  final String description;
  final TextStyle textStyle;

  GuiderPainter(
    this.start,
    this.description,
    this.controller, {
    this.next,
    this.textStyle = const TextStyle(),
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _drawMasking(canvas, size);
    _drawDescription(canvas, size);
  }

  _drawMasking(Canvas canvas, Size size) {
    double left = 0;
    double top = 0;
    double right = 0;
    double bottom = 0;

    left = start.drawRect.left;
    if (next != null) {
      left = left + (next!.drawRect.left - left) * controller.value;
    }

    top = start.drawRect.top;
    if (next != null) {
      top = top + (next!.drawRect.top - top) * controller.value;
    }

    right = start.drawRect.right;
    if (next != null) {
      right = right + (next!.drawRect.right - right) * controller.value;
    }

    bottom = start.drawRect.bottom;
    if (next != null) {
      bottom = bottom + (next!.drawRect.bottom - bottom) * controller.value;
    }

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

  _drawDescription(Canvas canvas, Size size) {
    if (controller.value != 0) {
      return;
    }
    final paragraphStyle = ui.ParagraphStyle(
      fontSize: textStyle.fontSize,
      fontWeight: textStyle.fontWeight,
      fontStyle: textStyle.fontStyle,
      fontFamily: textStyle.fontFamily,
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: true, applyHeightToLastDescent: true),
    );

    ui.ParagraphBuilder builder = ui.ParagraphBuilder(paragraphStyle);
    builder.pushStyle(ui.TextStyle(letterSpacing: textStyle.letterSpacing));
    builder.pushStyle(ui.TextStyle(color: textStyle.color));
    builder.addText(description);
    ui.Paragraph p = builder.build();

    /// 计算宽高
    double widthT = calculateTextWidth(description, textStyle);
    double heightT = calculateTextHeight(description, textStyle);

    p.layout(ui.ParagraphConstraints(width: widthT));

    Offset offset = const Offset(0, 0);


    canvas.drawParagraph(p, offset);
  }

  @override
  bool shouldRepaint(GuiderPainter oldDelegate) {
    return oldDelegate.controller != controller;
  }
}
