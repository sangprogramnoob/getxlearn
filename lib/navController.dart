// ignore_for_file: file_names

import 'package:get/get.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(index) {
    selectedIndex.value = index;
  }
}
