import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teaching_game/app/modules/emptyOrFull/views/empty_full_slide_two.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

import '../controllers/empty_or_full_controller.dart';

class EmptyOrFullView extends GetView<EmptyOrFullController> {
  final EmptyOrFullController _controller = Get.put(EmptyOrFullController());
  DateTime? lastPressedTime;

  EmptyOrFullView({super.key});
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
            ))),
            GetBuilder<EmptyOrFullController>(
              builder: (controller) => Column(
                children: [
                  SizedBox(height: context.height * 0.125),
                  Container(
                    padding: EdgeInsets.all(context.width * 0.025),
                    margin: EdgeInsets.all(context.width * 0.05),
                    width: context.width,
                    height: context.height / 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: controller.taskProgress[0]
                                  ? null
                                  : () {
                                      showDialogueForWrongAttempt();
                                    },
                              child: Image.asset(
                                'assets/images/ef_trees.jpeg',
                                height: context.height / 4,
                                width: context.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.udpateProgress(index: 0);
                              },
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(
                                    top: context.height * 0.055,
                                    left: context.width * 0.3),
                                width: context.width * 0.225,
                                height: context.height * 0.125,
                                child: _controller.taskProgress[0]
                                    ? Image.asset(
                                        'assets/images/green_tick.png')
                                    : null,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: context.height * 0.005),
                        const Text(
                          "Which tree hole is empty ?",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(context.width * 0.025),
                    margin: EdgeInsets.all(context.width * 0.05),
                    width: context.width,
                    height: context.height / 3,
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
                                'assets/images/ef_trucks.jpeg',
                                height: context.height / 4,
                                width: context.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.udpateProgress(index: 1);
                              },
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(
                                    top: context.height * 0.145),
                                width: context.width * 0.325,
                                height: context.height * 0.075,
                                child: _controller.taskProgress[1]
                                    ? Image.asset(
                                        'assets/images/green_tick.png')
                                    : null,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: context.height * 0.005),
                        const Text(
                          "Click the empty truck",
                          style: TextStyle(color: Colors.black, fontSize: 20),
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
