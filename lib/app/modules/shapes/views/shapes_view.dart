import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/controllers/home_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/modules/introVideo/views/intro_video_view.dart';
import 'package:teaching_game/app/modules/shapes/views/shapes_coloring_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

import '../controllers/shapes_controller.dart';

class ShapesView extends GetView<ShapesController> {
  final ShapesController _controller = Get.put(ShapesController());
  DateTime? lastPressedTime;
  ShapesView({super.key});

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
            GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.05,
                  vertical: context.height * 0.2),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: context.width / 2,
                  crossAxisSpacing: context.width * 0.025,
                  mainAxisSpacing: context.height * 0.0125),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  if (index == 4) {
                    Get.to(() => ShapesColoringView());
                    return;
                  }
                  var home = Get.find<HomeController>();
                  if (!home.isMusicPaused.value) {
                    home.pauseOrResumeMusic();
                  }
                  Get.to(() => IntroVideoView(
                      isFromShapes: true,
                      index: index,
                      path: _controller.getPathForVideo(index: index)));
                },
                child: Container(
                  height: context.height / 5,
                  width: context.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: Colors.white.withOpacity(0.5),
                      border: Border.all(width: 2, color: Colors.white30)),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          _controller.items[index].name,
                          style: TextStyle(
                              fontSize: context.width * 0.06,
                              color: primaryGreen.withOpacity(0.75),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: _controller.items.length,
            )
          ],
        ),
      ),
    );
  }
}

enum ShapeType { triangle, circle, square, rectangle }

class ShapeWidget extends StatelessWidget {
  final ShapeType shape;
  final Color color;
  final Size size;

  const ShapeWidget({
    super.key,
    required this.shape,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
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
