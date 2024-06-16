import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/controllers/big_or_small_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class SelectSmallAndBig extends StatefulWidget {
  const SelectSmallAndBig({super.key});

  @override
  State<SelectSmallAndBig> createState() => _SelectSmallAndBigState();
}

class _SelectSmallAndBigState extends State<SelectSmallAndBig> {
  final BigOrSmallController _controller = Get.put(BigOrSmallController());

  @override
  void initState() {
    _controller.listForBigsAndSmalls.shuffle(Random());
    showDialogueForInstructions(
        instruction:
            "Click on each item and select yellow star if the item is big and green tick if the item is small. Do this for all items to complete the task.");

    super.initState();
  }

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
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: context.height * 0.06, left: context.width * 0.65),
              padding: EdgeInsets.only(
                  left: context.width * 0.05, top: context.height * 0.01),
              height: context.height / 12,
              width: context.width / 3.15,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text("BIG"),
                      SizedBox(width: context.width * 0.05),
                      Image.asset(
                        'assets/images/yellow_star.png',
                        width: context.width * 0.07,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text("SMALL"),
                      SizedBox(width: context.width * 0.05),
                      Image.asset(
                        'assets/images/green_tick.png',
                        width: context.width * 0.07,
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: context.width * 0.275),
                child: GetBuilder<BigOrSmallController>(
                  builder: (controller) => Wrap(
                    spacing: context.width * 0.05,
                    alignment: WrapAlignment.center,
                    children: _controller.listForBigsAndSmalls.map((item) {
                      return Stack(
                        children: [
                          PopupMenuButton(
                            enabled:
                                item.isTaskObjectiveComplted ? false : true,
                            onSelected: (value) {
                              _controller.selectBigOrSmall(
                                  item: item, selectedValue: value);
                            },
                            color: Colors.transparent,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: true,
                                  padding: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/yellow_star.png',
                                      height: context.height * 0.075,
                                      width: context.width * 0.075,
                                    ),
                                  )),
                              const PopupMenuItem(
                                  height: 0.1,
                                  padding: EdgeInsets.all(0),
                                  enabled: false,
                                  onTap: null,
                                  child: PopupMenuDivider()),
                              PopupMenuItem(
                                  value: false,
                                  padding: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/green_tick.png',
                                      height: context.height * 0.075,
                                      width: context.width * 0.075,
                                    ),
                                  )),
                            ],
                            child: Container(
                              margin: EdgeInsets.all(context.height * 0.015),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                image: DecorationImage(
                                    scale: 2, image: AssetImage(item.path)),
                              ),
                              width: item.value
                                  ? context.width / 4
                                  : context.width / 6,
                              height: item.value
                                  ? context.height / 7.25
                                  : context.height / 14,
                            ),
                          ),
                          Positioned(
                            left: context.width * 0.07,
                            top: context.height * 0.04,
                            child: item.isTaskObjectiveComplted && item.value
                                ? Image.asset(
                                    'assets/images/yellow_star.png',
                                    height: context.height * 0.1,
                                    width: context.width * 0.1,
                                  )
                                : item.isTaskObjectiveComplted &&
                                        item.value == false
                                    ? Image.asset(
                                        'assets/images/green_tick.png',
                                        height: context.height * 0.1,
                                        width: context.width * 0.1,
                                      )
                                    : const SizedBox.shrink(),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ))
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
