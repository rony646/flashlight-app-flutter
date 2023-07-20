import 'package:flashlight/components/custom_slider.dart';
import 'package:flashlight/components/light_up_button.dart';
import 'package:flashlight/components/sos_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData theme = ThemeData(useMaterial3: true);
  bool lightIsOn = false;
  bool SOSModeOn = false;
  double strobeLevel = 0.0;
  double timerValue = 0.0;

  handleFlashlightToggle(bool value) {
    // here i will turn on the phone's flashlight
    setState(() {
      lightIsOn = value;
    });
  }

  handleSOSModeToggle(bool value) {
    setState(() {
      SOSModeOn = value;
    });
  }

  handleStrobeLevelChange(double value) {
    setState(() {
      strobeLevel = value;
    });
  }

  handleTimerValueChange(double value) {
    setState(() {
      timerValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('level: $strobeLevel');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.copyWith(
          textTheme: Typography().white,
          colorScheme: theme.colorScheme.copyWith(
            primary: const Color(0xffF7AE38),
            secondary: const Color(0xFF2D386C),
          )),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/moon.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          // color: const Color(0xFF2D386C),
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(top: 200),
            height: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSlider(
                  strobeValue: strobeLevel,
                  onChange: handleStrobeLevelChange,
                  label: 'STROBE',
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LightUpButton(lightIsOn, handleFlashlightToggle),
                      SOSButton(SOSModeOn, handleSOSModeToggle),
                    ]),
                CustomSlider(
                  strobeValue: timerValue,
                  onChange: handleTimerValueChange,
                  label: 'TIMER',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
