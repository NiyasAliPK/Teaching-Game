import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/emptyOrFull/controllers/empty_or_full_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class EmptyOrFUllSlideThree extends StatefulWidget {
  const EmptyOrFUllSlideThree({super.key});

  @override
  State<EmptyOrFUllSlideThree> createState() => _EmptyOrFUllSlideThreeState();
}

class _EmptyOrFUllSlideThreeState extends State<EmptyOrFUllSlideThree> {
  final EmptyOrFullController _controller = Get.put(EmptyOrFullController());

  DateTime? lastPressedTime;

  @override
  void initState() {
    showDialogueForInstructions(
        instruction:
            "Click on the empty items. Select all empty items to compelte the task.");
    super.initState();
  }

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
        fit: StackFit.expand,
        children: [
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.topCenter,
            colors: [Color(0xFFAEEEEE), Color(0xFF20B2AA)],
          ))),
          Padding(
            padding: EdgeInsets.only(top: context.height * 0.075),
            child: Column(
              children: [
                Container(
                  height: context.height - 100,
                  width: context.width / 1.075,
                  padding: EdgeInsets.only(top: context.height * 0.05),
                  decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.25),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: GetBuilder<EmptyOrFullController>(
                    builder: (controller) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        spacing: context.width * 0.03,
                        runSpacing: context.height * 0.01,
                        children: controller.listForSelectionTask.map((item) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(context.height * 0.015),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                      scale: 2, image: AssetImage(item.path)),
                                ),
                                width: context.width / 5,
                                height: context.height / 6,
                              ),
                              GetBuilder<EmptyOrFullController>(
                                builder: (controller) => Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: primaryPink,
                                      value: item.isTaskObjectiveComplted,
                                      onChanged: (newValue) {
                                        if (!item.value) {
                                          _controller
                                              .updateTaskTreeSelectedValue(
                                                  item: item);
                                        } else {
                                          showDialogueForWrongAttempt();
                                        }
                                      }),
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
