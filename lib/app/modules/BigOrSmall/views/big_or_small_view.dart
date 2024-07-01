import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';
import '../controllers/big_or_small_controller.dart';

class BigOrSmallView extends StatefulWidget {
  const BigOrSmallView({super.key});

  @override
  State<BigOrSmallView> createState() => _BigOrSmallViewState();
}

class _BigOrSmallViewState extends State<BigOrSmallView> {
  final BigOrSmallController _controller = Get.put(BigOrSmallController());

  @override
  void initState() {
    showDialogueForInstructions(
        instruction:
            "Drag and drop small items to the left box and big items to the right box.",
        path: 'assets/musics/bg_ac_1.mp3');
    super.initState();
  }

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
                  decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.25),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: GetBuilder<BigOrSmallController>(
                    builder: (controller) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        spacing: context.width * 0.03,
                        runSpacing: context.height * 0.01,
                        children: _controller.dragItems.map((item) {
                          return item.isTaskObjectiveComplted
                              ? Container(
                                  margin:
                                      EdgeInsets.all(context.height * 0.015),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  width: item.value
                                      ? context.width / 4
                                      : context.width / 6,
                                  height: item.value
                                      ? context.height / 6
                                      : context.height / 12,
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
                                    width: item.value
                                        ? context.width / 4
                                        : context.width / 6,
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
                                    width: item.value
                                        ? context.width / 4
                                        : context.width / 6,
                                    height: item.value
                                        ? context.height / 6
                                        : context.height / 12,
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
                      if (!data.value) {
                        return true;
                      } else {
                        showDialogueForWrongAttempt();
                        return false;
                      }
                    },
                    onAcceptWithDetails: (data) {
                      _controller.addToBigOrSmallList(
                          item: data.data as DraggableItemModel);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: primaryGreen.withOpacity(0.5),
                        ),
                        width: context.width / 2.25,
                        height: context.height / 4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.height / 6,
                              child: const Center(child: Text('SMALL')),
                            ),
                            Expanded(
                                child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _controller.smallAccpetedList.length,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.all(context.height * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          (_controller.smallAccpetedList[index])
                                              .path)),
                                ),
                                width: context.width / 15,
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(width: context.width * 0.05),
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
                      _controller.addToBigOrSmallList(
                          item: data.data as DraggableItemModel);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: primaryPink.withOpacity(0.5),
                        ),
                        width: context.width / 2.25,
                        height: context.height / 4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.height / 6,
                              child: const Center(child: Text('BIG')),
                            ),
                            Expanded(
                                child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _controller.bigAccpetedList.length,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.all(context.height * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          (_controller.bigAccpetedList[index])
                                              .path)),
                                ),
                                width: context.width / 15,
                              ),
                            ))
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
