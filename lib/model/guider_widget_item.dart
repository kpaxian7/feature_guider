import 'package:flutter/material.dart';

class GuiderWidgetItemModel {
  Key widgetKey;
  String guideDesc;

  DescriptionPosition position;
  TextStyle overlayStyle;
  EdgeInsets padding;

  GuiderWidgetItemModel({
    required this.widgetKey,
    required this.guideDesc,
    this.position = DescriptionPosition.auto,
    this.overlayStyle = const TextStyle(),
    this.padding = const EdgeInsets.all(2),
  });
}

enum DescriptionPosition {
  screenCenter,
  widgetTopCenter,
  widgetTopFit,
  widgetBottomCenter,
  widgetBottomFit,
  auto,
}
