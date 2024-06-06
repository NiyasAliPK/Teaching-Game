import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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

bool doubleClickToExit() {
  log("message");
  DateTime lastTimeBackButtonWasPressed = DateTime.now();
  final now = DateTime.now();
  final difference = now.difference(lastTimeBackButtonWasPressed);
  final backButtonHasNotBeenPressedOrHasBeenPressedLongTimeAgo =
      difference >= const Duration(seconds: 2);
  final userWantsToExitApp =
      backButtonHasNotBeenPressedOrHasBeenPressedLongTimeAgo;

  if (userWantsToExitApp) {
    log("message 1");

    lastTimeBackButtonWasPressed = DateTime.now();
    return false;
  } else {
    log("message 2");

    return true;
  }
}

showDialogueForCompletion({required Function()? callback}) {
  Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: false,
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.transparent,
              child: Center(
                child: Lottie.asset('assets/animations/correct_green.json',
                    repeat: false),
              ),
            )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    fixedSize: Size(Get.size.width / 2, 0)),
                onPressed: callback,
                child: const Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(height: Get.size.height * 0.05)
          ],
        ),
      ));
}
