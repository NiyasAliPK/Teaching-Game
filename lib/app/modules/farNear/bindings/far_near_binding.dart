import 'package:get/get.dart';

import '../controllers/far_near_controller.dart';

class FarNearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarNearController>(
      () => FarNearController(),
    );
  }
}
