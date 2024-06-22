import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:teaching_game/app/db/premath_hive.dart';

class PreMathHiveBoxController extends GetxController {
  late Box<PreMathProgressModel> premathBox;

  @override
  onInit() {
    _openBox();
    super.onInit();
  }

  getAllProgress() async {
    return premathBox.values;
  }

  _openBox() async {
    try {
      premathBox = Hive.box<PreMathProgressModel>('premath');
    } catch (e) {
      log("Failed open the box ===> $e");
    }
  }

  updateProgress({required PreMathProgressModel value}) async {
    try {
      await premathBox.put(value.id, value);
    } catch (e) {
      log("Falied to update progress of premath >>> $e");
    }
  }
}
