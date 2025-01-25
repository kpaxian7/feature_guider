import 'package:flutter/material.dart';

class GuideItem {
  /// Description text for single feature item
  String? descriptionText;

  /// Description widget for single feature item
  Widget? descriptionWidget;

  /// The key of the widget to be highlighted for guidance, used to calculate position (or you can use a fixed Rect to define the position)
  GlobalKey? toGuideKey;

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

  /// Rounded corners for the guidance area
  BorderRadius borderRadius;

  /// The interval between description and guidance area.
  double descriptionInterval;

  GuideItem({
    this.descriptionText,
    this.descriptionWidget,
    this.toGuideKey,
    this.toGuideRect,
    this.position = DescriptionPosition.auto,
    this.descriptionStyle = const TextStyle(),
    this.padding = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.descriptionInterval = 4,
  }) : assert(descriptionText != null || descriptionWidget != null,
            "Either 'descriptionText' or 'descriptionWidget' must be provided. Neither can be null.");
}

enum DescriptionPosition {
  screenCenter,
  alignTopLeft,
  alignTopRight,
  alignBottomLeft,
  alignBottomRight,
  auto,
}
