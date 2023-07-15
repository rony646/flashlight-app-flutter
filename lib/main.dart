import 'package:flashlight/components/light_up_button.dart';
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

  handleFlashlightToggle(bool value) {
    // here i will turn on the phone's flashlight
    setState(() {
      lightIsOn = value;
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
          color: const Color(0xFF2D386C),
          alignment: Alignment.center,
          child: SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Slider here'),
                Column(children: [
                  LightUpButton(lightIsOn, handleFlashlightToggle),
                  const Text('SOS Button')
                ]),
                const Text('Slider here'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
