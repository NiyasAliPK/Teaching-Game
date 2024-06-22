import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teaching_game/app/utils/utils.dart';

import '../controllers/same_or_different_controller.dart';

class SameOrDifferentView extends GetView<SameOrDifferentController> {
  final SameOrDifferentController _controller =
      Get.put(SameOrDifferentController());

  SameOrDifferentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.topCenter,
          colors: [Color(0xFFAEEEEE), Color(0xFF20B2AA)],
        ))),
        Column(
          children: [
            SizedBox(height: context.height * 0.075),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.025,
                  vertical: context.height * 0.015),
              margin: EdgeInsets.all(context.width * 0.025),
              width: context.width,
              height: context.height / 2.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/sm_image_one.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  SizedBox(height: context.height * 0.005),
                  const Text(
                    "Image A",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.025,
                    vertical: context.height * 0.015),
                margin: EdgeInsets.all(context.width * 0.025),
                width: context.width,
                height: context.height / 2.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GetBuilder<SameOrDifferentController>(
                  builder: (controller) => Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: controller.checkforCompletionTaskOne()
                                ? null
                                : () {
                                    showDialogueForWrongAttempt();
                                  },
                            child: Image.asset(
                              'assets/images/sm_image_two.jpg',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 0);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin:
                                  EdgeInsets.only(left: context.width * 0.19),
                              width: context.width * 0.15,
                              height: context.height * 0.05,
                              child: _controller.taskProgress[0]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 1);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin:
                                  EdgeInsets.only(left: context.width * 0.525),
                              width: context.width * 0.16,
                              height: context.height * 0.06,
                              child: _controller.taskProgress[1]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 2);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin:
                                  EdgeInsets.only(left: context.width * 0.7),
                              width: context.width * 0.15,
                              height: context.height * 0.075,
                              child: _controller.taskProgress[2]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 3);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(
                                  left: context.width * 0.25,
                                  top: context.height * 0.06),
                              width: context.width * 0.125,
                              height: context.height * 0.0425,
                              child: _controller.taskProgress[3]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 4);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(
                                  left: context.width * 0.4,
                                  top: context.height * 0.2225),
                              width: context.width * 0.2,
                              height: context.height * 0.055,
                              child: _controller.taskProgress[4]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 5);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(
                                  left: context.width * 0.625,
                                  top: context.height * 0.175),
                              width: context.width * 0.2,
                              height: context.height * 0.055,
                              child: _controller.taskProgress[5]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 6);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(
                                  left: context.width * 0.615,
                                  top: context.height * 0.115),
                              width: context.width * 0.175,
                              height: context.height * 0.045,
                              child: _controller.taskProgress[6]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.udpateTaskProgress(index: 7);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(
                                  left: context.width * 0.625,
                                  top: context.height * 0.235),
                              width: context.width * 0.1,
                              height: context.height * 0.04,
                              child: _controller.taskProgress[7]
                                  ? Image.asset('assets/images/green_tick.png')
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.height * 0.005),
                      const Text(
                        "Image B",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: context.width * 0.05, top: context.height * 0.025),
              child: const Text(
                "Find all 8 the difference in image B from image A and click on them.",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )
          ],
        ),
      ],
    ));
  }
}
