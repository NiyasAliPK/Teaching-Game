import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teaching_game/app/utils/utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryPink,
        onPressed: () {
          _controller.pauseOrResumeMusic();
        },
        child: Obx(
          () => Icon(_controller.isMusicPaused.value
              ? Icons.music_off
              : Icons.music_note),
        ),
      ),
      body: SafePadding(
          isSafePadingOff: true,
          child: Stack(
            children: [
              Container(
                height: context.height,
                color: primaryBlue,
                child: Lottie.asset('assets/animations/home_background.json',
                    repeat: true, fit: BoxFit.fitHeight),
              ),
              Obx(() => _controller.screens[_controller.currentIndex.value])
            ],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: _controller.currentIndex.value,
            onTap: (value) {
              _controller.currentIndex.value = value;
            },
            items: _controller.bottomNavigationBarItems,
          )),
    );
  }
}
