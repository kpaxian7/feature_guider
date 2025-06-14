import 'package:feature_guider/guide_item.dart';
import 'package:feature_guider/render/masking_painter.dart';
import 'package:feature_guider/render/model/masking_option.dart';
import 'package:flutter/material.dart';

class MaskingStack extends StatefulWidget {
  final MaskingOption show;

  final MaskingOption? next;

  final AnimationController controller;

  final double? opacity;

  const MaskingStack({
    required this.show,
    required this.controller,
    this.next,
    this.opacity,
    super.key,
  });

  @override
  State<MaskingStack> createState() => _MaskingStackState();
}

class _MaskingStackState extends State<MaskingStack> {
  MaskingOption get show {
    return widget.show;
  }

  MaskingOption? get next {
    return widget.next;
  }

  AnimationController get controller {
    return widget.controller;
  }

  double get opacity {
    return widget.opacity ?? 0.4;
  }

  bool descriptionShow = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      bool lastDescriptionShow = descriptionShow;
      if (controller.value != 0) {
        descriptionShow = false;
      } else {
        descriptionShow = true;
      }
      if (lastDescriptionShow != descriptionShow) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildMaskingBackground(context),
        buildMaskingDescription(context),
      ],
    );
  }

  Widget buildMaskingBackground(BuildContext context) {
    return Positioned.fill(
        child: CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      painter: MaskingPainter(
        show,
        controller,
        next: next,
        opacity: opacity,
      ),
    ));
  }

  Widget buildMaskingDescription(BuildContext context) {
    if (!descriptionShow) {
      return Container();
    }
    double top = show.drawRect.top - show.rectPadding.top;
    double left = show.drawRect.left - show.rectPadding.left;
    double right = show.drawRect.right + show.rectPadding.right;
    double bottom = show.drawRect.bottom + show.rectPadding.bottom;

    double? descriptionLeft;
    double? descriptionTop;
    double? descriptionRight;
    double? descriptionBottom;

    double widgetCenterX = left + (right - left) / 2;
    double widgetCenterY = top + (bottom - top) / 2;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    bool showCenter = false;

    switch (show.position) {
      case DescriptionPosition.screenCenter:
        showCenter = true;
        break;
      case DescriptionPosition.auto:
        if (widgetCenterY > screenHeight / 2) {
          descriptionBottom = (screenHeight - top) + show.descInterval;
        } else {
          descriptionTop = bottom + show.descInterval;
        }
        if (widgetCenterX > screenWidth / 2) {
          descriptionRight = screenWidth - right;
        } else {
          descriptionLeft = left;
        }
        break;
      case DescriptionPosition.alignTopLeft:
        descriptionLeft = left;
        descriptionBottom = (screenHeight - top) + show.descInterval;
        break;
      case DescriptionPosition.alignTopRight:
        descriptionRight = screenWidth - right;
        descriptionBottom = (screenHeight - top) + show.descInterval;
        break;
      case DescriptionPosition.alignBottomLeft:
        descriptionLeft = left;
        descriptionTop = bottom + show.descInterval;
        break;
      case DescriptionPosition.alignBottomRight:
        descriptionRight = screenWidth - right;
        descriptionTop = bottom + show.descInterval;
        break;
    }

    Widget actualDescriptionWidget = Material(
      color: Colors.transparent,
      child: show.descriptionWidget,
    );

    if (showCenter) {
      actualDescriptionWidget = Center(
        child: actualDescriptionWidget,
      );
    }

    return Positioned(
      left: descriptionLeft,
      right: descriptionRight,
      top: descriptionTop,
      bottom: descriptionBottom,
      child: actualDescriptionWidget,
    );
  }
}
