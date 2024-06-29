import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    gotoHome();
    super.onInit();
  }

  gotoHome() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
      builder: (context) => HomeView(),
    ));
  }
}
