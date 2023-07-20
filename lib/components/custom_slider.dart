import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double strobeValue;
  final Function(double) onChange;
  final String label;

  const CustomSlider({
    super.key,
    required this.strobeValue,
    required this.onChange,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Slider(
              value: strobeValue,
              onChanged: onChange,
            ),
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
