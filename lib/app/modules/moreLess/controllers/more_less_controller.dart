import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/db/premath_hive.dart';
import 'package:teaching_game/app/db/premath_hive_box.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class MoreLessController extends GetxController {
  List<bool> taskProgress = [false, false];
  List<DraggableItemModel> itemsForFishBowl = [
    DraggableItemModel(
        path: 'assets/images/sm_fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/sm_fish_3.png', value: true, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/sm_fish_6.png', value: true, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/sm_fish_2.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/sm_fish_4.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/sm_fish_5.png', value: true, name: 'fish'),
  ];

  udpateProgress({required index}) {
    taskProgress[index] = true;
    update();
    successSoundPlayer();
    if (checkForCompletion()) {
      showDialogueForCompletion(callback: () {
        Get.offAll(() => HomeView());
      });
      final PreMathHiveBoxController preMathHiveBoxController =
          Get.put(PreMathHiveBoxController());
      if (preMathHiveBoxController.premathBox.values.length >= 3) {
        log("This level is already marked as completed");
        return; // This means the current level is already completed and no need to update or add the same level again to the db
      }
      preMathHiveBoxController.updateProgress(
          value: PreMathProgressModel(
              progress: 1,
              id: DateTime.now().millisecondsSinceEpoch.toString()));
    }
  }

  bool checkForCompletion() {
    int count = 0;
    for (var element in taskProgress) {
      if (element) {
        count++;
      }
    }
    if (count == 2) {
      return true;
    } else {
      return false;
    }
  }

  selectFishes({required int index}) {
    itemsForFishBowl[index].isTaskObjectiveComplted = true;
    update();
    successSoundPlayer();
    int count = 0;
    for (var element in itemsForFishBowl) {
      if (element.value && element.isTaskObjectiveComplted) {
        count++;
      }
    }
    if (count == 3) {
      udpateProgress(index: 0);
    }
  }
}
