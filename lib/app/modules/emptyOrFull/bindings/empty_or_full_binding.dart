import 'package:get/get.dart';

import '../controllers/empty_or_full_controller.dart';

class EmptyOrFullBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmptyOrFullController>(
      () => EmptyOrFullController(),
    );
  }
}
