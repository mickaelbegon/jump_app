import 'package:flutter/material.dart';

import '/providers/app_parameters.dart';
import '/providers/locale_text.dart';
import 'aerial_phase.dart';
import 'airborne_trajectory.dart';
import 'background_image.dart';
import 'center_of_mass.dart';
import 'flight_apex.dart';
import 'flight_inertia.dart';
import 'floor.dart';
import 'ground_reaction_force.dart';
import 'header.dart';
import 'landing_phase.dart';
import 'pre_jump_rotation.dart';
import 'pushoff_phase.dart';
import 'total_rotation.dart';

class SkaterImage extends StatefulWidget {
  const SkaterImage({
    Key? key,
    this.width,
  }) : super(key: key);

  final double? width;

  @override
  State<SkaterImage> createState() => _SkaterImageState();
}

class _SkaterImageState extends State<SkaterImage> {
  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final appParameters = AppParameters.of(context);
    final isRotation = appParameters.type == AppType.rotation;
    final isTranslation = !isRotation;

    final w = widget.width ?? MediaQuery.of(context).size.width;

    // Precompute some widget positions on the screen
    final floor = 0.11 * w;
    final jumpHeigh = 0.100 * w;

    final comStart = Offset(0.265 * w, -floor - 0.100 * w);
    final comSliderStartPosition = Offset(comStart.dx - 0.11 * w, floor);
    final comFinal = Offset(0.791 * w, -floor - 0.115 * w);
    final comSliderFinalPosition = Offset(comFinal.dx - 0.11 * w, floor);
    final comSliderHeight = 0.15 * w;
    final comMid = Offset(
        (comStart.dx + comFinal.dx) / 2, (comStart.dy + comFinal.dy) / 2);
    final comSize = 0.011 * w;
    final rotationPosition =
        Offset(comFinal.dx - 0.1 * w, comFinal.dy - 0.1 * w);

    final initialRotationSliderPosition = Offset(0.17 * w, 0.15 * w + floor);
    final initialRotationSliderSize = 0.20 * w;
    final initialVelocitySliderPosition = Offset(0.17 * w, 0.2 * w + floor);
    final initialVelocitySliderSize = 0.20 * w;
    final inertiaSliderPosition = Offset(0.3 * w, 0.30 * w + floor);
    final inertiaSliderSize = 0.10 * w;

    final minimumInertiaSliderPosition = Offset(0.7 * w, 0.30 * w + floor);
    final minimumInertiaSliderSize = 0.10 * w;
    final timeToMinimumInertiaSliderPosition =
        Offset(0.29 * w, 0.04 * w + floor);
    final timeToMinimumInertiaSliderSize = 0.200 * w;

    final grfArrow = Offset(0.280 * w, -floor - 0.270 * w);
    final grfSliderPosition = Offset(0.20 * w, floor + 0.18 * w);
    final grfSliderHeight = 0.200 * w;

    final pushoff = 0.05 * w;
    final pushoffSliderPosition = Offset(0.017 * w, 0.02 * w);
    final pushoffSliderWidth = 0.25 * w;
    final land = 0.95 * w;

    final arrowsHeadSize = 0.023 * w;
    final arrowsBelow = -floor + 0.033 * w;

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      width: w,
      height: 0.55 * w,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          const Header(),
          BackgoundImage(
              floor: floor, imagePath: 'assets/images/key_frames_axel.png'),
          if (isTranslation)
            GroundReactionForce(
              arrowHead: grfArrow,
              arrowHeadSize: arrowsHeadSize,
              sliderPosition: grfSliderPosition,
              sliderHeight: grfSliderHeight,
              floor: floor,
            ),
          if (isTranslation)
            CenterOfMass(
              comStart,
              type: CenterOfMassType.start,
              radius: comSize,
              floor: floor,
              withPicker: true,
              pickerPosition: comSliderStartPosition,
              pickerHeight: comSliderHeight,
              textSize: arrowsHeadSize,
            ),
          if (isTranslation)
            CenterOfMass(
              comFinal,
              type: CenterOfMassType.end,
              radius: comSize,
              floor: floor,
              withPicker: true,
              pickerPosition: comSliderFinalPosition,
              pickerHeight: comSliderHeight,
              textSize: arrowsHeadSize,
            ),
          AirboneTrajectory(start: comStart, end: comFinal, height: jumpHeigh),
          FlightApex(
            apex: Offset(comMid.dx, comMid.dy - jumpHeigh),
            floor: floor,
            arrowsHeadSize: arrowsHeadSize,
          ),
          TotalRotation(
            position: rotationPosition,
            fontSize: arrowsHeadSize,
          ),
          if (isRotation)
            FlightInertia(
              inertiaSliderPosition: minimumInertiaSliderPosition,
              inertiaSliderSize: minimumInertiaSliderSize,
              timeToInertiaSliderPosition: timeToMinimumInertiaSliderPosition,
              timeToInertiaSliderSize: timeToMinimumInertiaSliderSize,
              fontSize: arrowsHeadSize,
            ),
          Floor(floor: floor),
          if (isTranslation)
            PushoffPhase(
              texts: texts,
              arrowsHeadSize: arrowsHeadSize,
              pushoff: pushoff,
              arrowsBelow: arrowsBelow,
              comStart: comStart,
              pushoffSliderPosition: pushoffSliderPosition,
              pushoffSliderWidth: pushoffSliderWidth,
            ),
          AerialPhase(
            arrowsHeadSize: arrowsHeadSize,
            comStart: comStart,
            arrowsBelow: arrowsBelow,
            comFinal: comFinal,
          ),
          if (!isTranslation && !isRotation)
            LandingPhase(
                texts: texts,
                arrowsHeadSize: arrowsHeadSize,
                comFinal: comFinal,
                arrowsBelow: arrowsBelow,
                land: land),
          if (isRotation)
            PreJumpRotation(
              initialRotationSliderPosition: initialRotationSliderPosition,
              initialRotationSliderSize: initialRotationSliderSize,
              initialVelocitySliderPosition: initialVelocitySliderPosition,
              initialVelocitySliderSize: initialVelocitySliderSize,
              inertiaSliderPosition: inertiaSliderPosition,
              inertiaSliderSize: inertiaSliderSize,
              fontSize: arrowsHeadSize,
            ),
        ],
      ),
    );
  }
}
