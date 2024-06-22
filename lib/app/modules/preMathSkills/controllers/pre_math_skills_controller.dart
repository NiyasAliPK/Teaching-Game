import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/db/premath_hive.dart';
import 'package:teaching_game/app/db/premath_hive_box.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/modules/SameOrDifferent/views/same_or_different_view.dart';
import 'package:teaching_game/app/modules/emptyOrFull/views/empty_or_full_view.dart';
import 'package:teaching_game/app/modules/farNear/views/far_near_view.dart';
import 'package:teaching_game/app/modules/moreLess/views/more_less_view.dart';
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
    PreMathItemModel(name: "CIRCLE", progress: 0),
    PreMathItemModel(name: "SQUARE", progress: 0),
    PreMathItemModel(name: "RECTANGLE", progress: 0),
    PreMathItemModel(name: "TRIANGLE", progress: 0)
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
    if (index == 0) {
      Get.to(() => const BigOrSmallView());
    } else if (index == 1) {
      Get.to(() => FarNearView());
    } else if (index == 2) {
      Get.to(() => MoreLessView());
    } else if (index == 3) {
      Get.to(() => SameOrDifferentView());
    } else if (index == 4) {
      Get.to(() => EmptyOrFullView());
    }
  }
}
