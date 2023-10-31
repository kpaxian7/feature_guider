import 'package:feature_guider/model/guider_options.dart';
import 'package:feature_guider/model/guider_widget_item.dart';
import 'package:feature_guider/overlay/guider_overlay_manager.dart';
import 'package:flutter/material.dart';
import 'package:feature_guider/render/guider_painter.dart';

main() {
  runApp(MaterialApp(
    home: Test02(),
  ));
}

class Test02 extends StatefulWidget {
  const Test02({Key? key}) : super(key: key);

  @override
  State<Test02> createState() => _Test02State();
}

class _Test02State extends State<Test02> with WidgetsBindingObserver {
  GuiderOverlayManager? manager;
  GlobalKey k1 = GlobalKey();
  GlobalKey k2 = GlobalKey();

  @override
  void initState() {
    super.initState();
    // manager = GuiderOverlayManager.instance(context);
    // manager?.prepareGuider(GuiderOptions(), [
    //   GuiderWidgetItemModel(widgetKey: k1, guideDesc: "k1k1"),
    //   GuiderWidgetItemModel(widgetKey: k2, guideDesc: "k2k2"),
    // ]);

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("单次Frame绘制回调"); //只回调一次
      // manager?.show();
    });
  }

  showOverlay(){
    manager = GuiderOverlayManager.instance(context);
    manager?.prepareGuider(GuiderOptions(), [
      GuiderWidgetItemModel(widgetKey: k1, guideDesc: "k1k1"),
      GuiderWidgetItemModel(widgetKey: k2, guideDesc: "k2k2"),
    ]);
    manager?.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              showOverlay();
            },
            child: Text(
              "我是第一个文本1",
              key: k1,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(bottom: 200),
              child: Text(
                key: k2,
                "我是第二个文本",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
