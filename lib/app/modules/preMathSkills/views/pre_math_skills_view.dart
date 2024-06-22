import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/utils/utils.dart';

import '../controllers/pre_math_skills_controller.dart';

class PreMathSkillsView extends StatefulWidget {
  const PreMathSkillsView({super.key});

  @override
  State<PreMathSkillsView> createState() => _PreMathSkillsViewState();
}

class _PreMathSkillsViewState extends State<PreMathSkillsView> {
  @override
  void initState() {
    _controller.getProgress();
    super.initState();
  }

  final PreMathSkillsController _controller =
      Get.put(PreMathSkillsController());

  @override
  Widget build(BuildContext context) {
    return SafePadding(
        child: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    // if (index == 0) {
                    //   _controller.navigateToModules(index: index);
                    // } else if (_controller.items[index - 1].progress == 1) {
                    //   _controller.navigateToModules(index: index);
                    // } else {
                    //   Get.showSnackbar(const GetSnackBar(
                    //     message:
                    //         "Please complete the previous level to play this one",
                    //     duration: Duration(seconds: 3),
                    //   ));
                    // }
                    _controller.navigateToModules(index: index);
                  },
                  child: Container(
                    height: context.height / 5,
                    width: context.width / 2,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(width: 2, color: Colors.white30)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            _controller.items[index].name,
                            style: TextStyle(
                                fontSize: context.width * 0.075,
                                color: primaryBlue.withOpacity(0.75),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        index == 0
                            ? const SizedBox()
                            : _controller.items[index - 1].progress == 1
                                ? const SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top: context.height * 0.025,
                                        left: context.width * 0.75),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.grey[600],
                                    ))
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: context.height * 0.05,
                ),
            itemCount: _controller.items.length));
  }
}
