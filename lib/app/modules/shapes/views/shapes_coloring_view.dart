import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/modules/shapes/controllers/shapes_controller.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class ShapesColoringView extends StatefulWidget {
  final ShapeType currentShape;

  const ShapesColoringView({super.key, required this.currentShape});

  @override
  State<ShapesColoringView> createState() => _ShapesColoringViewState();
}

class _ShapesColoringViewState extends State<ShapesColoringView> {
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
            message: "Click again to go back",
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
            Column(
              children: [
                SizedBox(height: context.height * 0.05),
                Container(
                  margin: EdgeInsets.all(context.width * 0.03),
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.03),
                  height: context.height / 7,
                  decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.25),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Transform.scale(
                            scaleY: 0.5,
                            child: Draggable(
                              data: _controller.colors[index],
                              feedback: Container(
                                height: context.height * 0.07,
                                width: context.width * 0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: _controller.colors[index]),
                              ),
                              child: Container(
                                height: context.height * 0.07,
                                width: context.width * 0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: _controller.colors[index]),
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            width: context.width * 0.1,
                          ),
                      itemCount: _controller.colors.length),
                ),
                Container(
                    margin: EdgeInsets.all(context.width * 0.03),
                    padding: EdgeInsets.all(context.width * 0.03),
                    height: context.height / 1.35,
                    decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.25),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: GetBuilder<ShapesController>(builder: (controller) {
                      return Wrap(
                          children: _controller.shapes.map(
                        (item) {
                          return item.color != Colors.white
                              ? Padding(
                                  padding: EdgeInsets.all(context.width * 0.01),
                                  child: ShapeWidget(
                                    shape: item.shape,
                                    color: item.color,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(context.width * 0.01),
                                  child: DragTarget(
                                    onWillAcceptWithDetails: (details) {
                                      if (item.shape == widget.currentShape) {
                                        log("message>>>>${item.id}>>>>${item.shape == widget.currentShape}");

                                        return true;
                                      } else {
                                        log("FALSE");
                                        return false;
                                      }
                                    },
                                    onAcceptWithDetails: (details) {
                                      log("on accept called");
                                      _controller.updateTheColor(
                                          item: item,
                                          color: details.data as Color);
                                      _controller.checkForCompletionOfcoloring(
                                          currentShape: widget.currentShape);
                                    },
                                    builder: (context, candidateData,
                                            rejectedData) =>
                                        ShapeWidget(
                                      shape: item.shape,
                                      color: item.color,
                                    ),
                                  ),
                                );
                        },
                      ).toList());
                    }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
