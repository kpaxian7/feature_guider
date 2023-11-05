import 'package:feature_guider/guide_item.dart';
import 'package:flutter/material.dart';

class MaskingOption {
  String overlayDesc;

  Rect drawRect;

  DescriptionPosition position;

  TextStyle overlayStyle;

  EdgeInsets rectPadding;

  MaskingOption(
    this.overlayDesc,
    this.drawRect, {
    this.position = DescriptionPosition.auto,
    this.overlayStyle = const TextStyle(),
    this.rectPadding = const EdgeInsets.all(4),
  });
}
