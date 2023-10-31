import 'package:flutter/material.dart';

class OverlayDescription {
  String overlayDesc;

  Rect drawRect;

  OverlayDescription(this.overlayDesc, this.drawRect);

  @override
  String toString() {
    return "overlayDesc = $overlayDesc, drawRect = ${drawRect.toString()}";
  }
}
