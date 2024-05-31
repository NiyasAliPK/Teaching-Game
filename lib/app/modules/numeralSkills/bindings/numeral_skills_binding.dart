import 'package:get/get.dart';

import '../controllers/numeral_skills_controller.dart';

class NumeralSkillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NumeralSkillsController>(
      () => NumeralSkillsController(),
    );
  }
}
