import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/shapes/controllers/shapes_controller.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class RectangleColoringView extends StatefulWidget {
  const RectangleColoringView({super.key});

  @override
  State<RectangleColoringView> createState() => _RectangleColoringViewState();
}

class _RectangleColoringViewState extends State<RectangleColoringView> {
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
                                child: Icon(
                                  Icons.brush,
                                  size: context.width * 0.1,
                                  color: Colors.white,
                                )),
                            child: Container(
                              height: context.height * 0.07,
                              width: context.width * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _controller.colors[index]),
                              child: Icon(
                                Icons.brush,
                                size: context.width * 0.1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: context.width * 0.085,
                        ),
                    itemCount: _controller.colors.length),
              ),
            ),
            Positioned(
              top: context.height * 0.25,
              left: context.width * 0.05,
              child: Text(
                "Colour the Rectangles by dragging and\ndroping the colours from top.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.width * 0.045),
              ),
            ),
            Positioned(
              bottom: context.height * 0.025,
              child: Container(
                width: context.width,
                // margin: EdgeInsets.symmetric(horizontal: context.width * 0.04),
                padding: EdgeInsets.only(
                    top: context.height * 0.03,
                    bottom: context.height * 0.03,
                    left: context.width * 0.03),
                height: context.height / 1.6,
                decoration: BoxDecoration(
                  color: primaryRed.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: GetBuilder<ShapesController>(builder: (_) {
                  return Stack(
                    children: [
                      Positioned(
                        //BODY
                        top: context.height * .15,
                        left: context.width * 0.25,
                        child: getShape(
                            index: 0,
                            color: _controller.colorListForSquares[0],
                            size: Size(
                                context.width / 2.25, context.height / 3.75)),
                      ),
                      Positioned(
                        //HEAD
                        // top: context.height * 0.00,
                        left: context.width * 0.35,
                        child: getShape(
                            index: 1,
                            color: _controller.colorListForSquares[1],
                            size:
                                Size(context.width / 4, context.height / 6.6)),
                      ),
                      Positioned(
                        //left hand
                        top: context.height * .175,
                        left: context.width * 0.0,
                        child: getShape(
                            index: 2,
                            color: _controller.colorListForSquares[2],
                            size: Size(context.width / 4, context.height / 10)),
                      ),
                      Positioned(
                        //right hand
                        top: context.height * .175,
                        left: context.width * 0.6925,
                        child: getShape(
                            index: 3,
                            color: _controller.colorListForSquares[3],
                            size: Size(context.width / 4, context.height / 10)),
                      ),
                      Positioned(
                        //left leg
                        top: context.height * 0.417,
                        left: context.width * 0.25,
                        child: getShape(
                            index: 4,
                            color: _controller.colorListForSquares[4],
                            size: Size(context.width / 5, context.height / 8)),
                      ),
                      Positioned(
                        top: context.height * 0.417,
                        left: context.width * 0.495,
                        child: getShape(
                            index: 5,
                            color: _controller.colorListForSquares[5],
                            size: Size(context.width / 5, context.height / 8)),
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
    return _controller.colorListForSquares[index] == Colors.white
        ? DragTarget(
            onAcceptWithDetails: (details) {
              _controller.changeSquareColor(
                  index: index, color: details.data as Color);
            },
            builder: (context, candidateData, rejectedData) => ShapeWidget(
                shape: ShapeType.rectangle, color: color, size: size))
        : ShapeWidget(shape: ShapeType.rectangle, color: color, size: size);
  }
}
