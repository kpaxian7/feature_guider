import 'package:feature_guider/model/guider_widget_item.dart';
import 'package:flutter/material.dart';

class OverlayDescription {
  String overlayDesc;

  Rect drawRect;

  DescriptionPosition position;

  TextStyle overlayStyle;

  OverlayDescription(
    this.overlayDesc,
    this.drawRect, {
    this.position = DescriptionPosition.auto,
    this.overlayStyle = const TextStyle(),
  });

  @override
  String toString() {
    return "overlayDesc = $overlayDesc, drawRect = ${drawRect.toString()}";
  }
}
