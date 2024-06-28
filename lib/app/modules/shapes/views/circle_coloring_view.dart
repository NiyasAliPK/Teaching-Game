import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/shapes/controllers/shapes_controller.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class CircleColoringView extends StatefulWidget {
  const CircleColoringView({super.key});

  @override
  State<CircleColoringView> createState() => _CircleColoringViewState();
}

class _CircleColoringViewState extends State<CircleColoringView> {
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.075),
              child: Container(
                margin: EdgeInsets.all(context.width * 0.03),
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.03),
                height: context.height / 7,
                decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.25),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
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
            ),
            Positioned(
              top: context.height * 0.3,
              left: context.width * 0.05,
              child: const Text(
                "Color the shape by dragging and droping\nthe colors from top.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Positioned(
              bottom: context.height * 0.05,
              child: Container(
                width: context.width,
                padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.03,
                    horizontal: context.width * 0.03),
                height: context.height / 2,
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.25),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: GetBuilder<ShapesController>(builder: (_) {
                  return Stack(
                    children: [
                      Positioned(
                        top: context.height * 0.20,
                        child: getShape(
                            index: 5,
                            color: _controller.colorListForCircle[5],
                            size: Size(context.width / 6, context.height / 10)),
                      ),
                      Positioned(
                        top: context.height * 0.20,
                        left: context.width * 0.13,
                        child: getShape(
                            index: 0,
                            color: _controller.colorListForCircle[0],
                            size: Size(context.width / 6, context.height / 10)),
                      ),
                      Positioned(
                        top: context.height * 0.195,
                        left: context.width * 0.275,
                        child: getShape(
                            index: 4,
                            color: _controller.colorListForCircle[4],
                            size: Size(context.width / 6, context.height / 10)),
                      ),
                      Positioned(
                        top: context.height * .19,
                        left: context.width * 0.425,
                        child: getShape(
                            index: 2,
                            color: _controller.colorListForCircle[2],
                            size: Size(context.width / 6, context.height / 10)),
                      ),
                      Positioned(
                        top: context.height * .17,
                        left: context.width * 0.57,
                        child: getShape(
                            index: 3,
                            color: _controller.colorListForCircle[3],
                            size: Size(context.width / 6, context.height / 10)),
                      ),
                      Positioned(
                        left: context.width * 0.67,
                        top: context.height * 0.1,
                        child: getShape(
                            index: 1,
                            color: _controller.colorListForCircle[1],
                            size: Size(context.width / 4, context.height / 8)),
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getShape(
      {required Color color, required Size size, required int index}) {
    return color == Colors.white
        ? DragTarget(
            onAcceptWithDetails: (details) {
              _controller.changeCircleColor(
                  index: index, color: details.data as Color);
            },
            builder: (context, candidateData, rejectedData) =>
                ShapeWidget(shape: ShapeType.circle, color: color, size: size))
        : ShapeWidget(shape: ShapeType.circle, color: color, size: size);
  }
}
