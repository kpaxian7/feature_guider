import 'package:feature_guider_example/sample_detail_page.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: SamplePage(),
  ));
}

class SamplePage extends StatelessWidget {
  const SamplePage({Key? key}) : super(key: key);

  _showGuide(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return const SampleDetailPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  _showGuide(context);
                },
                child: const Text(
                  "Show Page",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
