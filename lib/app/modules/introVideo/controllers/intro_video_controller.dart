import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/modules/SameOrDifferent/views/same_or_different_view.dart';
import 'package:teaching_game/app/modules/emptyOrFull/views/empty_or_full_view.dart';
import 'package:teaching_game/app/modules/farNear/views/far_near_view.dart';
import 'package:teaching_game/app/modules/moreLess/views/more_less_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';

class IntroVideoController extends GetxController {
  navigateScreen({required int index}) {
    if (index == 0) {
      Get.off(() => const BigOrSmallView());
    } else if (index == 1) {
      Get.off(() => FarNearView());
    } else if (index == 2) {
      Get.off(() => MoreLessView());
    } else if (index == 3) {
      Get.off(() => SameOrDifferentView());
    } else if (index == 4) {
      Get.off(() => EmptyOrFullView());
    } else if (index == 5) {
      Get.off(() => ShapesView());
    }
  }
}
