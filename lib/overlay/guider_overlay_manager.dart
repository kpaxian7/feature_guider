import 'package:feature_guider/model/guider_options.dart';
import 'package:feature_guider/model/guider_widget_item.dart';
import 'package:feature_guider/model/overlay_description.dart';
import 'package:feature_guider/render/guider_painter.dart';
import 'package:flutter/material.dart';

class GuiderOverlayManager {
  static GuiderOverlayManager? _inst;
  final BuildContext context;

  OverlayEntry? _guideMaskingOverlay;

  GuiderOverlayManager._(this.context);

  final List<OverlayDescription> _overlayDescArray = [];

  factory GuiderOverlayManager.instance(BuildContext context) {
    _inst ??= GuiderOverlayManager._(context);
    return _inst!;
  }

  // GuiderOverlayManager();

  prepareGuider(
      GuiderOptions options, List<GuiderWidgetItemModel> guiderWidgetList) {
    _overlayDescArray.clear();
    for (GuiderWidgetItemModel item in guiderWidgetList) {
      Key key = item.widgetKey;
      if (key is GlobalKey) {
        RenderObject? renderObj = key.currentContext?.findRenderObject();
        Size? size = renderObj?.paintBounds.size;
        double widgetHeight = size?.height ?? 0;
        double widgetWidth = size?.width ?? 0;

        double t = 0;
        double l = 0;
        double r = 0;
        double b = 0;

        print("key is $key, renderObj is $renderObj");

        if (renderObj is RenderBox) {
          Offset offset = renderObj.localToGlobal(Offset.zero);
          print("render offset = $offset");
          t = offset.dy;
          l = offset.dx;
          b = t + widgetHeight;
          r = l + widgetWidth;
        }
        _overlayDescArray.add(OverlayDescription(
          item.guideDesc,
          Rect.fromLTRB(l, t, r, b),
          position: item.position,
          overlayStyle: item.overlayStyle,
          padding: item.padding,
        ));
      }
    }
  }

  show() {
    assert(_overlayDescArray.isNotEmpty, "Guider array must be not empty!");
    _showActual();
  }

  _showActual() {
    _guideMaskingOverlay ??= OverlayEntry(builder: (ctx) {
      return GuiderOverlayContainer(_overlayDescArray, _dismiss);
    });
    Overlay.of(context).insert(_guideMaskingOverlay!);
  }

  _dismiss() {
    print("dismiss invoke!!");
    _guideMaskingOverlay?.remove();
    _guideMaskingOverlay = null;
  }
}

class GuiderOverlayContainer extends StatefulWidget {
  final List<OverlayDescription> overlayDescArray;
  final VoidCallback dismissCallback;

  const GuiderOverlayContainer(
    this.overlayDescArray,
    this.dismissCallback, {
    Key? key,
  }) : super(key: key);

  @override
  State<GuiderOverlayContainer> createState() => _GuiderOverlayContainerState();
}

class _GuiderOverlayContainerState extends State<GuiderOverlayContainer>
    with TickerProviderStateMixin {
  AnimationController? animController;
  List<OverlayDescription>? overlayDescArray;
  int stepIndex = 0;

  OverlayDescription? start;
  OverlayDescription? next;

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

    print("prepare done\n start=$start\n next=$next");
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
              painter: GuiderPainter(
                start!,
                animController!,
                next: next,
              ),
            ),
          );
  }
}

extension GuiderExtension on Widget {
  doGuide({String? guideDesc, TextStyle? style}) {
    var key = this.key;
    print("fetch with widget");
    print(key);
  }
}
