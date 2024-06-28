import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/modules/BigOrSmall/controllers/big_or_small_controller.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class FishBowlView extends StatefulWidget {
  const FishBowlView({super.key});

  @override
  State<FishBowlView> createState() => _FishBowlViewState();
}

class _FishBowlViewState extends State<FishBowlView> {
  final BigOrSmallController _controller = Get.put(BigOrSmallController());

  DateTime? lastPressedTime;

  @override
  void initState() {
    showDialogueForInstructions(
        instruction:
            "Drag and drop all the small fishes into the fish tank to complete the task.",
        path: 'assets/musics/bg_ac_3.mp3');
    _controller.fishes.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: Stack(
        fit: StackFit.expand,
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
                  left: context.width * 0.05, top: context.height * 0.05),
              child: GetBuilder<BigOrSmallController>(
                builder: (controller) => Wrap(
                  spacing: context.width * 0.1,
                  children: _controller.fishes.map((item) {
                    return item.isTaskObjectiveComplted
                        ? Container(
                            margin: EdgeInsets.all(context.height * 0.0115),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            width: item.value
                                ? context.width / 5
                                : context.width / 8,
                            height: context.height / 12,
                          )
                        : Draggable(
                            // value true means the fish is in tank already
                            data: item,

                            feedback: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                color: Colors.transparent,
                                image: DecorationImage(
                                    opacity: 0.5, image: AssetImage(item.path)),
                              ),
                              width: item.value
                                  ? context.width / 5
                                  : context.width / 8,
                              height: context.height / 12,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(context.height * 0.0115),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                image: DecorationImage(
                                    image: AssetImage(item.path)),
                              ),
                              width: item.value
                                  ? context.width / 5
                                  : context.width / 8,
                              height: context.height / 12,
                            ),
                          );
                  }).toList(),
                ),
              )),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: context.width * 0.0325),
              child: DragTarget(
                onAcceptWithDetails: (data) {
                  _controller.updateFishInTank(
                      item: data.data as DraggableItemModel);
                },
                builder: (context, candidateData, rejectedData) {
                  return SizedBox(
                    width: context.width,
                    height: context.height / 3,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: context.width * 0.05),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                // fit: BoxFit.cover,
                                image: AssetImage(
                              'assets/images/fish_tank.png',
                            )),
                            borderRadius: BorderRadius.circular(25),
                            // color: Colors.white.withOpacity(0.35),
                          ),
                          width: context.width,
                          height: context.height / 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: context.width * 0.07,
                              right: context.width * 0.06,
                              top: context.height * 0.06),
                          child: GridView.builder(
                            itemCount: _controller.acceptedListOfFish.length,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 1.75,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    maxCrossAxisExtent: context.width / 4),
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.all(context.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                image: DecorationImage(
                                    opacity: 0.75,
                                    image: AssetImage(
                                        (_controller.acceptedListOfFish[index])
                                            .path)),
                              ),
                              width: context.width / 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      )),
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
