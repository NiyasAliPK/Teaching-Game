import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/emptyOrFull/controllers/empty_or_full_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class EmptyOrFullSlideTwo extends StatefulWidget {
  const EmptyOrFullSlideTwo({super.key});

  @override
  State<EmptyOrFullSlideTwo> createState() => _EmptyOrFullSlideTwoState();
}

class _EmptyOrFullSlideTwoState extends State<EmptyOrFullSlideTwo> {
  @override
  void initState() {
    showDialogueForInstructions(
        instruction:
            "Drag and drop empty items into the empty box and items which are not empty to the full box.");
    super.initState();
  }

  final EmptyOrFullController controller = Get.put(EmptyOrFullController());

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
                  height: context.height / 1.7,
                  width: context.width / 1.075,
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
                        children: controller.dragItems.map((item) {
                          return item.isTaskObjectiveComplted
                              ? Container(
                                  margin:
                                      EdgeInsets.all(context.height * 0.015),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  width: context.width / 5,
                                  height: context.height / 6,
                                )
                              : Draggable(
                                  data: item,
                                  onDraggableCanceled: (velocity, offset) {},
                                  feedback: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          opacity: 0.75,
                                          image: AssetImage(item.path)),
                                    ),
                                    width: context.width / 5,
                                    height: context.height / 8,
                                  ),
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(context.height * 0.015),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      image: DecorationImage(
                                          scale: 2,
                                          image: AssetImage(item.path)),
                                    ),
                                    width: context.width / 5,
                                    height: context.height / 6,
                                  ),
                                );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(
                  left: context.width * 0.0325, bottom: context.width * 0.0325),
              child: Row(
                children: [
                  DragTarget(
                    onWillAcceptWithDetails: (details) {
                      final data = details.data as DraggableItemModel;
                      if (data.value) {
                        return true;
                      } else {
                        showDialogueForWrongAttempt();
                        return false;
                      }
                    },
                    onAcceptWithDetails: (data) {
                      controller.addToEmptyOrFullList(
                          item: data.data as DraggableItemModel);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: primaryBlue.withOpacity(0.35),
                        ),
                        width: context.width / 2.25,
                        height: context.height / 4,
                        child: Stack(
                          children: [
                            const Center(child: Text('FULL')),
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.height * 0.02),
                              itemCount: controller.fullAcceptedList.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 0,
                                      // mainAxisExtent: 0,
                                      maxCrossAxisExtent: context.width / 4,
                                      childAspectRatio: 1),
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.all(context.height * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          (controller.fullAcceptedList[index])
                                              .path)),
                                ),
                                width: context.width / 15,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(width: context.width * 0.05),
                  DragTarget(
                    onWillAcceptWithDetails: (details) {
                      final data = details.data as DraggableItemModel;
                      if (!data.value) {
                        return true;
                      } else {
                        showDialogueForWrongAttempt();
                        return false;
                      }
                    },
                    onAcceptWithDetails: (data) {
                      controller.addToEmptyOrFullList(
                          item: data.data as DraggableItemModel);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: primaryBlue.withOpacity(0.35),
                        ),
                        width: context.width / 2.25,
                        height: context.height / 4,
                        child: Stack(
                          children: [
                            const Center(child: Text('EMPTY')),
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.height * 0.02),
                              itemCount: controller.emptyAcceptedList.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 0,
                                      // mainAxisExtent: 0,
                                      maxCrossAxisExtent: context.width / 4,
                                      childAspectRatio: 1),
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.all(context.height * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          (controller.emptyAcceptedList[index])
                                              .path)),
                                ),
                                width: context.width / 15,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
