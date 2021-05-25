
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/Services/appointment_service/appointment_service.dart';
import 'package:medicare/Services/auth_service/auth_service.dart';
import 'package:medicare/Services/cloud_function/cloud_function_service.dart';
import 'package:medicare/Services/notification_service/notification_service.dart';
import 'package:medicare/Services/student_data_service/student_data_service.dart';

var locator = GetIt.instance;



void setupServices() {
  locator.registerLazySingleton<AuthService>(() => AuthServiceFake());
  locator.registerFactory<CloudFunctionService>(() => CloudFunctionServiceFake());
  locator.registerFactory<NotificationService>(() => NotificationServiceFake());


  locator.registerFactory<StudentDataService>(() => StudentDataServiceFake());

  locator.registerFactory<AppointmentService>(() => AppointmentServiceFake());

}

void showNotification({String title, String message}) async {





  return;
}

void initializeNotifications() {


}

Future<void> initializeLocalNotifications() async {


}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

void setupScreenUtil(BuildContext context) {


  if (Get.width > 375) {
    ScreenUtil.init(context,
        designSize: Size(Get.width, Get.height), allowFontScaling: true);
  } else {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: true);
  }
}
