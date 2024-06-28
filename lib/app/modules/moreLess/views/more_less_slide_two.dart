import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/modules/moreLess/controllers/more_less_controller.dart';
import 'package:teaching_game/app/utils/utils.dart';

class MoreLessSlideTwoView extends StatelessWidget {
  MoreLessSlideTwoView({super.key, required this.controller});
  final MoreLessController controller;
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
                          height: context.height / 1.75,
                          child: GridView.builder(
                              itemCount: 4,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: context.width / 2,
                                      crossAxisSpacing: context.width * 0.05,
                                      mainAxisSpacing: context.height * 0.025),
                              itemBuilder: (context, mainIndex) => Container(
                                    padding: EdgeInsets.only(
                                        top: context.height * 0.03),
                                    width: context.width * 0.05,
                                    height: context.height * 0.2,
                                    decoration: BoxDecoration(
                                        color: mainIndex == 0
                                            ? primaryGreen
                                            : mainIndex == 1
                                                ? primaryYellow
                                                : mainIndex == 2
                                                    ? primaryBlue
                                                    : primaryPink,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: SizedBox(
                                      width: context.width,
                                      height: context.height / 3,
                                      child: ItemsCard(
                                          path: mainIndex == 0
                                              ? 'assets/images/apple.png'
                                              : mainIndex == 1
                                                  ? 'assets/images/sm_school_bag.png'
                                                  : mainIndex == 2
                                                      ? 'assets/images/lollipop.png'
                                                      : 'assets/images/beach_ball.png',
                                          count: mainIndex == 0
                                              ? 3
                                              : mainIndex == 1
                                                  ? 2
                                                  : mainIndex == 2
                                                      ? 4
                                                      : 6,
                                          controller: controller),
                                    ),
                                  )),
                        ),
                        SizedBox(height: context.height * 0.005),
                        const Text(
                          "Which have more items ?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemsCard extends StatelessWidget {
  final int count;
  final String path;
  final MoreLessController controller;
  const ItemsCard({
    super.key,
    required this.count,
    required this.path,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (count == 6) {
          controller.udpateProgress(index: 1);
        } else {
          showDialogueForWrongAttempt();
        }
      },
      child: GridView.builder(
          itemCount: count,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: context.width / 5,
              childAspectRatio: 2.5,
              crossAxisSpacing: context.width * 0.025,
              mainAxisSpacing: context.height * 0.01),
          itemBuilder: (context, mainIndex) => Image.asset(path)),
    );
  }
}
