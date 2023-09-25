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
  final _torchController = TorchController();
  final _player = AudioPlayer();
  final ThemeData _theme = ThemeData(useMaterial3: true);
  bool _lightIsOn = false;
  bool _SOSModeOn = false;
  double _strobeLevel = 1;
  double _timerValue = 60.0;
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  playSound() async {
    _player.setVolume(1);
    _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('sounds/sos.mp3'));
  }

  stopSound() async {
    _player.setReleaseMode(ReleaseMode.stop);
  }

  turnOffLight() {
    if (_lightIsOn) {
      _torchController.toggle();
      setState(() {
        _lightIsOn = false;
      });
    }
  }

  handleFlashlightToggle(bool value) async {
    try {
      bool torchStatus = await _torchController.toggle(
          intensity: double.parse(_strobeLevel.toStringAsFixed(2))) as bool;

      Timer(
          Duration(
            seconds: int.parse(
              _timerValue.toStringAsFixed(0),
            ),
          ),
          () => turnOffLight());

      setState(() {
        _lightIsOn = torchStatus;
      });
    } catch (error) {
      _messangerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          elevation: 5.0,
          content: const Center(
            child: Text(
              'There was an error when trying to turn on the light :(',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  Timer? interval;

  handleSOSModeToggle(bool value) {
    setState(() {
      _SOSModeOn = value;
    });

    if (value) {
      playSound();
      interval = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => _torchController.toggle(),
      );
    } else {
      interval?.cancel();
      turnOffLight();
      stopSound();
    }
  }

  handleStrobeLevelChange(double value) {
    setState(() {
      _strobeLevel = value;
    });
  }

  handleTimerValueChange(double value) {
    setState(() {
      _timerValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      title: 'Flutter Demo',
      theme: _theme.copyWith(
          textTheme: Typography().white,
          colorScheme: _theme.colorScheme.copyWith(
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
                  strobeValue: _strobeLevel,
                  onChange: handleStrobeLevelChange,
                  label: 'STROBE',
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LightUpButton(
                          _lightIsOn, handleFlashlightToggle, _SOSModeOn),
                      SOSButton(_SOSModeOn, handleSOSModeToggle,
                          (!_SOSModeOn && _lightIsOn)),
                    ]),
                TimerSlider(
                  strobeValue: _timerValue,
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
