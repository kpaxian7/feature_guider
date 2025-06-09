import 'package:flutter/material.dart';

class GuideItem {
  /// Unique identifier for this guide item, used to track if it's already shown
  /// If null, this item will always be shown and will not be stored or checked in SharedPreferences
  String? id;

  /// Description widget for single feature item
  Widget? descriptionWidget;

  /// The key of the widget to be highlighted for guidance, used to calculate position (or you can use a fixed Rect to define the position)
  GlobalKey? toGuideKey;

  /// The Rect that defines the target position for the guidance
  Rect? toGuideRect;

  /// Enumeration for the position of the text hint, includes the following:
  /// [screenCenter]: Center of the screen
  /// [alignTopLeft]: Positions the content above the target area, aligned to the left side
  /// [alignTopRight]: Positions the content above the target area, aligned to the right side
  /// [alignBottomLeft]: Positions the content below the target area, aligned to the left side
  /// [alignBottomRight]: Positions the content below the target area, aligned to the right side
  /// [auto]: Automatically determined based on the position of your component and the dimensions of the text
  DescriptionPosition position;

  /// Padding inside the guidance area
  EdgeInsets padding;

  /// Rounded corners for the guidance area
  BorderRadius borderRadius;

  /// The interval between description and guidance area.
  double descriptionInterval;

  GuideItem({
    this.id,
    this.descriptionWidget,
    this.toGuideKey,
    this.toGuideRect,
    this.position = DescriptionPosition.auto,
    this.padding = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.descriptionInterval = 4,
  });
}

enum DescriptionPosition {
  screenCenter,
  alignTopLeft,
  alignTopRight,
  alignBottomLeft,
  alignBottomRight,
  auto,
}
