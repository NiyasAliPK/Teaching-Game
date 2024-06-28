import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:vibration/vibration.dart';

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

showDialogueForCompletion({required Function() callback}) async {
  final audioPlayer = AudioPlayer();

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
                onPressed: () {
                  audioPlayer.dispose();
                  callback();
                },
                child: const Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(height: Get.size.height * 0.05)
          ],
        ),
      ));
  try {
    await audioPlayer.setAsset('assets/musics/level_completed.mp3');
    await audioPlayer.play();
  } catch (e) {
    log("Failed to start the music >>> $e");
  }
}

showDialogueForInstructions(
    {required String instruction, required String path}) async {
  final audioPlayer = AudioPlayer();
  log('PATH>>>>$path');
  await Future.delayed(const Duration(milliseconds: 500));
  Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: false,
        child: Column(
          children: [
            Expanded(
                child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafePadding(
                child: Center(
                  child: Text(
                    instruction,
                    style: TextStyle(
                        color: Colors.white, fontSize: Get.width * 0.08),
                  ),
                ),
              ),
            )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    fixedSize: Size(Get.size.width / 3, 0)),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(height: Get.size.height * 0.05)
          ],
        ),
      ));
  await audioPlayer.setAsset(path);
  await audioPlayer.play().then(
    (value) {
      audioPlayer.dispose();
    },
  );
}

List<String> pathsOfFailedSounds = [
  'assets/musics/surprise.mp3',
  'assets/musics/game_over.mp3',
  'assets/musics/wrong_attempt.mp3'
];
showDialogueForWrongAttempt() async {
  final audioPlayer = AudioPlayer();
  if ((await Vibration.hasVibrator()) == null ? false : true) {
    await Vibration.vibrate(duration: 1000);
  }
  Get.dialog(
      barrierDismissible: true,
      Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.transparent,
            child: Center(
              child: Lottie.asset(
                'assets/animations/wrong.json',
                repeat: false,
              ),
            ),
          )),
          SizedBox(height: Get.size.height * 0.05)
        ],
      ));
  try {
    await audioPlayer.setAsset(pathsOfFailedSounds[math.Random().nextInt(3)]);
    await audioPlayer.play();
  } catch (e) {
    log("Failed to start the music >>> $e");
  }

  await Future.delayed(const Duration(milliseconds: 700)).then(
    (value) async {
      log("then called");
      Get.back();
      await audioPlayer.dispose();
    },
  );
}

List<String> soundsForSuccess = [
  'assets/musics/excellent (2).mp3',
  'assets/musics/amazing.mp3',
  'assets/musics/fantastic.mp3',
  'assets/musics/great.mp3',
  'assets/musics/very_good.mp3',
  'assets/musics/wow.mp3'
];
successSoundPlayer() async {
  final audioPlayer = AudioPlayer();
  await audioPlayer.setAsset(soundsForSuccess[math.Random().nextInt(6)]);
  await audioPlayer.play().then(
    (value) {
      audioPlayer.dispose();
    },
  );
}
