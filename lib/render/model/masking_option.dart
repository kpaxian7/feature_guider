import 'package:feature_guider/guide_item.dart';
import 'package:flutter/material.dart';

class MaskingOption {
  // String overlayDesc;

  Widget descriptionWidget;

  Rect drawRect;

  DescriptionPosition position;

  // TextStyle overlayStyle;

  EdgeInsets rectPadding;

  BorderRadius borderRadius;

  double descInterval;

  MaskingOption(
    this.descriptionWidget,
    this.drawRect,
    this.position,
    // this.overlayStyle,
    this.rectPadding,
    this.borderRadius,
    this.descInterval,
  );
}
