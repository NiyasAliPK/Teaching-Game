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
