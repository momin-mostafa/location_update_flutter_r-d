import 'package:get/get.dart';

class Controller extends GetxController {
  RxInt counter = 0.obs;

  updateCounter() {
    counter.value++;
    update();
  }
}
