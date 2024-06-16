import 'package:get/get.dart';
import 'package:teaching_game/app/modules/home/views/home_view.dart';
import 'package:teaching_game/app/utils/utils.dart';

class FarNearController extends GetxController {
  List<bool> taskProgress = [false, false, false, false];

  udpateProgress({required index}) {
    taskProgress[index] = true;
    update();
    if (checkForCompletion()) {
      showDialogueForCompletion(callback: () {
        Get.offAll(() => HomeView());
      });
    }
  }

  bool checkForCompletion() {
    int count = 0;
    for (var element in taskProgress) {
      if (element) {
        count++;
      }
    }
    if (count == 4) {
      return true;
    } else {
      return false;
    }
  }
}
