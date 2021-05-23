import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medicare/ui/shared/info_snackbar.dart';

import '../home_screen_controller.dart';

class AppointmentScreenController extends GetxController {
  TextEditingController complaintController = TextEditingController();

  FocusNode complainFocus = FocusNode();

  bool showAppointTime = false;

  ScheduleTime scheduleTime = ScheduleTime.eleven05;

  bool submittedAppointment =  false;

  void closeDrawer() {
    try {
      var controller = Get.find<HomeScreenController>();

      controller.closeDrawer(HomeMenu.dashboard);
    } catch (e) {}
  }


  void nextClicked() {

    if(submittedAppointment == true){

      closeDrawer();

      return;
    }

    if (showAppointTime == true) {



      submittedAppointment =  true;

      update();

      return;
    }

    String complain = complaintController.text.trim();

    if (complain.isEmpty) {
      showInfoSnackBar(message: "Please enter a complaint");
      return;
    }

    showAppointTime = true;

    update();
  }

  String getTitle(ScheduleTime e) {
    switch (e) {
      case ScheduleTime.eleven05:
        return "11:05 Am";
      case ScheduleTime.eleven10:
        return "11:10 Am";
      case ScheduleTime.eleven15:
        return "11:15 Am";
      case ScheduleTime.eleven20:
        return "11:20 Am";
      case ScheduleTime.eleven25:
        return "11:25 Am";
      case ScheduleTime.eleven30:
        return "11:30 Am";
    }

    return "12:00 Pm";
  }

  void selectTime(ScheduleTime e) {

    scheduleTime = e;

    update();

  }

  String getButtonText() {

    if(submittedAppointment) return "Go Home".toUpperCase();



  return  showAppointTime ? "Submit".toUpperCase() :
    "next".toUpperCase();

  }
}

enum ScheduleTime { eleven05, eleven10, eleven15, eleven20, eleven25, eleven30 }
