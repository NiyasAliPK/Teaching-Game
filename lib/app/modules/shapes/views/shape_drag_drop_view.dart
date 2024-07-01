import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/shapes/bindings/shapes_binding.dart';
import 'package:teaching_game/app/modules/shapes/controllers/shapes_controller.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class ShapeDragDropView extends StatefulWidget {
  final ShapeType currentShape;
  const ShapeDragDropView({super.key, required this.currentShape});

  @override
  State<ShapeDragDropView> createState() => _ShapeDragDropViewState();
}

class _ShapeDragDropViewState extends State<ShapeDragDropView> {
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
          Get.delete<ShapesController>();
          Get.to(() => ShapesView());
          return true;
        },
        child: Scaffold(
            body: Stack(fit: StackFit.expand, children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.topCenter,
                colors: [Color(0xFFAEEEEE), Color(0xFF20B2AA)],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.height * 0.075),
            child: Column(
              children: [
                Container(
                    height: context.height / 1.7,
                    width: context.width - 20,
                    decoration: BoxDecoration(
                        color: primaryRed.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: GetBuilder<ShapesController>(builder: (controller) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        spacing: context.width * 0.03,
                        runSpacing: context.height * 0.01,
                        children: _controller.dragItems.map((item) {
                          return item.isObjectiveCompleted
                              ? Container(
                                  margin:
                                      EdgeInsets.all(context.height * 0.015),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  width: context.width / 5,
                                  height: context.height / 10,
                                )
                              : Draggable(
                                  data: item,
                                  onDraggableCanceled: (velocity, offset) {},
                                  feedback: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          opacity: 0.75,
                                          image: AssetImage(item.path)),
                                    ),
                                    width: context.width / 5,
                                    height: context.height / 10,
                                  ),
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(context.height * 0.015),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      image: DecorationImage(
                                          scale: 2,
                                          image: AssetImage(item.path)),
                                    ),
                                    width: context.width / 5,
                                    height: context.height / 10,
                                  ),
                                );
                        }).toList(),
                      );
                    }))
              ],
            ),
          ),
          Positioned(
            bottom: context.height * 0.05,
            child: Row(
              children: [
                DragTarget(
                  onWillAcceptWithDetails: (details) {
                    final data = details.data as ShapeModel;
                    if (data.shape == widget.currentShape) {
                      return true;
                    } else {
                      showDialogueForWrongAttempt();
                      return false;
                    }
                  },
                  onAcceptWithDetails: (data) {
                    _controller.updateAcceptedList(
                        item: data.data as ShapeModel,
                        currentShape: widget.currentShape);
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      margin: EdgeInsets.only(left: context.width * 0.0225),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: primaryRed.withOpacity(0.5),
                      ),
                      width: context.width - 20,
                      height: context.height / 4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.height / 6,
                            child: Center(
                                child: Text(
                                    'DRAG AND DROP ALL THE ${widget.currentShape.toString().replaceAll('ShapeType.', '').toUpperCase()} SHAPED OBJECTS HERE')),
                          ),
                          Expanded(
                              child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _controller.accepetedLsit.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.all(context.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        (_controller.accepetedLsit[index])
                                            .path)),
                              ),
                              width: context.width / 5,
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
        ])));
  }
}
