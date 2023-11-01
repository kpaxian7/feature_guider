import 'package:flutter/material.dart';

class OverlayDescription {
  String overlayDesc;

  Rect drawRect;

  DescriptionPosition position;

  OverlayDescription(
    this.overlayDesc,
    this.drawRect, {
    this.position = DescriptionPosition.auto,
  });

  @override
  String toString() {
    return "overlayDesc = $overlayDesc, drawRect = ${drawRect.toString()}";
  }
}

enum DescriptionPosition {
  screenCenter,
  widgetTopCenter,
  widgetTopFit,
  widgetBottomCenter,
  widgetBottomFit,
  auto,
}
