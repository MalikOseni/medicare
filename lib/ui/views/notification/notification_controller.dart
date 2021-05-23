import 'dart:async';

import 'package:get/get.dart';
import 'package:medicare/Services/notification_service/notification_service.dart';
import 'package:medicare/datamodel/notification_data.dart';
import 'package:medicare/utils/locator.dart';

import '../home_screen_controller.dart';

class NotificationController extends GetxController {


  NotificationService _notificationService = locator<NotificationService>();

  List<NotificationData> notificationList = [];

  StreamSubscription<List<NotificationData>> _subscription;


  @override
  void onInit() {


    super.onInit();
  }


  void closeDrawer(HomeMenu menu) {
    try {
      var controller = Get.find<HomeScreenController>();

      controller.closeDrawer(menu);
    } catch (e) {}
  }
}
