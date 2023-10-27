import 'package:flutter/material.dart';

class GuiderItemWidget extends StatelessWidget {
  final double w;
  final double h;
  final double l;
  final double t;
  final BoxDecoration? decoration;

  const GuiderItemWidget(
    this.w,
    this.h,
    this.l,
    this.t, {
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOut),
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                color: Colors.transparent,
              )),
              Positioned(
                  left: l,
                  top: t,
                  child: Container(
                    width: w,
                    height: h,
                    decoration:
                        decoration ?? const BoxDecoration(color: Colors.black),
                  )),
            ],
          ),
        )),
      ],
    );
  }
}
