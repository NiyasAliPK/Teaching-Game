import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/db/premath_hive.dart';
import 'package:teaching_game/app/db/premath_hive_box.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/emptyOrFull/views/empty_full_slide_three.dart';
import 'package:teaching_game/app/modules/emptyOrFull/views/empty_full_slide_two.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class EmptyOrFullController extends GetxController {
  List<bool> taskProgress = [false, false];

  @override
  void onInit() {
    dragItems.shuffle();
    super.onInit();
  }

  List<DraggableItemModel> fullAcceptedList = [];
  List<DraggableItemModel> emptyAcceptedList = [];

  List<DraggableItemModel> dragItems = [
    //value true means here it's big false means it's small
    DraggableItemModel(
        path: 'assets/images/full_wooden_box.png',
        value: true,
        name: 'woodenBox'),
    DraggableItemModel(
        path: 'assets/images/empty_wooden_box.png',
        value: false,
        name: 'woodenBox'),
    DraggableItemModel(
        path: 'assets/images/full_flower_pot.png', value: true, name: 'pot'),
    DraggableItemModel(
        path: 'assets/images/empty_pot.png', value: false, name: 'pot'),
    DraggableItemModel(
        path: 'assets/images/full_cardbord_box.png',
        value: true,
        name: 'cardbord'),
    DraggableItemModel(
        path: 'assets/images/empty_cardbord.png',
        value: false,
        name: 'cardbord'),
    DraggableItemModel(
        path: 'assets/images/full_wallet.png', value: true, name: 'wallet'),
    DraggableItemModel(
        path: 'assets/images/empty_wallet.png', value: false, name: 'wallet'),
  ];

  List<DraggableItemModel> listForSelectionTask = [
    //value true means here it's big false means it's small
    DraggableItemModel(
        path: 'assets/images/full_wooden_box.png',
        value: true,
        name: 'woodenBox'),
    DraggableItemModel(
        path: 'assets/images/empty_wooden_box.png',
        value: false,
        name: 'woodenBox'),
    DraggableItemModel(
        path: 'assets/images/full_flower_pot.png', value: true, name: 'pot'),
    DraggableItemModel(
        path: 'assets/images/empty_pot.png', value: false, name: 'pot'),
    DraggableItemModel(
        path: 'assets/images/full_cardbord_box.png',
        value: true,
        name: 'cardbord'),
    DraggableItemModel(
        path: 'assets/images/empty_cardbord.png',
        value: false,
        name: 'cardbord'),
    DraggableItemModel(
        path: 'assets/images/full_wallet.png', value: true, name: 'wallet'),
    DraggableItemModel(
        path: 'assets/images/empty_wallet.png', value: false, name: 'wallet'),
    DraggableItemModel(
        path: 'assets/images/empty_bowl.png', value: false, name: 'glass'),
    DraggableItemModel(
        path: 'assets/images/empty_plate.png', value: false, name: 'plate'),
    DraggableItemModel(
        path: 'assets/images/full_basket.png', value: true, name: 'basket'),
  ];

  addToEmptyOrFullList({required DraggableItemModel item}) {
    if (item.value) {
      fullAcceptedList.add(item);
    } else {
      emptyAcceptedList.add(item);
    }
    for (var element in dragItems) {
      if (element.id == item.id) {
        element.isTaskObjectiveComplted = true;
        update();
        break;
      }
    }
    successSoundPlayer();
    checkForTaskCompletionTwo();
  }

  udpateProgress({required index}) {
    taskProgress[index] = true;
    update();
    successSoundPlayer();
    checkForCompletionTaskOne();
  }

  checkForCompletionTaskOne() {
    //RE WRITE THE LOGIC FOR COMPLETEION IN THE ABOVE FUNCTION OR CHECK IT
    int count = 0;
    for (var element in taskProgress) {
      if (element) {
        count++;
      }
    }
    if (count == 2) {
      showDialogueForCompletion(callback: () {
        Get.to(() => const EmptyOrFullSlideTwo());
      });
    }
  }

  checkForTaskCompletionTwo() {
    if (fullAcceptedList.length == 4 && emptyAcceptedList.length == 4) {
      showDialogueForCompletion(callback: () {
        Get.to(() => const EmptyOrFUllSlideThree());
      });
    }
  }

  updateTaskTreeSelectedValue({required DraggableItemModel item}) {
    for (var element in listForSelectionTask) {
      if (element.id == item.id) {
        element.isTaskObjectiveComplted = true;
        break;
      }
    }
    successSoundPlayer();
    checkForTaskCompletionThree();
    update();
  }

  checkForTaskCompletionThree() {
    int count = 0;
    for (var element in listForSelectionTask) {
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
      if (preMathHiveBoxController.premathBox.values.length >= 5) {
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
