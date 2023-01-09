import 'package:flutter/material.dart';

import '/providers/locale_text.dart';
import 'double_heads_arrow.dart';
import 'pushoff_slider.dart';

class PushoffPhase extends StatelessWidget {
  const PushoffPhase({
    Key? key,
    required this.texts,
    required this.arrowsHeadSize,
    required this.pushoff,
    required this.arrowsBelow,
    required this.comStart,
    required this.pushoffSliderPosition,
    required this.pushoffSliderWidth,
  }) : super(key: key);

  final LocaleText texts;
  final double arrowsHeadSize;
  final double pushoff;
  final double arrowsBelow;
  final Offset comStart;
  final Offset pushoffSliderPosition;
  final double pushoffSliderWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        PushoffSlider(
          color: const Color.fromARGB(255, 128, 8, 162),
          position: pushoffSliderPosition,
          textSize: arrowsHeadSize,
          width: pushoffSliderWidth,
        ),
        DoubleHeadsArrow(
          title: texts.pushoffPhase,
          fontSize: arrowsHeadSize * 3 / 4,
          start: Offset(pushoff, arrowsBelow),
          end: Offset(comStart.dx, arrowsBelow),
          headSize: arrowsHeadSize,
          color: const Color.fromARGB(255, 128, 8, 162),
        ),
      ],
    );
  }
}
