import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/preMathSkills/bindings/pre_math_skills_binding.dart';
import 'package:teaching_game/app/modules/shapes/bindings/shapes_binding.dart';
import 'package:teaching_game/app/modules/shapes/views/circle_coloring_view.dart';
import 'package:teaching_game/app/modules/shapes/views/common_same_diff_view.dart';
import 'package:teaching_game/app/modules/shapes/views/rectangle_coloring_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shape_drag_drop_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_selection_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/modules/shapes/views/square_coloring_view.dart';
import 'package:teaching_game/app/modules/shapes/views/triangle_coloring_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class ShapesController extends GetxController {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
  ];
  @override
  onInit() {
    itemsForSelection.shuffle();
    dragItems.shuffle();
    shapes.shuffle();
    super.onInit();
  }

  List<PreMathItemModel> items = [
    PreMathItemModel(name: "CIRCLE", progress: 0),
    PreMathItemModel(name: "SQUARE", progress: 0),
    PreMathItemModel(name: "RECTANGLE", progress: 0),
    PreMathItemModel(name: "TRIANGLE", progress: 0),
    PreMathItemModel(name: "COMMON", progress: 0)
  ];

  List<ShapeModel> itemsForSelection = [
    ShapeModel(
        shape: ShapeType.circle,
        color: Colors.white,
        path: 'assets/images/sp_bulls_eye.png'),
    ShapeModel(
        shape: ShapeType.circle,
        color: Colors.white,
        path: 'assets/images/sp_clock.png'),
    ShapeModel(
        shape: ShapeType.circle,
        color: Colors.white,
        path: 'assets/images/sp_cookies.png'),
    ShapeModel(
        shape: ShapeType.circle,
        color: Colors.white,
        path: 'assets/images/sp_pizza.png'),
    ShapeModel(
        shape: ShapeType.square,
        color: Colors.white,
        path: 'assets/images/sp_note.png'),
    ShapeModel(
        shape: ShapeType.square,
        color: Colors.white,
        path: 'assets/images/sp_square_clock.png'),
    ShapeModel(
        shape: ShapeType.rectangle,
        color: Colors.white,
        path: 'assets/images/sp_door.png'),
    ShapeModel(
        shape: ShapeType.rectangle,
        color: Colors.white,
        path: 'assets/images/sp_pool.png'),
    ShapeModel(
        shape: ShapeType.rectangle,
        color: Colors.white,
        path: 'assets/images/sp_tv.png'),
    ShapeModel(
        shape: ShapeType.rectangle,
        color: Colors.white,
        path: 'assets/images/sp_phone.png'),
    ShapeModel(
        shape: ShapeType.triangle,
        color: Colors.white,
        path: 'assets/images/sp_road_sign.png'),
    ShapeModel(
        shape: ShapeType.triangle,
        color: Colors.white,
        path: 'assets/images/sp_sandwiches.png')
  ];

  List<ShapeModel> dragItems = [
    ShapeModel(
        shape: ShapeType.circle,
        color: Colors.white,
        path: 'assets/images/sp_cookies.png'),
    ShapeModel(
        shape: ShapeType.circle,
        color: Colors.white,
        path: 'assets/images/sp_pizza.png'),
    ShapeModel(
        shape: ShapeType.square,
        color: Colors.white,
        path: 'assets/images/sp_note.png'),
    ShapeModel(
        shape: ShapeType.square,
        color: Colors.white,
        path: 'assets/images/chess_2.jpeg'),
    ShapeModel(
        shape: ShapeType.square,
        color: Colors.white,
        path: 'assets/images/sp_square_clock.png'),
    ShapeModel(
        shape: ShapeType.square,
        color: Colors.white,
        path: 'assets/images/sp_frame.png'),
    ShapeModel(
        shape: ShapeType.rectangle,
        color: Colors.white,
        path: 'assets/images/sp_tv.png'),
    ShapeModel(
        shape: ShapeType.rectangle,
        color: Colors.white,
        path: 'assets/images/sp_phone.png'),
    ShapeModel(
        shape: ShapeType.triangle,
        color: Colors.white,
        path: 'assets/images/sp_road_sign.png'),
    ShapeModel(
        shape: ShapeType.triangle,
        color: Colors.white,
        path: 'assets/images/sp_hanger.png'),
    ShapeModel(
        shape: ShapeType.triangle,
        color: Colors.white,
        path: 'assets/images/sp_watermelon.png'),
    ShapeModel(
        shape: ShapeType.triangle,
        color: Colors.white,
        path: 'assets/images/sp_sandwiches.png')
  ];

  List<ShapeModel> shapes = [
    ShapeModel(shape: ShapeType.circle, color: Colors.white),
    ShapeModel(shape: ShapeType.circle, color: Colors.white),
    ShapeModel(shape: ShapeType.circle, color: Colors.white),
    ShapeModel(shape: ShapeType.circle, color: Colors.white),
    ShapeModel(shape: ShapeType.square, color: Colors.white),
    ShapeModel(shape: ShapeType.square, color: Colors.white),
    ShapeModel(shape: ShapeType.square, color: Colors.white),
    ShapeModel(shape: ShapeType.rectangle, color: Colors.white),
    ShapeModel(shape: ShapeType.rectangle, color: Colors.white),
    ShapeModel(shape: ShapeType.rectangle, color: Colors.white),
    ShapeModel(shape: ShapeType.rectangle, color: Colors.white),
    ShapeModel(shape: ShapeType.triangle, color: Colors.white),
    ShapeModel(shape: ShapeType.triangle, color: Colors.white),
    ShapeModel(shape: ShapeType.triangle, color: Colors.white),
    ShapeModel(shape: ShapeType.triangle, color: Colors.white),
  ].obs;

  List<ShapeModel> accepetedLsit = [];
  List<Color> colorListForSquares = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  List<Color> colorListForTriangle = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  List<Color> colorListForCircle = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  List<bool> dragDropForCommon = [false, false, false, false].obs;

  changeSquareColor({required int index, required Color color}) {
    colorListForSquares[index] = color;
    update();
    successSoundPlayer();
    if (colorListForSquares.every((element) => element != Colors.white)) {
      showDialogueForCompletion(callback: () {
        Get.delete<ShapesController>();
        Get.to(() => ShapesView());
      });
    }
  }

  changeTirangleColor({required int index, required Color color}) {
    colorListForTriangle[index] = color;
    update();
    successSoundPlayer();
    if (colorListForTriangle.every((element) => element != Colors.white)) {
      showDialogueForCompletion(callback: () {
        Get.delete<ShapesController>();
        Get.to(() => ShapesView());
      });
    }
  }

  changeCircleColor({required int index, required Color color}) {
    colorListForCircle[index] = color;
    update();
    successSoundPlayer();
    if (colorListForCircle.every((element) => element != Colors.white)) {
      showDialogueForCompletion(callback: () {
        Get.delete<ShapesController>();
        Get.to(() => ShapesView());
      });
    }
  }

  updateSelectedShape({required ShapeModel item}) {
    for (var element in itemsForSelection) {
      if (element.id == item.id) {
        element.isObjectiveCompleted = true;
        successSoundPlayer();
        break;
      }
    }
    update();
  }

  updateAcceptedList(
      {required ShapeModel item, required ShapeType currentShape}) {
    for (var element in dragItems) {
      if (item.id == element.id) {
        element.isObjectiveCompleted = true;
        accepetedLsit.add(element);
        break;
      }
    }
    successSoundPlayer();
    update();
    if (currentShape == ShapeType.square) {
      checkForCompletionOfDragDropOne();
    } else {
      checkForCompletionOfDragDropTwo();
    }
  }

  checkForCompletionOfDragDropOne() {
    if (accepetedLsit.length == 4) {
      showDialogueForCompletion(callback: () {
        Get.to(() => const SquareColoringView());
      });
    }
  }

  checkForCompletionOfDragDropTwo() {
    if (accepetedLsit.length == 4) {
      showDialogueForCompletion(callback: () {
        Get.to(() => const TriangleColoringView());
      });
    }
  }

  checkForCompletionOfSelectionOne({required ShapeType currentShape}) {
    int count = 0;
    for (var element in itemsForSelection) {
      if (element.isObjectiveCompleted) {
        count++;
      }
    }
    if (count == 4) {
      if (currentShape == ShapeType.rectangle) {
        showDialogueForCompletion(
          callback: () {
            Get.off(() => const RectangleColoringView());
          },
        );
      } else if (currentShape == ShapeType.circle) {
        showDialogueForCompletion(
          callback: () {
            Get.off(() => const CircleColoringView());
          },
        );
      }
    }
  }

  updateColorOfCommon({required ShapeModel item, required Color color}) {
    for (var element in shapes) {
      if (element.id == item.id) {
        element.color = color;
        break;
      }
    }
    successSoundPlayer();
    update();
    int count = 0;
    for (var element in shapes) {
      if (element.color != Colors.white) {
        count++;
      }
    }
    if (count == 12) {
      showDialogueForCompletion(callback: () {
        Get.to(() => const CommonSameDiffView());
        Get.delete<ShapesController>();
      });
    }
  }

  updateDragAndDropForCommon({required int index}) {
    dragDropForCommon[index] = true;
    successSoundPlayer();
    if (dragDropForCommon.every(
      (element) => element == true,
    )) {
      showDialogueForCompletion(
        callback: () {
          Get.to(() => ShapesView());
        },
      );
    }
  }

  String getPathForVideo({required int index}) {
    if (index == 0) {
      return 'assets/videos/Circle.mp4';
    } else if (index == 1) {
      return 'assets/videos/Square.mp4';
    } else if (index == 2) {
      return 'assets/videos/rectangle.mp4';
    } else if (index == 3) {
      return 'assets/videos/Triangle.mp4';
    } else {
      return '';
    }
  }
}
