import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teaching_game/app/modules/numeralSkills/views/numeral_skills_view.dart';
import 'package:teaching_game/app/modules/preMathSkills/views/pre_math_skills_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _startMusic();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) return;
    if (state == AppLifecycleState.paused) {
      await _audioPlayer.stop();
    } else if (state == AppLifecycleState.resumed &&
        isMusicPaused.value == false) {
      await _audioPlayer.play();
    } else if (state == AppLifecycleState.detached) {
      await _audioPlayer.stop();
    }
  }

  RxInt currentIndex = 0.obs;
  final AudioPlayer _audioPlayer = AudioPlayer();
  RxBool isMusicPaused = false.obs;
  bool isManuallyPaused = false;

  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        backgroundColor: primaryGreen,
        icon: Icon(
          Icons.calculate_outlined,
        ),
        label: 'Pre-Math Skills'),
    const BottomNavigationBarItem(
        backgroundColor: primaryBlue,
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
    const PreMathSkillsView(),
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
    log('start music called');
    await Future.delayed(const Duration(seconds: 3));
    try {
      await _audioPlayer.setAsset('assets/musics/home_music.mp3');
      await _audioPlayer.setVolume(0.25);
      await _audioPlayer.setLoopMode(LoopMode.all);
      await _audioPlayer.play();
      log('Music played');
    } catch (e) {
      log("Failed to start the music >>> $e");
    }
  }

  pauseOrResumeMusic() async {
    try {
      if (isMusicPaused.value) {
        log("PAUSED");
        isMusicPaused.value = false;
        await _audioPlayer.play();
      } else {
        await _audioPlayer.pause();
        isMusicPaused.value = true;
        log("RESUMED");
      }
    } catch (e) {
      log("Failed to pause the music >>> $e");
    }
  }
}
