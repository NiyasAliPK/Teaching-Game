import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/modules/shapes/controllers/shapes_controller.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class ShapesSelectionView extends StatefulWidget {
  final ShapeType currentShape;
  const ShapesSelectionView({super.key, required this.currentShape});

  @override
  State<ShapesSelectionView> createState() => _ShapesSelectionViewState();
}

class _ShapesSelectionViewState extends State<ShapesSelectionView> {
  final ShapesController _controller = Get.put(ShapesController());

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
        Get.offAll(() => ShapesView());
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
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: context.width * 0.03,
                  vertical: context.height * 0.075),
              padding: EdgeInsets.all(context.width * 0.03),
              height: context.height / 1.35,
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.25),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: GetBuilder<ShapesController>(
                builder: (_) => GridView.builder(
                  itemCount: _controller.itemsForSelection.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: context.height * 0.15,
                      crossAxisSpacing: context.width * 0.02,
                      maxCrossAxisExtent: context.width / 4),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          log("message");
                          if (_controller.itemsForSelection[index].shape ==
                              widget.currentShape) {
                            _controller.updateSelectedShape(
                                item: _controller.itemsForSelection[index]);
                            _controller.checkForCompletionOfSelection(
                                currentShape: widget.currentShape);
                          } else {
                            showDialogueForWrongAttempt();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  _controller.itemsForSelection[index].path),
                            ),
                          ),
                        ),
                      ),
                      _controller.itemsForSelection[index].isObjectiveCompleted
                          ? Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/green_tick.png'),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: context.height * 0.05,
                left: context.width * 0.175,
                child: Text(
                  "Select all the ${widget.currentShape.toString().replaceAll('ShapeType.', '')} items\nto complete the task.",
                  style: TextStyle(fontSize: context.width * 0.05),
                ))
          ],
        ),
      ),
    );
  }
}
