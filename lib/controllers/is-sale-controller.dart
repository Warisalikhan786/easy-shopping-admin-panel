// ignore_for_file: file_names

import 'package:get/get.dart';

class IsSaleController extends GetxController {
  RxBool isSale = false.obs;

  void toggleIsSale(bool value) {
    isSale.value = value;
    update();
  }

  void setIsSaleOldValue(bool value) {
    isSale.value = value;
    update();
  }
}
