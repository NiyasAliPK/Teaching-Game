import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/views/big_or_small_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

import '../controllers/pre_math_skills_controller.dart';

class PreMathSkillsView extends GetView<PreMathSkillsController> {
  final PreMathSkillsController _controller =
      Get.put(PreMathSkillsController());
  PreMathSkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafePadding(
        child: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Get.to(() => BigOrSmallView());
                  },
                  child: Container(
                    height: context.height / 5,
                    width: context.width / 2,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(width: 2, color: Colors.white30)),
                    child: Center(
                      child: Text(
                        _controller.items[index],
                        style: TextStyle(
                            fontSize: context.width * 0.075,
                            color: primaryBlue.withOpacity(0.75),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: context.height * 0.05,
                ),
            itemCount: _controller.items.length));
  }
}
