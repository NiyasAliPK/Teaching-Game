import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/modules/shapes/controllers/shapes_controller.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class ShapesColoringView extends StatefulWidget {
  // final ShapeType currentShape;

  const ShapesColoringView({
    super.key,
  });

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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShapeWidget2(shape: ShapeType.circle, color: Colors.red),
                    ShapeWidget2(
                        shape: ShapeType.rectangle, color: Colors.green),
                    ShapeWidget2(shape: ShapeType.triangle, color: Colors.blue)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.width * 0.05),
                  child: const Text(
                    "Color all the circles red, rectanges green, and triangles in blue.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(context.width * 0.025),
                    padding: EdgeInsets.all(context.width * 0.03),
                    width: context.width,
                    height: context.height / 1.7,
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
                                  child: ShapeWidget2(
                                    shape: item.shape,
                                    color: item.color,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(context.width * 0.01),
                                  child: DragTarget(
                                    onWillAcceptWithDetails: (details) {
                                      if (details.data == Colors.red &&
                                          item.shape == ShapeType.circle) {
                                        return true;
                                      } else if (details.data == Colors.green &&
                                          item.shape == ShapeType.rectangle) {
                                        return true;
                                      } else if (details.data == Colors.blue &&
                                          item.shape == ShapeType.triangle) {
                                        return true;
                                      } else {
                                        // showDialogueForWrongAttempt();
                                        return false;
                                      }
                                    },
                                    onAcceptWithDetails: (details) {
                                      _controller.updateColorOfCommon(
                                          item: item,
                                          color: details.data as Color);
                                    },
                                    builder: (context, candidateData,
                                            rejectedData) =>
                                        ShapeWidget2(
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

class ShapeWidget2 extends StatelessWidget {
  final ShapeType shape;
  final Color color;

  const ShapeWidget2({super.key, required this.shape, required this.color});

  @override
  Widget build(BuildContext context) {
    Size size;
    switch (shape) {
      case ShapeType.square:
        size = Size(context.width * 0.175, context.width * 0.0175);
        break;
      case ShapeType.rectangle:
        size = Size(context.width * 0.25, context.width * 0.175);
        break;
      default:
        size = Size(context.width * 0.2, context.width * 0.2);
    }

    return CustomPaint(
      size: size,
      painter: ShapePainter(shape: shape, color: color),
    );
  }
}

class ShapePainter extends CustomPainter {
  final ShapeType shape;
  final Color color;

  ShapePainter({required this.shape, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    switch (shape) {
      case ShapeType.triangle:
        _drawTriangle(canvas, size, fillPaint, borderPaint);
        break;
      case ShapeType.circle:
        _drawCircle(canvas, size, fillPaint, borderPaint);
        break;
      case ShapeType.square:
        _drawSquare(canvas, size, fillPaint, borderPaint);
        break;
      case ShapeType.rectangle:
        _drawRectangle(canvas, size, fillPaint, borderPaint);
        break;
    }
  }

  void _drawTriangle(
      Canvas canvas, Size size, Paint fillPaint, Paint borderPaint) {
    Path path = Path();
    path.moveTo(size.width / 2, 0); // Top center
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(0, size.height); // Bottom left
    path.close(); // Close the path to form a triangle

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  void _drawCircle(
      Canvas canvas, Size size, Paint fillPaint, Paint borderPaint) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;
    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, borderPaint);
  }

  void _drawSquare(
      Canvas canvas, Size size, Paint fillPaint, Paint borderPaint) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.width);
    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, borderPaint);
  }

  void _drawRectangle(
      Canvas canvas, Size size, Paint fillPaint, Paint borderPaint) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
