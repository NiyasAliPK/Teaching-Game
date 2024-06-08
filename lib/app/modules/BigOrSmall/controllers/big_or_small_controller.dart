import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/balloon_pop_view.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/fish_bowl_view.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/select_big_small_view.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class BigOrSmallController extends GetxController {
  List<DraggableItemModel> dragItems = [
    //value true means here it's big false means it's small
    DraggableItemModel(
        path: 'assets/images/beach_ball.png', value: true, name: 'beachBall'),
    DraggableItemModel(
        path: 'assets/images/beach_ball.png', value: false, name: 'beachBall'),
    DraggableItemModel(
        path: 'assets/images/elephant.png', value: true, name: 'elephant'),
    DraggableItemModel(
        path: 'assets/images/elephant.png', value: false, name: 'elephant'),
    DraggableItemModel(
        path: 'assets/images/yellow_balloon.png', value: true, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/yellow_balloon.png',
        value: false,
        name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/chappal.png', value: true, name: 'chappal'),
    DraggableItemModel(
        path: 'assets/images/chappal.png', value: false, name: 'chappal'),
  ];

  List<DraggableItemModel> balloonsToPop = [
    //value false means here the balloon hasn't popped
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: true, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: true, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: true, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: true, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: true, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: true, name: 'balloon'),
  ];

  List<DraggableItemModel> fishes = [
    //
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: true, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: true, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: true, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: true, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: true, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: true, name: 'fish'),
  ];

  List<DraggableItemModel> listForBigsAndSmalls = [
    DraggableItemModel(
        path: 'assets/images/tree.png', value: false, name: 'tree'),
    DraggableItemModel(
        path: 'assets/images/tree.png', value: true, name: 'tree'),
    DraggableItemModel(
        path: 'assets/images/car.png', value: false, name: 'car'),
    DraggableItemModel(path: 'assets/images/car.png', value: true, name: 'car'),
    DraggableItemModel(
        path: 'assets/images/house.png', value: false, name: 'house'),
    DraggableItemModel(
        path: 'assets/images/house.png', value: true, name: 'house'),
    DraggableItemModel(
        path: 'assets/images/apple.png', value: false, name: 'apple'),
    DraggableItemModel(
        path: 'assets/images/apple.png', value: true, name: 'apple'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: false, name: 'fish_2'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: true, name: 'fish_2'),
    DraggableItemModel(
        path: 'assets/images/elephant.png', value: false, name: 'elephant'),
    DraggableItemModel(
        path: 'assets/images/elephant.png', value: true, name: 'elephant'),
    DraggableItemModel(
        path: 'assets/images/beach_ball.png', value: false, name: 'beach_ball'),
    DraggableItemModel(
        path: 'assets/images/beach_ball.png', value: true, name: 'beach_ball'),
  ];

  final List<DraggableItemModel> smallAccpetedList = [];
  final List<DraggableItemModel> bigAccpetedList = [];
  final List<DraggableItemModel> acceptedListOfFish = [];
  int countOfCompletedInTaskFour = 0;
  int countOfballoonsPopped = 0;

  checkForCompletionTaskOne() {
    if (smallAccpetedList.length == 4 && bigAccpetedList.length == 4) {
      showDialogueForCompletion(
        callback: () {
          Get.offAll(() => const BalloonPoperView());
        },
      );
    }
  }

  _checkForCompletionTaskTwo() {
    if (countOfballoonsPopped == 6) {
      // if the loop completed without returning means all the balloons have popped
      showDialogueForCompletion(
        callback: () {
          Get.offAll(() => const FishBowlView());
        },
      );
    }
  }

  updateFishInTank({required DraggableItemModel item}) {
    if (item.value) {
      for (var element in fishes) {
        if (element.id == item.id) {
          acceptedListOfFish.add(item);
          element.isTaskObjectiveComplted = true;
          update();
          _checkForCompletionTaskThree();
          break;
        }
      }
    } else {
      showDialogueForWrongAttempt();
    }
  }

  _checkForCompletionTaskThree() {
    if (acceptedListOfFish.length == 6) {
      showDialogueForCompletion(
        callback: () {
          Get.offAll(() => const SelectSmallAndBig());
        },
      );
    }
  }

  _checkForCompletionOfFour() {
    if (countOfCompletedInTaskFour == 14) {
      showDialogueForCompletion(
        callback: () {
          Get.offAll(() => HomeView());
        },
      );
      return;
    }
  }

  selectBigOrsmall(
      {required DraggableItemModel item, required bool selectedValue}) {
    if (item.value != selectedValue) {
      showDialogueForWrongAttempt();
      return;
    }

    for (var element in listForBigsAndSmalls) {
      if (element.name == item.name &&
          element.value == item.value &&
          element.value == selectedValue) {
        element.isTaskObjectiveComplted = true;
        countOfCompletedInTaskFour++;
        update();
        break;
      }
    }
    _checkForCompletionOfFour();
  }

  popTheBalloon({required DraggableItemModel value}) {
    if (value.value == false) // this means the balloon is big
    {
      for (var element in balloonsToPop) {
        if (element.id == value.id) {
          element.isTaskObjectiveComplted = true;
          countOfballoonsPopped++;
          update();
          break;
        }
      }
      _checkForCompletionTaskTwo();
    } else {
      showDialogueForWrongAttempt();
    }
  }
}
