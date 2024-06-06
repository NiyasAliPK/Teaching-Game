import 'package:get/get.dart';

import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/modules/home/bindings/home_binding.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
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
  ];
}
