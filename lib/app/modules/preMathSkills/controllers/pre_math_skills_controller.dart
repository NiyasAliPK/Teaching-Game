import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/modules/farNear/views/far_near_view.dart';
import 'package:teaching_game/app/modules/moreLess/views/more_less_view.dart';

class PreMathSkillsController extends GetxController {
  List<String> items = [
    "BIG / SMALL",
    "FAR / NEAR",
    "MORE / LESS",
    "SAME / DIFFERENT",
    "EMPTY / FULL",
    "CIRCLE",
    "SQUARE",
    "RECTANGLE",
    "TRIANGLE"
  ];

  navigateToModules({required int index}) {
    if (index == 0) {
      Get.to(() => const BigOrSmallView());
    } else if (index == 1) {
      Get.to(() => FarNearView());
    } else if (index == 2) {
      Get.to(() => MoreLessView());
    }
  }
}
