import 'package:flutter/material.dart';

class GuiderWidgetItemModel {
  Key widgetKey;
  String guideDesc;

  DescriptionPosition position;
  TextStyle overlayStyle;

  GuiderWidgetItemModel({
    required this.widgetKey,
    required this.guideDesc,
    this.position = DescriptionPosition.auto,
    this.overlayStyle = const TextStyle(),
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
