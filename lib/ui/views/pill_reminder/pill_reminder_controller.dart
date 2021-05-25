import 'dart:async';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:medicare/Services/appointment_service/appointment_service.dart';
import 'package:medicare/Services/notification_service/notification_service.dart';
import 'package:medicare/datamodel/appointment_history.dart';
import 'package:medicare/datamodel/notification_data.dart';
import 'package:medicare/utils/constant_string.dart';
import 'package:medicare/utils/locator.dart';

import '../home_screen_controller.dart';

class PillReminderScreenController extends GetxController {
  AppointmentService _notificationService = locator<AppointmentService>();

  List<AppointmentHistory> notificationList = [];

  StreamSubscription<List<AppointmentHistory>> _subscription;

  bool addDrugInterface =  false;

  @override
  void onInit() {
    fetchNotification();
    updateBoolValue(true);
    super.onInit();
  }

  void updateBoolValue(bool value){

    try{
     var controller =  Get.find<HomeScreenController>();
     controller.changeFloating(value: value);

    } catch(e){
      print(e);
    }

  }

  void closeDrawer(HomeMenu menu) {
    try {
      var controller = Get.find<HomeScreenController>();

      controller.closeDrawer(menu);
    } catch (e) {}
  }

  void fetchNotification() {
    _subscription = _notificationService.listenForStudentData().listen((event) {
      notificationList = [];// event ?? [];
      update();
    });
  }

  String getImage(int i) {
    return Constant.timeIcon;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    updateBoolValue(false);
    super.onClose();
  }

  String getTimeNotif(int i) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(notificationList[i].time);

    var time = Jiffy({
      "year": date.year,
      "month": date.month,
      "day": date.day,
      "hour": date.hour
    }).jm;

    return  "$time " +
            " ${Jiffy({
              "year": date.year,
              "month": date.month,
              "day": date.day,
              "hour": date.hour
            }).yMMMMd}";
  }

  String getTitle() {

   return addDrugInterface ? "Add Drug" : "Drug list";

  }

  void deleteReminder(int i) {

  }
}
