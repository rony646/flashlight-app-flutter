import 'package:flutter/material.dart';

class LightUpButton extends StatelessWidget {
  final bool isActive;
  final Function(bool) onChange;

  const LightUpButton(this.isActive, this.onChange, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 100,
      width: 100,
      decoration: isActive
          ? BoxDecoration(
              boxShadow: [
                const BoxShadow(
                  blurRadius: 30,
                  blurStyle: BlurStyle.normal,
                  color: Color(0x9B000000),
                ),
                BoxShadow(
                  blurRadius: 20,
                  blurStyle: BlurStyle.normal,
                  color: Theme.of(context).primaryColor,
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    const Color(0xffFF5415)
                  ]),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            )
          : BoxDecoration(
              color: const Color(0xff2F2D4A),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all(
                  color: const Color(0xFF27243D),
                  style: BorderStyle.solid,
                  width: 6)),
      child: IconButton(
        color: Colors.white,
        iconSize: 60,
        icon: const Icon(Icons.power_settings_new),
        onPressed: () {
          onChange(!isActive);
        },
      ),
    );
  }
}
