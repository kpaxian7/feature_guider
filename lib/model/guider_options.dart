import 'package:flutter/material.dart';

class GuiderOptions {
  double opacity;
  Duration guideSkipDuration;

  GuiderOptions({
    this.opacity = 0.4,
    this.guideSkipDuration = const Duration(milliseconds: 0),
  });
}
