import 'package:flutter/material.dart';
import 'package:feature_guider/overlay/guider_overlay_manager.dart';

main() {
  runApp(const MaterialApp(
    home: Sample01(),
  ));
}

class Sample01 extends StatelessWidget {
  const Sample01({Key? key}) : super(key: key);

  _click(BuildContext context){
    // GuiderOverlayManager.instance().showGuider(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("testSample01"),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          _click(context);
        },
        child: const Text("我是开始按钮").doGuide(),
      ),
    );
  }
}
