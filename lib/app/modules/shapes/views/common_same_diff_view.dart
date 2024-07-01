import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/shapes/controllers/shapes_controller.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_coloring_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class CommonSameDiffView extends StatefulWidget {
  const CommonSameDiffView({super.key});

  @override
  State<CommonSameDiffView> createState() => _CommonSameDiffViewState();
}

class _CommonSameDiffViewState extends State<CommonSameDiffView> {
  @override
  void initState() {
    showDialogueForInstructions(
        instruction:
            "Drag items from column A to column B to match them. Match all the items to complete the task.",
        path: 'assets/musics/sm_ac_2.mp3');
    super.initState();
  }

  DateTime? lastPressedTime;
  final ShapesController _controller = Get.put(ShapesController());

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
        Get.delete<ShapesController>();
        Get.to(() => ShapesView());
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
            Positioned(
              top: context.height * 0.1,
              left: context.width * 0.125,
              child: Row(
                children: [
                  const Text(
                    "A",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: context.width * 0.68,
                  ),
                  const Text(
                    'B',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Obx(
              () => Positioned(
                top: context.height * 0.2,
                left: context.width * 0.025,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        _controller.dragDropForCommon[0]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child: Image.asset('assets/images/sp_door.png'))
                            : Draggable(
                                data: ShapeType.rectangle,
                                feedback: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_door.png')),
                                child: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_door.png'))),
                        _controller.dragDropForCommon[0]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child:
                                    Image.asset('assets/images/green_tick.png'))
                            : const SizedBox()
                      ],
                    ),
                    SizedBox(height: context.height * 0.05),
                    Stack(
                      children: [
                        _controller.dragDropForCommon[1]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child: Image.asset('assets/images/sp_note.png'))
                            : Draggable(
                                data: ShapeType.square,
                                feedback: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_note.png')),
                                child: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_note.png'))),
                        _controller.dragDropForCommon[1]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child:
                                    Image.asset('assets/images/green_tick.png'))
                            : const SizedBox()
                      ],
                    ),
                    SizedBox(height: context.height * 0.05),
                    Stack(
                      children: [
                        _controller.dragDropForCommon[2]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child:
                                    Image.asset('assets/images/sp_pizza.png'))
                            : Draggable(
                                data: ShapeType.circle,
                                feedback: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_pizza.png')),
                                child: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_pizza.png'))),
                        _controller.dragDropForCommon[2]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child:
                                    Image.asset('assets/images/green_tick.png'))
                            : const SizedBox()
                      ],
                    ),
                    SizedBox(height: context.height * 0.05),
                    Stack(
                      children: [
                        _controller.dragDropForCommon[3]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child: Image.asset(
                                    'assets/images/sp_road_sign.png'))
                            : Draggable(
                                data: ShapeType.triangle,
                                feedback: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_road_sign.png')),
                                child: SizedBox(
                                    width: context.width * 0.2,
                                    child: Image.asset(
                                        'assets/images/sp_road_sign.png'))),
                        _controller.dragDropForCommon[3]
                            ? SizedBox(
                                width: context.width * 0.2,
                                child:
                                    Image.asset('assets/images/green_tick.png'))
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: context.height * 0.2,
              left: context.width * 0.725,
              child: Column(
                children: [
                  DragTarget(
                    onWillAcceptWithDetails: (details) {
                      if (details.data == ShapeType.square) {
                        return true;
                      } else {
                        showDialogueForWrongAttempt();
                        return false;
                      }
                    },
                    onAcceptWithDetails: (details) {
                      _controller.updateDragAndDropForCommon(index: 1);
                    },
                    builder: (context, candidateData, rejectedData) =>
                        Container(
                      width: context.width * 0.19,
                      height: context.height * 0.09,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: context.width * 0.005)),
                    ),
                  ),
                  SizedBox(height: context.height * 0.075),
                  DragTarget(
                    onWillAcceptWithDetails: (details) {
                      if (details.data == ShapeType.triangle) {
                        return true;
                      } else {
                        showDialogueForWrongAttempt();
                        return false;
                      }
                    },
                    onAcceptWithDetails: (details) {
                      _controller.updateDragAndDropForCommon(index: 3);
                    },
                    builder: (context, candidateData, rejectedData) =>
                        const ShapeWidget2(
                            shape: ShapeType.triangle, color: Colors.white),
                  ),
                  SizedBox(height: context.height * 0.05),
                  DragTarget(
                    onWillAcceptWithDetails: (details) {
                      if (details.data == ShapeType.rectangle) {
                        return true;
                      } else {
                        showDialogueForWrongAttempt();
                        return false;
                      }
                    },
                    onAcceptWithDetails: (details) {
                      _controller.updateDragAndDropForCommon(index: 0);
                    },
                    builder: (context, candidateData, rejectedData) =>
                        const ShapeWidget2(
                            shape: ShapeType.rectangle, color: Colors.white),
                  ),
                  SizedBox(height: context.height * 0.05),
                  DragTarget(
                    onWillAcceptWithDetails: (details) {
                      if (details.data == ShapeType.circle) {
                        return true;
                      } else {
                        showDialogueForWrongAttempt();
                        return false;
                      }
                    },
                    onAcceptWithDetails: (details) {
                      _controller.updateDragAndDropForCommon(index: 2);
                    },
                    builder: (context, candidateData, rejectedData) =>
                        const ShapeWidget2(
                            shape: ShapeType.circle, color: Colors.white),
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
