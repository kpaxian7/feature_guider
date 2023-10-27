import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GuideDemo(),
    );
  }
}

class GuideDemo extends StatefulWidget {
  @override
  _GuideDemoState createState() => _GuideDemoState();
}

class _GuideDemoState extends State<GuideDemo> {
  GlobalKey _textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text(
              "Hello, World!",
              key: _textKey,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Positioned(bottom: 100, child: Text("Another text!")),
          HighlightMask(targetKey: _textKey),
        ],
      ),
    );
  }
}

class HighlightMask extends StatelessWidget {
  final GlobalKey targetKey;

  HighlightMask({required this.targetKey});

  @override
  Widget build(BuildContext context) {
    final RenderBox renderBox =
        targetKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return Positioned.fill(
      child: CustomPaint(
        painter: HolePainter(
          rect: Rect.fromPoints(
            position,
            position.translate(
              renderBox.size.width,
              renderBox.size.height,
            ),
          ),
        ),
      ),
    );
  }
}

class HolePainter extends CustomPainter {
  final Rect rect;

  HolePainter({required this.rect});

  @override
  void paint(Canvas canvas, Size size) {
    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final innerPath = Path()..addRect(rect);

    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    final paint = Paint()..color = Colors.black.withOpacity(0.7);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
