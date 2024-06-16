import 'package:get/get.dart';

import '../controllers/intro_video_controller.dart';

class IntroVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroVideoController>(
      () => IntroVideoController(),
    );
  }
}
