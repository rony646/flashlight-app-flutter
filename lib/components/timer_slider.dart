import 'package:flutter/material.dart';

class TimerSlider extends StatelessWidget {
  final double strobeValue;
  final Function(double) onChange;
  final String label;

  const TimerSlider({
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
              min: 0,
              max: 60,
              label: '${strobeValue.toStringAsFixed(0)}s',
              value: strobeValue,
              onChanged: onChange,
              divisions: 5,
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
