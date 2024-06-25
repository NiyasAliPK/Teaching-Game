import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';

import '../controllers/shapes_controller.dart';

class ShapesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShapesController>(
      () => ShapesController(),
    );
  }
}

class ShapeModel {
  final ShapeType shape;
  Color color;
  int id = Random().nextInt(999);
  bool isObjectiveCompleted;
  String path;

  ShapeModel(
      {required this.shape,
      required this.color,
      this.isObjectiveCompleted = false,
      this.path = ''});
}
