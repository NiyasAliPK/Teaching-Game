import 'package:get/get.dart';

import '../controllers/more_less_controller.dart';

class MoreLessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoreLessController>(
      () => MoreLessController(),
    );
  }
}
