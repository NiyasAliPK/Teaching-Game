import 'package:get/get.dart';

import '../controllers/same_or_different_controller.dart';

class SameOrDifferentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SameOrDifferentController>(
      () => SameOrDifferentController(),
    );
  }
}
