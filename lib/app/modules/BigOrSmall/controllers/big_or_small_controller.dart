import 'dart:developer';

import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/balloon_pop_view.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/fish_bowl_view.dart';
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
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
    DraggableItemModel(
        path: 'assets/images/red_balloon.png', value: false, name: 'balloon'),
  ];

  List<DraggableItemModel> fishes = [
    //
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_2.png', value: false, name: 'fish'),
    DraggableItemModel(
        path: 'assets/images/fish_1.png', value: false, name: 'fish'),
  ];

  final List<DraggableItemModel> smallAccpetedList = [];
  final List<DraggableItemModel> bigAccpetedList = [];
  final List<DraggableItemModel> acceptedListOfFish = [];

  checkForCompletionTaskOne() {
    if (smallAccpetedList.length == 4 && bigAccpetedList.length == 4) {
      showDialogueForCompletion(
        callback: () {
          Get.offAll(() => BalloonPoperView());
        },
      );
    }
  }

  _checkForCompletionTaskTwo() {
    for (var element in balloonsToPop) {
      if (!element.value) {
        return;
      }
    }
    // if the loop completed without returning means all the balloons have popped
    showDialogueForCompletion(
      callback: () {
        Get.offAll(() => FishBowlView());
      },
    );
  }

  updateFishInTank({required DraggableItemModel item}) {
    acceptedListOfFish.add(item);
    for (var element in fishes) {
      if (element.id == item.id) {
        element.value = true;
        update();
        checkForCompletionTaskThree();
        break;
      }
    }
  }

  checkForCompletionTaskThree() {
    if (acceptedListOfFish.length == 12) {
      showDialogueForCompletion(
        callback: () {
          Get.offAll(() => HomeView());
        },
      );
    }
  }

  popTheBalloon({required int position}) {
    balloonsToPop[position].value = true;
    update();
    _checkForCompletionTaskTwo();
  }
}
