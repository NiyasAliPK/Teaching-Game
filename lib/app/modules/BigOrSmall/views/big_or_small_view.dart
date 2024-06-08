import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/BigOrSmall/bindings/big_or_small_binding.dart';
import 'package:teaching_game/app/utils/utils.dart';
import '../controllers/big_or_small_controller.dart';

class BigOrSmallView extends StatefulWidget {
  const BigOrSmallView({super.key});

  @override
  State<BigOrSmallView> createState() => _BigOrSmallViewState();
}

class _BigOrSmallViewState extends State<BigOrSmallView> {
  final BigOrSmallController _controller = Get.put(BigOrSmallController());

  @override
  void initState() {
    showDialogueForInstructions(
        instruction:
            "Drag and drop small items near to the small kid and big items to the big kid.");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.only(top: context.height * 0.05),
          child: GetBuilder<BigOrSmallController>(
            builder: (controller) {
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: context.width * 0.03,
                runSpacing: context.height * 0.01,
                children: _controller.dragItems.map((item) {
                  return Draggable(
                    data: item,
                    onDraggableCanceled: (velocity, offset) {},
                    feedback: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Colors.transparent,
                        image: DecorationImage(
                            opacity: 0.5, image: AssetImage(item.path)),
                      ),
                      width: item.value ? context.width / 4 : context.width / 6,
                      height: context.height / 8,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(context.height * 0.015),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        // color: primaryBlue.withOpacity(0.5),
                        image: DecorationImage(
                            scale: 2, image: AssetImage(item.path)),
                      ),
                      width: item.value ? context.width / 4 : context.width / 6,
                      height:
                          item.value ? context.height / 6 : context.height / 12,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.only(
                left: context.width * 0.0325, bottom: context.width * 0.0325),
            child: Row(
              children: [
                DragTarget(
                  onWillAcceptWithDetails: (details) {
                    final data = details.data as DraggableItemModel;
                    if (data.value) {
                      return true;
                    } else {
                      showDialogueForWrongAttempt();
                      return false;
                    }
                  },
                  onAcceptWithDetails: (data) {
                    for (var element in _controller.bigAccpetedList) {
                      if (element.name ==
                          (data.data as DraggableItemModel).name) {
                        return;
                      }
                    }
                    _controller.bigAccpetedList
                        .add(data.data as DraggableItemModel);
                    _controller.checkForCompletionTaskOne();
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: primaryBlue.withOpacity(0.35),
                      ),
                      width: context.width / 2.25,
                      height: context.height / 4,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.red,
                            height: context.height / 6,
                            child: Image.asset(
                                'assets/images/big_small_girl_1.jpg'),
                          ),
                          Expanded(
                              child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _controller.bigAccpetedList.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.all(context.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        (_controller.bigAccpetedList[index])
                                            .path)),
                              ),
                              width: context.width / 15,
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(width: context.width * 0.05),
                DragTarget(
                  onWillAcceptWithDetails: (details) {
                    final data = details.data as DraggableItemModel;
                    if (!data.value) {
                      return true;
                    } else {
                      showDialogueForWrongAttempt();
                      return false;
                    }
                  },
                  onAcceptWithDetails: (data) {
                    for (var element in _controller.smallAccpetedList) {
                      if (element.name ==
                          (data.data as DraggableItemModel).name) {
                        return;
                      }
                    }
                    _controller.smallAccpetedList
                        .add(data.data as DraggableItemModel);
                    _controller.checkForCompletionTaskOne();
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: primaryBlue.withOpacity(0.35),
                      ),
                      width: context.width / 2.25,
                      height: context.height / 4,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.red,
                            height: context.height / 6,
                            child: Image.asset(
                                'assets/images/big_small_girl_1.jpg'),
                          ),
                          Expanded(
                              child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _controller.smallAccpetedList.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.all(context.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        (_controller.smallAccpetedList[index])
                                            .path)),
                              ),
                              width: context.width / 15,
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
        )
      ],
    ));
  }
}

//FIRST PAGE STACK//

// SafePadding(
//         isSafePadingOff: true,
//         child: Stack(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/images/green_field.jpg'),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 0,
//               left: -context.width * 0.111,
//               child: Container(
//                 width: context.width * 1.225,
//                 height: context.height / 2,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.fitWidth,
//                     image: AssetImage('assets/images/carnival.png'),
//                   ),
//                 ),
//               ),
//             ),
//             const Positioned(
//               bottom: 0,
//               child: BubbleSpecialThree(
//                 text: 'Added iMessage shape bubbles',
//                 color: primaryBlue,
//                 tail: true,
//                 isSender: false,
//                 textStyle: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
