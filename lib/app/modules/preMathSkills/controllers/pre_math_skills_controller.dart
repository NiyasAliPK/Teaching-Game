import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/db/premath_hive.dart';
import 'package:teaching_game/app/db/premath_hive_box.dart';
import 'package:teaching_game/app/modules/home/controllers/home_controller.dart';
import 'package:teaching_game/app/modules/introVideo/views/intro_video_view.dart';
import 'package:teaching_game/app/modules/preMathSkills/bindings/pre_math_skills_binding.dart';

class PreMathSkillsController extends GetxController {
  final PreMathHiveBoxController preMathHiveBoxController =
      Get.put(PreMathHiveBoxController());

  List<PreMathProgressModel> progressList = [];

  List<PreMathItemModel> items = [
    PreMathItemModel(name: "BIG / SMALL", progress: 0),
    PreMathItemModel(name: "FAR / NEAR", progress: 0),
    PreMathItemModel(name: "MORE / LESS", progress: 0),
    PreMathItemModel(name: "SAME / DIFFERENT", progress: 0),
    PreMathItemModel(name: "EMPTY / FULL", progress: 0),
    PreMathItemModel(name: "SHAPES", progress: 0),
  ];

  getProgress() async {
    log("Progress called");
    if (preMathHiveBoxController.premathBox.values.isNotEmpty) {
      progressList.clear();
      progressList.addAll(preMathHiveBoxController.premathBox.values);
      for (var i = 0; i < progressList.length; i++) {
        items[i].progress = progressList[i].progress;
      }
    }
  }

  navigateToModules({required int index}) {
    var home = Get.find<HomeController>();
    if (!home.isMusicPaused.value) {
      home.pauseOrResumeMusic();
    }
    Get.off(() => IntroVideoView(
          index: index,
          path: _getVideoPath(index: index),
        ));
  }

  _getVideoPath({required int index}) {
    switch (index) {
      case 0:
        return 'assets/videos/big_small_video.mp4';
      case 1:
        return 'assets/videos/far_near_video.mp4';
      default:
        return '';
    }
  }
}
