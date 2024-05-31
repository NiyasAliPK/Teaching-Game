import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/numeralSkills/views/numeral_skills_view.dart';
import 'package:teaching_game/app/modules/preMathSkills/views/pre_math_skills_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _startMusic();

    // _audioPlayer.onPlayerStateChanged.listen(
    //   (event) {
    //     if (isMusicPaused.value == true) {
    //       isMusicPaused.value = false;
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    log("STATE>>>>>$state");
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      await _audioPlayer.pause();
      isMusicPaused.value = true;
    }

    if (state == AppLifecycleState.paused) {
      await _audioPlayer.stop();
    } else if (state == AppLifecycleState.resumed) {
      await _audioPlayer.pause();
      isMusicPaused.value = true;
    } else if (state == AppLifecycleState.detached) {
      await _audioPlayer.stop();
    }
  }

  RxInt currentIndex = 0.obs;
  final AudioPlayer _audioPlayer = AudioPlayer();
  RxBool isMusicPaused = false.obs;

  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        backgroundColor: primaryBlue,
        icon: Icon(
          Icons.calculate_outlined,
        ),
        label: 'Pre-Math Skills'),
    const BottomNavigationBarItem(
        backgroundColor: primaryGreen,
        icon: Icon(
          Icons.numbers,
        ),
        label: 'Numeric Skills'),
    const BottomNavigationBarItem(
        backgroundColor: primaryYellow,
        icon: Icon(Icons.upcoming),
        label: 'Coming Soon'),
    const BottomNavigationBarItem(
        backgroundColor: primaryRed,
        icon: Icon(Icons.upcoming),
        label: 'Coming Soon'),
  ];

  List<Widget> screens = [
    PreMathSkillsView(),
    NumeralSkillsView(),
    Center(
      child: Text(
        "COMING SOON",
        style: TextStyle(
            fontSize: 25,
            color: primaryYellow.withOpacity(0.75),
            fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        "COMING SOON",
        style: TextStyle(
            fontSize: 25,
            color: primaryRed.withOpacity(0.75),
            fontWeight: FontWeight.bold),
      ),
    ),
  ];

  _startMusic() async {
    try {
      await _audioPlayer.play(AssetSource('musics/home_music.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      log("Failed to start the music >>> $e");
    }
  }

  pauseOrResumeMusic() async {
    try {
      if (isMusicPaused.value) {
        await _audioPlayer.resume();
        isMusicPaused.value = false;
      } else {
        await _audioPlayer.pause();
        isMusicPaused.value = true;
      }
    } catch (e) {
      log("Failed to pause the music >>> $e");
    }
  }
}
