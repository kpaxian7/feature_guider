import 'package:feature_guider/overlay/guider_item_widget.dart';
import 'package:flutter/material.dart';

class GuiderOverlayManager {
  static GuiderOverlayManager? _inst;

  GuiderOverlayManager._();

  factory GuiderOverlayManager.instance() {
    _inst ??= GuiderOverlayManager._();
    return _inst!;
  }

  showGuider(BuildContext context) {
    OverlayEntry overlay = OverlayEntry(builder: (ctx) {
      return GuiderItemWidget(100, 50, 200, 200);
    });

    Overlay.of(context).insert(overlay);
  }
}

extension GuiderExtension on Widget {
  doGuide({String? guideDesc, TextStyle? style}) {
    var key = this.key;
    print("fetch with widget");
    print(key);
  }
}
