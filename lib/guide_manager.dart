import 'package:feature_guider/guide_item.dart';
import 'package:feature_guider/render/masking_painter.dart';
import 'package:feature_guider/render/model/masking_option.dart';
import 'package:flutter/material.dart';

class GuideManager {
  /// The BuildContext required to display the overlay
  final BuildContext context;

  /// The opacity of the overlay, default is 0.4
  double opacity;

  /// The duration of the skip transition, default is 200 milliseconds
  /// If you do not want animations, you can set the [duration] to [Duration.zero].
  Duration duration;

  OverlayEntry? _guideMaskingOverlay;
  final List<MaskingOption> _overlayDescArray = [];

  GuideManager(
    this.context, {
    this.opacity = 0.4,
    this.duration = const Duration(milliseconds: 200),
  });

  prepare(List<GuideItem> guiderWidgetList) {
    _overlayDescArray.clear();
    for (GuideItem item in guiderWidgetList) {
      assert(item.toGuideKey != null || item.toGuideRect != null,
          "Either 'toGuideKey' or 'toGuideRect' must be provided; both cannot be null.");
      if (item.toGuideKey is GlobalKey) {
        _assembleLTRBFromKey(item);
      }
      if (item.toGuideRect != null) {
        _assembleLTRBFromRect(item);
      }
    }
  }

  show() {
    assert(_overlayDescArray.isNotEmpty, "Guider array must be not empty!");
    _showActual();
  }

  _assembleLTRBFromKey(GuideItem item) {
    double t = 0;
    double l = 0;
    double r = 0;
    double b = 0;

    RenderObject? renderObj =
        (item.toGuideKey as GlobalKey).currentContext?.findRenderObject();
    Size? size = renderObj?.paintBounds.size;
    double widgetHeight = size?.height ?? 0;
    double widgetWidth = size?.width ?? 0;

    if (renderObj is RenderBox) {
      Offset offset = renderObj.localToGlobal(Offset.zero);
      t = offset.dy;
      l = offset.dx;
      b = t + widgetHeight;
      r = l + widgetWidth;
    }
    _overlayDescArray.add(MaskingOption(
      item.description,
      Rect.fromLTRB(l, t, r, b),
      item.position,
      item.descriptionStyle,
      item.padding,
      item.borderRadius,
    ));
  }

  _assembleLTRBFromRect(GuideItem item) {
    double t = 0;
    double l = 0;
    double r = 0;
    double b = 0;

    t = item.toGuideRect!.top;
    l = item.toGuideRect!.left;
    r = item.toGuideRect!.right;
    b = item.toGuideRect!.bottom;
    _overlayDescArray.add(MaskingOption(
      item.description,
      Rect.fromLTRB(l, t, r, b),
      item.position,
      item.descriptionStyle,
      item.padding,
      item.borderRadius,
    ));
  }

  _showActual() {
    _guideMaskingOverlay ??= OverlayEntry(builder: (ctx) {
      return GuiderOverlayContainer(
        _overlayDescArray,
        opacity,
        duration,
        _dismiss,
      );
    });
    Overlay.of(context).insert(_guideMaskingOverlay!);
  }

  _dismiss() {
    _guideMaskingOverlay?.remove();
    _guideMaskingOverlay = null;
  }
}

class GuiderOverlayContainer extends StatefulWidget {
  final List<MaskingOption> overlayDescArray;
  final double opacity;
  final Duration duration;
  final VoidCallback dismissCallback;

  const GuiderOverlayContainer(
    this.overlayDescArray,
    this.opacity,
    this.duration,
    this.dismissCallback, {
    Key? key,
  }) : super(key: key);

  @override
  State<GuiderOverlayContainer> createState() => _GuiderOverlayContainerState();
}

class _GuiderOverlayContainerState extends State<GuiderOverlayContainer>
    with TickerProviderStateMixin {
  AnimationController? animController;
  List<MaskingOption>? overlayDescArray;
  int stepIndex = 0;

  MaskingOption? start;
  MaskingOption? next;

  @override
  void initState() {
    super.initState();
    overlayDescArray = widget.overlayDescArray;
    animController = AnimationController(vsync: this);
    animController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          stepIndex++;
          animController?.value = 0;
          _prepareStartAndNext();
        });
      }
    });

    _prepareStartAndNext();
  }

  _prepareStartAndNext() {
    start = next;
    next = null;
    if (stepIndex < overlayDescArray!.length) {
      start = overlayDescArray![stepIndex];
      if (stepIndex < overlayDescArray!.length - 1) {
        next = overlayDescArray![stepIndex + 1];
      }
    }
  }

  _guideContinue() {
    if (next == null) {
      widget.dismissCallback.call();
    } else {
      animController?.animateTo(1, duration: const Duration(milliseconds: 180));
    }
  }

  @override
  Widget build(BuildContext context) {
    return start == null && next == null
        ? Container()
        : GestureDetector(
            onTap: () {
              _guideContinue();
            },
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: MaskingPainter(
                start!,
                animController!,
                next: next,
                opacity: widget.opacity
              ),
            ),
          );
  }
}
