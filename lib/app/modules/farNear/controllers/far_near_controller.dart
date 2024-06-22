import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/db/premath_hive.dart';
import 'package:teaching_game/app/db/premath_hive_box.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class FarNearController extends GetxController {
  List<bool> taskProgress = [false, false, false, false];

  udpateProgress({required index}) {
    taskProgress[index] = true;
    update();
    if (checkForCompletion()) {
      showDialogueForCompletion(callback: () {
        Get.offAll(() => HomeView());
      });
      final PreMathHiveBoxController preMathHiveBoxController =
          Get.put(PreMathHiveBoxController());
      if (preMathHiveBoxController.premathBox.values.length >= 2) {
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
    if (count == 4) {
      return true;
    } else {
      return false;
    }
  }
}
