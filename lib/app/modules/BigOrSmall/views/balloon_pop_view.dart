import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teaching_game/app/modules/BigOrSmall/controllers/big_or_small_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';

class BalloonPoperView extends StatelessWidget {
  final BigOrSmallController _controller = Get.put(BigOrSmallController());
  BalloonPoperView({super.key});

  DateTime? lastPressedTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: [Color(0xFFAEEEEE), Color(0xFF20B2AA)],
            ))),
            GetBuilder<BigOrSmallController>(
              builder: (controller) => GridView.builder(
                itemCount: _controller.balloonsToPop.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: context.width / 3),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: _controller.balloonsToPop[index].value
                      ? null
                      : () {
                          _controller.popTheBalloon(position: index);
                        },
                  child: SizedBox(
                    width: context.width / 4,
                    height: context.height / 8,
                    child: _controller.balloonsToPop[index].value
                        ? Lottie.asset('assets/animations/pop.json',
                            repeat: false)
                        : Image.asset(_controller.balloonsToPop[index].path),
                  ),
                ),
              ),
            ),
            Positioned(
              left: context.width * 0.045,
              bottom: context.height / 8,
              child: SizedBox(
                width: context.width,
                child: Text(
                    style: TextStyle(
                        fontSize: context.width * 0.05, color: Colors.red),
                    // overflow: TextOverflow.ellipsis,
                    "Click on the balloon to pop it, Pop all the balloons to complete this round."),
              ),
            )
          ],
        ),
      ),
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
    );
  }
}
