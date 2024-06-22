import 'package:get/get.dart';

import '../controllers/pre_math_skills_controller.dart';

class PreMathSkillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreMathSkillsController>(
      () => PreMathSkillsController(),
    );
  }
}

class PreMathItemModel {
  final String name;
  double progress;
  PreMathItemModel({required this.name, required this.progress});
}
