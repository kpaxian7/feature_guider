import 'package:feature_guider/guide_item.dart';
import 'package:flutter/material.dart';

class MaskingOption {
  String overlayDesc;

  Rect drawRect;

  DescriptionPosition position;

  TextStyle overlayStyle;

  EdgeInsets rectPadding;

  BorderRadius borderRadius;

  MaskingOption(
    this.overlayDesc,
    this.drawRect,
    this.position,
    this.overlayStyle,
    this.rectPadding,
    this.borderRadius,
  );
}
