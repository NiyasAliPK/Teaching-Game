import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/modules/SameOrDifferent/views/same_or_different_view.dart';
import 'package:teaching_game/app/modules/emptyOrFull/views/empty_or_full_view.dart';
import 'package:teaching_game/app/modules/farNear/views/far_near_view.dart';
import 'package:teaching_game/app/modules/home/controllers/home_controller.dart';
import 'package:teaching_game/app/modules/moreLess/views/more_less_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';

class IntroVideoController extends GetxController {
  FlickManager? flickManager;
  RxBool isVisible = false.obs;

  navigateScreen({required int index}) async {
    var homecontroller = Get.find<HomeController>();
    if (!homecontroller.isManuallyPaused) {
      homecontroller.pauseOrResumeMusic();
    }

    if (index == 0) {
      Get.to(() => const BigOrSmallView());
    } else if (index == 1) {
      Get.to(() => FarNearView());
    } else if (index == 2) {
      Get.to(() => MoreLessView());
    } else if (index == 3) {
      Get.to(() => SameOrDifferentView());
    } else if (index == 4) {
      Get.to(() => EmptyOrFullView());
    } else if (index == 5) {
      Get.to(() => ShapesView());
    }
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.delete<IntroVideoController>();
  }

  showSkipButton() async {
    await Future.delayed(const Duration(seconds: 3));
    isVisible.value = true;
  }
}
