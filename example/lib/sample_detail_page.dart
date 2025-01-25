import 'package:flutter/material.dart';
import 'package:feature_guider/guide_manager.dart';
import 'package:feature_guider/guide_item.dart';

class SampleDetailPage extends StatefulWidget {
  const SampleDetailPage({Key? key}) : super(key: key);

  @override
  State<SampleDetailPage> createState() => _SampleDetailPageState();
}

class _SampleDetailPageState extends State<SampleDetailPage> {
  GlobalKey keyAppBarBack = GlobalKey();
  GlobalKey keyAppBarTitle = GlobalKey();
  GlobalKey keyCountDisplay = GlobalKey();
  GlobalKey keyCountIncrease = GlobalKey();

  GuideManager? guideManager;

  int count = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      guideManager ??= GuideManager(context,
          opacity: 0.7, duration: const Duration(milliseconds: 200));
      guideManager!.prepare([
        GuideItem(
          descriptionText: "Click here to go back",
          descriptionStyle: TextStyle(color: Colors.white),
          toGuideKey: keyAppBarBack,
          position: DescriptionPosition.alignBottomLeft,
        ),
        GuideItem(
          descriptionText: "This is the title of this page",
          toGuideKey: keyAppBarTitle,
          padding: EdgeInsets.only(left: 20, right: 20),
          descriptionStyle: TextStyle(color: Colors.red),
          position: DescriptionPosition.alignBottomRight,
        ),
        GuideItem(
            descriptionText: "The area of the 'count' displayed",
            toGuideKey: keyCountDisplay,
            padding: EdgeInsets.zero,
            position: DescriptionPosition.alignTopLeft),
        GuideItem(
          descriptionText: "Click here to increase the 'count'",
          toGuideKey: keyCountIncrease,
          padding: const EdgeInsets.all(5),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          position: DescriptionPosition.alignTopRight,
        ),
      ]);
      guideManager!.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GuideSamplePage",
          key: keyAppBarTitle,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        leading: Icon(
          Icons.arrow_back,
          key: keyAppBarBack,
        ),
      ),
      body: Center(
        child: Text(
          "count=$count",
          key: keyCountDisplay,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: keyCountIncrease,
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
