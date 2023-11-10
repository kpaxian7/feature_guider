import 'package:feature_guider_example/sample_detail_page.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: SamplePage(),
  ));
}

class SamplePage extends StatelessWidget {
  const SamplePage({Key? key}) : super(key: key);

  _showGuideDirect(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return const SampleDetailPage();
    }));
  }

  _showGuideWithClick() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  _showGuideDirect(context);
                },
                child: const Text(
                  "进入直接展示guide",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )),
            ElevatedButton(
                onPressed: _showGuideWithClick,
                child: const Text(
                  "点击按钮展示guide",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
