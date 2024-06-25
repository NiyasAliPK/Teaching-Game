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
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: controller.taskProgress[1]
                                  ? null
                                  : () {
                                      showDialogueForWrongAttempt();
                                    },
                              child: Image.asset(
                                'assets/images/ml_random_objects.jpeg',
                                height: context.height / 1.75,
                                width: context.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.udpateProgress(index: 1);
                              },
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(
                                    top: context.height * 0.1,
                                    left: context.width * 0.05),
                                width: context.width * 0.22,
                                height: context.height * 0.175,
                                child: controller.taskProgress[1]
                                    ? Image.asset(
                                        'assets/images/green_tick.png')
                                    : null,
                              ),
                            )
                          ],
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
