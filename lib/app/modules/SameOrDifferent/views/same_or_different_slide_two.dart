import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/SameOrDifferent/controllers/same_or_different_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class SameOrDifferentSlideTwo extends StatefulWidget {
  const SameOrDifferentSlideTwo({super.key});

  @override
  State<SameOrDifferentSlideTwo> createState() =>
      _SameOrDifferentSlideTwoState();
}

class _SameOrDifferentSlideTwoState extends State<SameOrDifferentSlideTwo> {
  final _controller = SameOrDifferentController();

  @override
  void initState() {
    _controller.dragTargets.shuffle();
    _controller.draggables.shuffle();
    showDialogueForInstructions(
        instruction:
            "Drag items from column A to column B to match them. Match all the items to complete the task.");
    super.initState();
  }

  DateTime? lastPressedTime;

  @override
  Widget build(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    double contextHeight = MediaQuery.of(context).size.height;

    // Safety check to avoid Infinity or NaN issues
    if (contextWidth <= 0 || contextHeight <= 0) {
      return const Center(child: Text('Invalid context size'));
    }

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
            Container(
              height: contextHeight / 1.1,
              decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.25),
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              margin: EdgeInsets.symmetric(
                  horizontal: contextWidth * 0.04,
                  vertical: contextHeight * 0.075),
              child: ListView.separated(
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        _controller.draggables[index].isTaskObjectiveComplted
                            ? Container(
                                margin: EdgeInsets.all(contextHeight * 0.015),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  image: DecorationImage(
                                    scale: 2,
                                    image: AssetImage(
                                        _controller.draggables[index].path),
                                  ),
                                ),
                                width: contextWidth / 6,
                                height: contextHeight / 12,
                              )
                            : Draggable(
                                data: _controller.draggables[index],
                                onDraggableCanceled: (velocity, offset) {},
                                feedback: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      opacity: 0.75,
                                      image: AssetImage(
                                          _controller.draggables[index].path),
                                    ),
                                  ),
                                  width: contextWidth / 6,
                                  height: contextHeight / 12,
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(contextHeight * 0.015),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    image: DecorationImage(
                                      scale: 2,
                                      image: AssetImage(
                                          _controller.draggables[index].path),
                                    ),
                                  ),
                                  width: contextWidth / 6,
                                  height: contextHeight / 12,
                                ),
                              ),
                        _controller.draggables[index].isTaskObjectiveComplted
                            ? Positioned(
                                top: contextHeight * 0.05,
                                child: Image.asset(
                                  "assets/images/matched_text.png",
                                  width: contextHeight * 0.1,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    _controller.dragTargets[index].isTaskObjectiveComplted
                        ? Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(contextHeight * 0.015),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  image: DecorationImage(
                                    scale: 2,
                                    image: AssetImage(
                                        _controller.dragTargets[index].path),
                                  ),
                                ),
                                width: contextWidth / 6,
                                height: contextHeight / 12,
                              ),
                              _controller.dragTargets[index]
                                      .isTaskObjectiveComplted
                                  ? Positioned(
                                      top: contextHeight * 0.05,
                                      child: Image.asset(
                                        "assets/images/matched_text.png",
                                        width: contextHeight * 0.1,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        : DragTarget(
                            onWillAcceptWithDetails: (details) {
                              final data = details.data as DraggableItemModel;
                              if (data.name ==
                                  _controller.dragTargets[index].name) {
                                return true;
                              } else {
                                showDialogueForWrongAttempt();
                                return false;
                              }
                            },
                            onAcceptWithDetails: (data) {
                              _controller.updateMatched(
                                  item: data.data as DraggableItemModel);
                              setState(() {});
                              _controller.checkForCompletionTaskTwo();
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                margin: EdgeInsets.all(contextHeight * 0.015),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  image: DecorationImage(
                                    scale: 2,
                                    image: AssetImage(
                                        _controller.dragTargets[index].path),
                                  ),
                                ),
                                width: contextWidth / 6,
                                height: contextHeight / 12,
                              );
                            },
                          ),
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: contextHeight * 0.02,
                ),
                itemCount: _controller.draggables.length,
              ),
            ),
            Positioned(
              top: context.height * 0.1,
              left: context.width * 0.125,
              child: Row(
                children: [
                  const Text(
                    "A",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: context.width * 0.68,
                  ),
                  const Text(
                    'B',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
