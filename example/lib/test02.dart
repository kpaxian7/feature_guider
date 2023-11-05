import 'package:flutter/material.dart';
import 'package:feature_guider/guide_item.dart';
import 'package:feature_guider/guide_manager.dart';

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
  GuideManager? manager;
  GlobalKey k1 = GlobalKey();
  GlobalKey k2 = GlobalKey();
  GlobalKey k3 = GlobalKey();

  @override
  void initState() {
    super.initState();
    manager = GuideManager(context);

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("单次Frame绘制回调"); //只回调一次
      manager?.prepare([
        GuideItem(toGuideKey: k1, description: "k1k1"),
        GuideItem(toGuideKey: k2, description: "k2k2"),
      ]);
      manager?.show();
    });
  }

  showOverlay() {
    manager = GuideManager(context);
    manager?.prepare([
      GuideItem(
        toGuideKey: k1,
        description: "k1k1",
        position: DescriptionPosition.widgetTopCenter,
        padding: EdgeInsets.zero,
      ),
      GuideItem(
          toGuideKey: k2,
          description: "k2k2k2k2k2kk2k2k2k2k2k2k",
          position: DescriptionPosition.widgetTopFit,
          padding: const EdgeInsets.only(top: 4)),
      GuideItem(
        toGuideKey: k3,
        description: "k3k3",
        position: DescriptionPosition.widgetBottomFit,
      ),
      GuideItem(
        toGuideRect: Rect.fromPoints(Offset(100, 100), Offset(200, 300)),
        description: "k4k4",
        position: DescriptionPosition.widgetBottomFit,
      ),
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
    // return Column(children: [],mainAxisAlignment: MainAxisAlignment.start,)
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
              margin: EdgeInsets.only(bottom: 200, left: 200),
              child: Text(
                key: k2,
                "我是第二个文本",
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: 200),
              child: Text(
                key: k3,
                "我是第三个文本",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
