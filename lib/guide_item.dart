import 'package:flutter/material.dart';

class GuideItem {
  /// Description for single feature item
  String description;

  /// The key of the widget to be highlighted for guidance, used to calculate position (or you can use a fixed Rect to define the position)
  Key? toGuideKey;

  /// The Rect that defines the target position for the guidance
  Rect? toGuideRect;

  /// Enumeration for the position of the text hint, includes the following:
  /// [screenCenter]: Center of the screen
  /// [widgetTopCenter]: Centered at the top of the target area
  /// [widgetTopFit]: Top of the target area with adaptive fitting
  /// [widgetBottomCenter]: Centered at the bottom of the target area
  /// [widgetBottomFit]: Bottom of the target area with adaptive fitting
  /// [auto]: Automatically determined based on the position of your component and the dimensions of the text
  DescriptionPosition position;

  /// Style for the guidance text
  TextStyle descriptionStyle;

  /// Padding inside the guidance area
  EdgeInsets padding;

  GuideItem({
    required this.description,
    this.toGuideKey,
    this.toGuideRect,
    this.position = DescriptionPosition.auto,
    this.descriptionStyle = const TextStyle(),
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
