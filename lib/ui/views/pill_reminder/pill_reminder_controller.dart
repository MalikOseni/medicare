import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:medicare/Services/appointment_service/appointment_service.dart';
import 'package:medicare/Services/notification_service/notification_service.dart';
import 'package:medicare/Services/pill_service/pill_service.dart';
import 'package:medicare/datamodel/appointment_history.dart';
import 'package:medicare/datamodel/notification_data.dart';
import 'package:medicare/datamodel/pill_reminder.dart';
import 'package:medicare/ui/shared/info_snackbar.dart';
import 'package:medicare/utils/constant_string.dart';
import 'package:medicare/utils/locator.dart';

import '../home_screen_controller.dart';

class PillReminderScreenController extends GetxController {
  PillDataService _notificationService = locator<PillDataService>();

  List<PillData> notificationList = [];

  StreamSubscription<List<PillData>> _subscription;

  bool addDrugInterface = false;

  bool everyday = true;

  TextEditingController editingController = TextEditingController();

  Intake intake = Intake.once;
  DrugType drugType = DrugType.capsule;

  @override
  void onInit() {
    fetchNotification();
    updateBoolValue(true);
    super.onInit();
  }

  void updateBoolValue(bool value) {
    try {
      var controller = Get.find<HomeScreenController>();
      controller.changeFloating(value: value);
    } catch (e) {
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
    _subscription = _notificationService.listenForPillData().listen((event) {
      notificationList = event ?? [];

      if (notificationList.isEmpty) {
        updateBoolValue(true);
      }

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

  String getTitle() {
    return addDrugInterface ? "Add Drug" : "Drug list";
  }

  void updateEveryDay(bool v) {
    this.everyday = v;
    update();
  }

  String getTopic(String intake) {
    if (intake == "1") {
      return "once";
    }

    if (intake == "2") {
      return "twice";
    }

    return "thrice";
  }

  void deleteReminder(int i) async {
    PillData pillData = notificationList[i];



    notificationList.removeAt(i);

    if (pillData.intake == "1") {


      PillData pillData = notificationList
          .firstWhere((element) => element.intake == "1", orElse: (){
            return null;
      });


      if(pillData == null){
        await FirebaseMessaging().unsubscribeFromTopic("once");
      }



    } else if (pillData.intake == "2") {

      PillData pillData = notificationList
          .firstWhere((element) => element.intake == "2", orElse: null);


      if(pillData == null){
        await FirebaseMessaging().unsubscribeFromTopic("twice");
      }


    } else {
      PillData pillData = notificationList
          .firstWhere((element) => element.intake == "3", orElse: null);


      if(pillData == null){
        await FirebaseMessaging().unsubscribeFromTopic("thrice");
      }

    }


    update();

    await _notificationService.deleteNotification(
        documentId: pillData.documentId);
  }

  void addDrugClicked() {
    updateBoolValue(false);

    addDrugInterface = true;

    update();
  }

  void selectDatePressed(DrugType drugType) async {
    this.drugType = drugType;
    update();
  }

  void updateIntake(Intake intake) {
    this.intake = intake;
    update();
  }

  getDrugTypeTitle({DrugType drugType}) {
    if (drugType == DrugType.capsule) return "Capsule";

    return "Tablet";
  }

  getIntakeTitle({Intake intake}) {
    switch (intake) {
      case Intake.once:
        return "1";
        break;

      case Intake.twice:
        return "2";
        break;

      case Intake.thrice:
        return "3";
    }

    return "1";
  }

  void addDrug() async {
    String drugName = editingController.text.trim();

    if (drugName.isEmpty || drugName.length <= 2) {
      showInfoSnackBar(message: "Invalid name");
      return;
    }

    PillData pillData =
        PillData(name: drugName, intake: getIntakeTitle(intake: intake));

    _notificationService.addDrug(pillData: pillData);

    addDrugInterface = false;

    update();

    await Future.delayed(Duration(milliseconds: 250));

    editingController.clear();

    showInfoSnackBar(message: "Pill Reminder updated");

    updateBoolValue(true);
  }
}

enum DrugType { capsule, tablet }

enum Intake { once, twice, thrice }
