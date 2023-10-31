import 'package:feature_guider/model/guider_options.dart';
import 'package:feature_guider/model/guider_widget_item.dart';
import 'package:feature_guider/model/overlay_description.dart';
import 'package:feature_guider/render/guider_painter.dart';
import 'package:flutter/material.dart';

class GuiderOverlayManager {
  static GuiderOverlayManager? _inst;
  final BuildContext context;

  GuiderOverlayManager._(this.context);

  final List<OverlayDescription> _overlayDescArray = [];

  factory GuiderOverlayManager.instance(BuildContext context) {
    _inst ??= GuiderOverlayManager._(context);
    return _inst!;
  }

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
        _overlayDescArray
            .add(OverlayDescription(item.guideDesc, Rect.fromLTRB(l, t, r, b)));
      }
    }
  }

  show() {
    assert(_overlayDescArray.isNotEmpty, "Guider array must be not empty!");
    _showActual();
  }

  _showActual() {
    OverlayEntry entry = OverlayEntry(builder: (ctx) {
      return GuiderOverlayContainer(_overlayDescArray);
    });
    Overlay.of(context).insert(entry);
  }
}

class GuiderOverlayContainer extends StatefulWidget {
  final List<OverlayDescription> overlayDescArray;

  const GuiderOverlayContainer(this.overlayDescArray, {Key? key})
      : super(key: key);

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
      print("animController listener invoke!!");
      if (status == AnimationStatus.completed) {
        print("animController completed!!");
        setState(() {
          stepIndex++;
          prepareStartAndNext();
        });
      }
    });

    prepareStartAndNext();
  }

  prepareStartAndNext() {
    print(
        "stepIndex = $stepIndex, overlayDescArr index = ${overlayDescArray!.length}");
    if (stepIndex < overlayDescArray!.length) {
      print("overlayDescArray1 = $overlayDescArray");
      start = overlayDescArray?[stepIndex];
      if (stepIndex < overlayDescArray!.length - 1) {
        print("overlayDescArray2 = $overlayDescArray");
        next = overlayDescArray?[stepIndex + 1];
      }
    }
    print("start === $start");
    print("next === $next");
  }

  showRectAnimation() {
    animController?.animateTo(1, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return start == null && next == null
        ? Container()
        : GestureDetector(
            onTap: () {
              showRectAnimation();
            },
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: GuiderPainter(start!, animController!, next: next),
              // painter: GuiderPainter(next!, animController!, next: next),
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
