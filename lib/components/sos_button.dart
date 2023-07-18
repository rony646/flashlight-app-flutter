import 'package:flutter/material.dart';

class SOSButton extends StatelessWidget {
  final Function(bool) onChange;
  final bool isActive;

  const SOSButton(this.isActive, this.onChange, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 60,
      width: 60,
      decoration: isActive
          ? BoxDecoration(
              boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    blurStyle: BlurStyle.normal,
                    color: Color.fromARGB(155, 60, 60, 60),
                  )
                ],
              color: const Color(0xFFEBA432),
              borderRadius: BorderRadius.circular(100))
          : BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  blurStyle: BlurStyle.normal,
                  color: Color(0x9B000000),
                )
              ],
              color: const Color(0xff2F2D4A),
              borderRadius: BorderRadius.circular(100),
            ),
      duration: const Duration(milliseconds: 100),
      child: TextButton(
        child: Text(
          'SOS',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color:
                isActive ? Colors.white : Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: () {
          onChange(!isActive);
        },
      ),
    );
  }
}
