import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotatedBox(
        quarterTurns: 3,
        child: Slider(
          value: 0.3,
          onChanged: (value) {
            print('Slider value: $value');
          },
        ),
      ),
    );
  }
}
