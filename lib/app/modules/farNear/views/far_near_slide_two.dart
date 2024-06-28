import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/farNear/controllers/far_near_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class FarNearSecondSlide extends StatelessWidget {
  final FarNearController controller;
  FarNearSecondSlide({super.key, required this.controller});
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
            ))),
            GetBuilder<FarNearController>(
                builder: (controller) => Column(
                      children: [
                        SizedBox(height: context.height * 0.125),
                        Container(
                          padding: EdgeInsets.all(context.width * 0.05),
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
                                    onTap: controller.taskProgress[2]
                                        ? null
                                        : () {
                                            showDialogueForWrongAttempt();
                                          },
                                    child: Image.asset(
                                      'assets/images/fn_cars.jpeg',
                                      height: context.height / 4,
                                      width: context.width,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.udpateProgress(index: 2);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      margin: EdgeInsets.only(
                                          top: context.height * 0.075,
                                          left: context.width * 0.475),
                                      width: context.width * 0.325,
                                      height: context.height * 0.175,
                                      child: controller.taskProgress[2]
                                          ? Image.asset(
                                              'assets/images/green_tick.png')
                                          : null,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: context.height * 0.005),
                              const Text(
                                "Click on the Nearest car",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(context.width * 0.05),
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
                                    onTap: controller.taskProgress[3]
                                        ? null
                                        : () {
                                            showDialogueForWrongAttempt();
                                          },
                                    child: Image.asset(
                                      'assets/images/fn_trees.jpeg',
                                      height: context.height / 4,
                                      width: context.width,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.udpateProgress(index: 3);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      margin: EdgeInsets.only(
                                          top: context.height * 0.075,
                                          left: context.width * 0.485),
                                      width: context.width * 0.225,
                                      height: context.height * 0.125,
                                      child: controller.taskProgress[3]
                                          ? Image.asset(
                                              'assets/images/green_tick.png')
                                          : null,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: context.height * 0.005),
                              const Text(
                                "Click on the Distant tree",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
          ],
        ),
      ),
    );
  }
}
