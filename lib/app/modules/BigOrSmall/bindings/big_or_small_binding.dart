import 'dart:math';

import 'package:get/get.dart';

import '../controllers/big_or_small_controller.dart';

class BigOrSmallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BigOrSmallController>(
      () => BigOrSmallController(),
    );
  }
}

class DraggableItemModel {
  final String path;
  bool value;
  final String name;

  final int id = Random().nextInt(999);
  DraggableItemModel(
      {required this.path, required this.value, required this.name});

  factory DraggableItemModel.fromMap(Map<String, dynamic> map) {
    return DraggableItemModel(
        path: map['path'] as String,
        value: map['isBig'] as bool,
        name: map['name'] as String);
  }
}
