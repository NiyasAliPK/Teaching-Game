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
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: _controller.taskProgress[0]
                                  ? null
                                  : () {
                                      showDialogueForWrongAttempt();
                                    },
                              child: Image.asset(
                                'assets/images/ml_fish.jpeg',
                                height: context.height / 1.75,
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
                                    top: context.height * 0.38,
                                    left: context.width * 0.4),
                                width: context.width * 0.5,
                                height: context.height * 0.15,
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
                          "Which bowl have more fishes ?",
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
