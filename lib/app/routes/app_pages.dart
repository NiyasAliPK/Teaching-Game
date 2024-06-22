import 'package:get/get.dart';

import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/modules/SameOrDifferent/bindings/same_or_different_binding.dart';
import 'package:teaching_game/app/modules/SameOrDifferent/views/same_or_different_view.dart';
import 'package:teaching_game/app/modules/emptyOrFull/bindings/empty_or_full_binding.dart';
import 'package:teaching_game/app/modules/emptyOrFull/views/empty_or_full_view.dart';
import 'package:teaching_game/app/modules/farNear/bindings/far_near_binding.dart';
import 'package:teaching_game/app/modules/farNear/views/far_near_view.dart';
import 'package:teaching_game/app/modules/home/bindings/home_binding.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/modules/introVideo/bindings/intro_video_binding.dart';
import 'package:teaching_game/app/modules/introVideo/views/intro_video_view.dart';
import 'package:teaching_game/app/modules/moreLess/bindings/more_less_binding.dart';
import 'package:teaching_game/app/modules/moreLess/views/more_less_view.dart';
import 'package:teaching_game/app/modules/numeralSkills/bindings/numeral_skills_binding.dart';
import 'package:teaching_game/app/modules/numeralSkills/views/numeral_skills_view.dart';
import 'package:teaching_game/app/modules/preMathSkills/bindings/pre_math_skills_binding.dart';
import 'package:teaching_game/app/modules/preMathSkills/views/pre_math_skills_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PRE_MATH_SKILLS,
      page: () => PreMathSkillsView(),
      binding: PreMathSkillsBinding(),
    ),
    GetPage(
      name: _Paths.NUMERAL_SKILLS,
      page: () => NumeralSkillsView(),
      binding: NumeralSkillsBinding(),
    ),
    GetPage(
      name: _Paths.BIG_OR_SMALL,
      page: () => BigOrSmallView(),
      binding: BigOrSmallBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_VIDEO,
      page: () => IntroVideoView(),
      binding: IntroVideoBinding(),
    ),
    GetPage(
      name: _Paths.FAR_NEAR,
      page: () => FarNearView(),
      binding: FarNearBinding(),
    ),
    GetPage(
      name: _Paths.MORE_LESS,
      page: () => MoreLessView(),
      binding: MoreLessBinding(),
    ),
    GetPage(
      name: _Paths.EMPTY_OR_FULL,
      page: () => EmptyOrFullView(),
      binding: EmptyOrFullBinding(),
    ),
    GetPage(
      name: _Paths.SAME_OR_DIFFERENT,
      page: () => SameOrDifferentView(),
      binding: SameOrDifferentBinding(),
    ),
  ];
}
