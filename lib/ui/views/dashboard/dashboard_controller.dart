import 'package:get/get.dart';

import '../home_screen_controller.dart';

class DashboardController extends GetxController {
  void closeDrawer(HomeMenu menu) {
    try {
      var controller = Get.find<HomeScreenController>();

      controller.closeDrawer(menu);
    } catch (e) {}
  }
}
