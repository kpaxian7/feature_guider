import 'dart:ui' as ui;

import 'package:feature_guider/model/guider_widget_item.dart';
import 'package:feature_guider/model/overlay_description.dart';
import 'package:flutter/material.dart';

import 'render_helper.dart';

class GuiderPainter extends CustomPainter {
  final OverlayDescription show;
  final OverlayDescription? next;
  final AnimationController controller;

  double descWidth = 0;
  double descHeight = 0;

  GuiderPainter(
    this.show,
    this.controller, {
    this.next,
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

    left = show.drawRect.left - show.padding.left;
    if (next != null) {
      left = left + (next!.drawRect.left - left) * controller.value;
    }

    top = show.drawRect.top - show.padding.top;
    if (next != null) {
      top = top + (next!.drawRect.top - top) * controller.value;
    }

    right = show.drawRect.right + show.padding.right;
    if (next != null) {
      right = right + (next!.drawRect.right - right) * controller.value;
    }

    bottom = show.drawRect.bottom + show.padding.bottom;
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
      fontSize: show.overlayStyle.fontSize,
      fontWeight: show.overlayStyle.fontWeight,
      fontStyle: show.overlayStyle.fontStyle,
      fontFamily: show.overlayStyle.fontFamily,
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: true, applyHeightToLastDescent: true),
    );

    ui.ParagraphBuilder builder = ui.ParagraphBuilder(paragraphStyle);
    builder.pushStyle(
        ui.TextStyle(letterSpacing: show.overlayStyle.letterSpacing));
    builder.pushStyle(ui.TextStyle(color: show.overlayStyle.color));
    builder.addText(show.overlayDesc);
    ui.Paragraph p = builder.build();

    /// 计算宽高
    double descWidth = calculateTextWidth(show.overlayDesc, show.overlayStyle);
    double descHeight =
        calculateTextHeight(show.overlayDesc, show.overlayStyle);

    p.layout(ui.ParagraphConstraints(width: descWidth));

    double widgetCenterX =
        show.drawRect.left + (show.drawRect.right - show.drawRect.left) / 2;
    double widgetCenterY =
        show.drawRect.top + (show.drawRect.bottom - show.drawRect.top) / 2;

    double offsetX = 0;
    double offsetY = 0;

    bool endOverflow = show.drawRect.left + descWidth > size.width;

    double interval = 0;

    switch (show.position) {
      case DescriptionPosition.auto:
        if (widgetCenterY > size.height / 2) {
          offsetX = endOverflow
              ? show.drawRect.right - descWidth
              : show.drawRect.left;
          offsetY = show.drawRect.top - descHeight - interval;
        } else {
          offsetX = endOverflow
              ? show.drawRect.right - descWidth
              : show.drawRect.left;
          offsetY = show.drawRect.bottom + interval;
        }
        break;
      case DescriptionPosition.screenCenter:
        offsetX = (size.width - descWidth) / 2;
        offsetY = (size.height - descHeight) / 2;
        break;
      case DescriptionPosition.widgetTopCenter:
        offsetX = widgetCenterX - descWidth / 2;
        offsetY = show.drawRect.top - descHeight - interval;
        break;
      case DescriptionPosition.widgetTopFit:
        offsetX =
            endOverflow ? show.drawRect.right - descWidth : show.drawRect.left;
        offsetY = show.drawRect.top - descHeight - interval;
        break;
      case DescriptionPosition.widgetBottomCenter:
        offsetX = widgetCenterX - descWidth / 2;
        offsetY = show.drawRect.bottom + interval;
        break;
      case DescriptionPosition.widgetBottomFit:
        offsetX =
            endOverflow ? show.drawRect.right - descWidth : show.drawRect.left;
        offsetY = show.drawRect.bottom + interval;
        break;
    }

    Offset offset = Offset(offsetX, offsetY);

    canvas.drawParagraph(p, offset);
  }

  @override
  bool shouldRepaint(GuiderPainter oldDelegate) {
    return oldDelegate.controller != controller;
  }
}
