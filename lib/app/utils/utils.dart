import 'package:flutter/material.dart';

class SafePadding extends StatelessWidget {
  final Widget child;
  final bool isSafePadingOff;
  const SafePadding(
      {super.key, required this.child, this.isSafePadingOff = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: isSafePadingOff ? EdgeInsets.zero : const EdgeInsets.all(16),
      child: child,
    ));
  }
}

//PRIMARY COLORS//

const Color primaryBlue = Color(0xFF0074D9);
const Color primaryGreen = Color(0xFF2ECC40);
const Color primaryYellow = Color(0xFFFFDC00);
const Color primaryRed = Color(0xFFFF4136);
const Color primaryPink = Color(0xFFFF85A1);
