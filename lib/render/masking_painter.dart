import 'dart:ui' as ui;

import 'package:feature_guider/guide_item.dart';
import 'package:feature_guider/render/model/masking_option.dart';
import 'package:feature_guider/render/utils.dart';
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
    _drawDescription(canvas, size);
  }

  _drawMasking(Canvas canvas, Size size) {
    double left = 0;
    double top = 0;
    double right = 0;
    double bottom = 0;

    left = show.drawRect.left - show.rectPadding.left;
    if (next != null) {
      left = left + (next!.drawRect.left - left) * controller.value;
    }

    top = show.drawRect.top - show.rectPadding.top;
    if (next != null) {
      top = top + (next!.drawRect.top - top) * controller.value;
    }

    right = show.drawRect.right + show.rectPadding.right;
    if (next != null) {
      right = right + (next!.drawRect.right - right) * controller.value;
    }

    bottom = show.drawRect.bottom + show.rectPadding.bottom;
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
        topLeft: show.borderRadius.topLeft,
        topRight: show.borderRadius.topRight,
        bottomLeft: show.borderRadius.bottomLeft,
        bottomRight: show.borderRadius.bottomRight,
      ));

    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    final paint = Paint()..color = Colors.black.withOpacity(opacity);

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

    double top = show.drawRect.top - show.rectPadding.top;
    double left = show.drawRect.left - show.rectPadding.left;
    double right = show.drawRect.right + show.rectPadding.right;
    double bottom = show.drawRect.bottom + show.rectPadding.bottom;

    double widgetCenterX = left + (right - left) / 2;
    double widgetCenterY = top + (bottom - top) / 2;

    double offsetX = 0;
    double offsetY = 0;

    bool endOverflow = left + descWidth > size.width;

    double interval = show.descInterval;

    switch (show.position) {
      case DescriptionPosition.auto:
        if (widgetCenterY > size.height / 2) {
          offsetX = endOverflow ? right - descWidth : left;
          offsetY = top - descHeight - interval;
        } else {
          offsetX = endOverflow ? right - descWidth : left;
          offsetY = bottom + interval;
        }
        break;
      case DescriptionPosition.screenCenter:
        offsetX = (size.width - descWidth) / 2;
        offsetY = (size.height - descHeight) / 2;
        break;
      case DescriptionPosition.areaTopCenter:
        offsetX = widgetCenterX - descWidth / 2;
        offsetY = top - descHeight - interval;
        break;
      case DescriptionPosition.areaTopFit:
        offsetX = endOverflow ? right - descWidth : left;
        offsetY = top - descHeight - interval;
        break;
      case DescriptionPosition.areaBottomCenter:
        offsetX = widgetCenterX - descWidth / 2;
        offsetY = bottom + interval;
        break;
      case DescriptionPosition.areaBottomFit:
        offsetX = endOverflow ? right - descWidth : left;
        offsetY = bottom + interval;
        break;
    }

    Offset offset = Offset(offsetX, offsetY);

    canvas.drawParagraph(p, offset);
  }

  @override
  bool shouldRepaint(MaskingPainter oldDelegate) {
    return oldDelegate.controller != controller;
  }
}
