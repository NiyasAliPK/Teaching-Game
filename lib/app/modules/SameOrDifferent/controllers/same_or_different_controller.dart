import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/db/premath_hive.dart';
import 'package:teaching_game/app/db/premath_hive_box.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/SameOrDifferent/views/same_or_different_slide_two.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class SameOrDifferentController extends GetxController {
  List<bool> taskProgress = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<DraggableItemModel> draggables = [
    DraggableItemModel(
        path: 'assets/images/sm_school_bus.png',
        value: false,
        name: "schoolBus"),
    DraggableItemModel(
        path: 'assets/images/sm_school_bag.png',
        value: false,
        name: "schoolbag"),
    DraggableItemModel(
        path: 'assets/images/sm_shoes.png', value: false, name: "shoes"),
    DraggableItemModel(
        path: 'assets/images/sm_leaf.png', value: false, name: "leaf"),
    DraggableItemModel(
        path: 'assets/images/sm_scissor.png', value: false, name: "scissor"),
    DraggableItemModel(
        path: 'assets/images/sm_foot_ball.png', value: false, name: "football"),
  ];
  List<DraggableItemModel> dragTargets = [
    DraggableItemModel(
        path: 'assets/images/sm_school_bus.png',
        value: false,
        name: "schoolBus"),
    DraggableItemModel(
        path: 'assets/images/sm_school_bag.png',
        value: false,
        name: "schoolbag"),
    DraggableItemModel(
        path: 'assets/images/sm_shoes.png', value: false, name: "shoes"),
    DraggableItemModel(
        path: 'assets/images/sm_leaf.png', value: false, name: "leaf"),
    DraggableItemModel(
        path: 'assets/images/sm_scissor.png', value: false, name: "scissor"),
    DraggableItemModel(
        path: 'assets/images/sm_foot_ball.png', value: false, name: "football"),
  ];

  udpateTaskProgress({required int index}) {
    taskProgress[index] = true;
    update();
    if (checkforCompletionTaskOne()) {
      showDialogueForCompletion(callback: () {
        Get.offAll(() => const SameOrDifferentSlideTwo());
      });
    }
  }

  bool checkforCompletionTaskOne() {
    return taskProgress.every((element) => element == true);
  }

  updateMatched({required DraggableItemModel item}) {
    for (var element in dragTargets) {
      if (element.name == item.name) {
        log("message1");
        element.isTaskObjectiveComplted = true;
      }
    }
    for (var element in draggables) {
      if (element.name == item.name) {
        log("message2");

        element.isTaskObjectiveComplted = true;
      }
    }
  }

  checkForCompletionTaskTwo() {
    int count = 0;
    for (var element in draggables) {
      if (element.isTaskObjectiveComplted) {
        count++;
      }
    }
    if (count == 6) {
      showDialogueForCompletion(callback: () {
        Get.offAll(() => HomeView());
      });
      final PreMathHiveBoxController preMathHiveBoxController =
          Get.put(PreMathHiveBoxController());
      if (preMathHiveBoxController.premathBox.values.length >= 4) {
        log("This level is already marked as completed");
        return; // This means the current level is already completed and no need to update or add the same level again to the db
      }
      preMathHiveBoxController.updateProgress(
          value: PreMathProgressModel(
              progress: 1,
              id: DateTime.now().millisecondsSinceEpoch.toString()));
      return;
    }
  }
}
