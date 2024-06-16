import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teaching_game/app/modules/BigOrSmall/controllers/big_or_small_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

// ignore: must_be_immutable
class BalloonPoperView extends StatefulWidget {
  const BalloonPoperView({super.key});

  @override
  State<BalloonPoperView> createState() => _BalloonPoperViewState();
}

class _BalloonPoperViewState extends State<BalloonPoperView> {
  final BigOrSmallController _controller = Get.put(BigOrSmallController());

  DateTime? lastPressedTime;

  @override
  void initState() {
    _controller.balloonsToPop.shuffle();
    showDialogueForInstructions(
        instruction:
            "Click on each big balloons to pop them, Pop all the big ones to complete the task.");
    super.initState();
  }

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
            Padding(
              padding: EdgeInsets.only(
                  top: context.width * 0.25, left: context.width * 0.045),
              child: GetBuilder<BigOrSmallController>(
                builder: (controller) => Wrap(
                  alignment: WrapAlignment.center,
                  spacing: context.width * 0.03,
                  children: _controller.balloonsToPop
                      .map(
                        (item) => GestureDetector(
                          onTap: item.isTaskObjectiveComplted
                              ? null
                              : () {
                                  _controller.popTheBalloon(value: item);
                                },
                          child: SizedBox(
                            width: item.value
                                ? context.width / 5
                                : context.width / 3,
                            height: item.value
                                ? context.height / 9
                                : context.height / 7,
                            child: item.isTaskObjectiveComplted
                                ? Lottie.asset('assets/animations/pop.json',
                                    repeat: false)
                                : Image.asset(item.path),
                          ),
                        ),
                      )
                      .toList(),
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
                    "Click on the big balloons to pop them,\nPop all of them to complete."),
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
