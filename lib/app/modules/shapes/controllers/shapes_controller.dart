import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/preMathSkills/bindings/pre_math_skills_binding.dart';
import 'package:teaching_game/app/modules/shapes/bindings/shapes_binding.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_coloring_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class ShapesController extends GetxController {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.purple,
    const Color(0xFFFF4500), // Red-Orange
    const Color(0xFFFFD700), // Yellow-Orange
    const Color(0xFFADFF2F), // Yellow-Green
    const Color(0xFF00CED1), // Blue-Green
    const Color(0xFF8A2BE2), // Blue-Purple
    const Color(0xFFDA70D6), // Red-Purple
  ];
  @override
  onInit() {
    shapes.shuffle();
    itemsForSelection.shuffle();
    super.onInit();
  }

  List<PreMathItemModel> items = [
    PreMathItemModel(name: "CIRCLE", progress: 0),
    PreMathItemModel(name: "SQUARE", progress: 0),
    PreMathItemModel(name: "RECTANGLE", progress: 0),
    PreMathItemModel(name: "TRIANGLE", progress: 0)
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
        path: 'assets/images/sp_chess.png'),
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

  updateTheColor({required ShapeModel item, required Color color}) {
    for (var element in shapes) {
      if (element.id == item.id) {
        element.color = color;
        break;
      }
    }
    successSoundPlayer();
    update();
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

  checkForCompletionOfSelection({required ShapeType currentShape}) {
    int count = 0;
    for (var element in itemsForSelection) {
      if (element.isObjectiveCompleted) {
        count++;
      }
    }
    if (count == 4) {
      showDialogueForCompletion(
        callback: () {
          Get.off(() => ShapesColoringView(currentShape: currentShape));
        },
      );
    }
  }

  checkForCompletionOfcoloring({required ShapeType currentShape}) {
    int count = 0;
    for (var element in shapes) {
      if (element.shape == currentShape && element.color != Colors.white) {
        count++;
      }
    }
    if (count == 4) {
      showDialogueForCompletion(
        callback: () {
          Get.offAll(() => ShapesView());
        },
      );
    }
  }
}
