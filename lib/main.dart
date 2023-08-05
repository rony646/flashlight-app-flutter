import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flashlight/components/custom_slider.dart';
import 'package:flashlight/components/light_up_button.dart';
import 'package:flashlight/components/sos_button.dart';
import 'package:flashlight/components/timer_slider.dart';
import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

void main() {
  TorchController().initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final torchController = TorchController();
  final player = AudioPlayer();
  final ThemeData theme = ThemeData(useMaterial3: true);
  bool lightIsOn = false;
  bool SOSModeOn = false;
  double strobeLevel = 1;
  double timerValue = 60.0;

  playSound() async {
    player.setVolume(1);
    player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource('sounds/sos.mp3'));
  }

  stopSound() async {
    player.setReleaseMode(ReleaseMode.stop);
  }

  turnOffLight() {
    if (lightIsOn) {
      torchController.toggle();
      setState(() {
        lightIsOn = false;
      });
    }
  }

  handleFlashlightToggle(bool value) async {
    bool torchStatus = await torchController.toggle(
        intensity: double.parse(strobeLevel.toStringAsFixed(2))) as bool;

    Timer(
        Duration(
          seconds: int.parse(
            timerValue.toStringAsFixed(0),
          ),
        ),
        () => turnOffLight());

    setState(() {
      lightIsOn = torchStatus;
    });
  }

  Timer? interval;

  handleSOSModeToggle(bool value) {
    setState(() {
      SOSModeOn = value;
    });

    if (value) {
      playSound();
      interval = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => torchController.toggle(),
      );
    } else {
      interval?.cancel();
      turnOffLight();
      stopSound();
    }
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
                      LightUpButton(
                          lightIsOn, handleFlashlightToggle, SOSModeOn),
                      SOSButton(SOSModeOn, handleSOSModeToggle,
                          (!SOSModeOn && lightIsOn)),
                    ]),
                TimerSlider(
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
