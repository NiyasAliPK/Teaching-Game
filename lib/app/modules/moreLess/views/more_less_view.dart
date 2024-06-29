import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/modules/moreLess/views/more_less_slide_two.dart';
import 'package:teaching_game/app/utils/utils.dart';

import '../controllers/more_less_controller.dart';

class MoreLessView extends GetView<MoreLessController> {
  MoreLessView({super.key});
  final MoreLessController _controller = Get.put(MoreLessController());
  DateTime? lastPressedTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (lastPressedTime == null ||
            now.difference(lastPressedTime!) > const Duration(seconds: 2)) {
          lastPressedTime = now;
          Get.showSnackbar(const GetSnackBar(
            message: "Click again to go back to home",
            duration: Duration(seconds: 2),
          ));
          return false;
        }
        Get.offAll(() => HomeView());
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  colors: [Color(0xFFAEEEEE), Color(0xFF20B2AA)],
                ),
              ),
            ),
            GetBuilder<MoreLessController>(
              builder: (controller) => Column(
                children: [
                  SizedBox(height: context.height * 0.125),
                  Container(
                    padding: EdgeInsets.all(context.width * 0.05),
                    margin: EdgeInsets.all(context.width * 0.05),
                    width: context.width,
                    height: context.height / 1.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            width: context.width,
                            height: context.height / 1.8,
                            child: GetBuilder<MoreLessController>(
                              builder: (controller) => GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.itemsForFishBowl.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: context.width / 2),
                                itemBuilder: (context, index) => Stack(
                                  children: [
                                    GestureDetector(
                                        onTap: controller
                                                    .itemsForFishBowl[index]
                                                    .isTaskObjectiveComplted &&
                                                _controller
                                                    .itemsForFishBowl[index]
                                                    .value
                                            ? null
                                            : () {
                                                if (_controller
                                                    .itemsForFishBowl[index]
                                                    .value) {
                                                  _controller.selectFishes(
                                                      index: index);
                                                } else {
                                                  showDialogueForWrongAttempt();
                                                }
                                              },
                                        child: Image.asset(controller
                                            .itemsForFishBowl[index].path)),
                                    _controller.itemsForFishBowl[index]
                                            .isTaskObjectiveComplted
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                top: context.height * 0.05,
                                                left: context.width * 0.1),
                                            width: context.width * 0.2,
                                            child: Image.asset(
                                                'assets/images/green_tick.png'))
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(height: context.height * 0.0075),
                        const Text(
                          "Which bowl have more fishes in each row ?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  _controller.taskProgress[0]
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryPink),
                          onPressed: () {
                            Get.to(MoreLessSlideTwoView(
                              controller: _controller,
                            ));
                          },
                          child: const Text(
                            "NEXT",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
