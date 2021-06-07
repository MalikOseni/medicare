
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/Services/auth_service/auth_service.dart';
import 'package:medicare/Services/local_storage_service/storage_service.dart';
import 'package:medicare/ui/route/route_names.dart';
import 'package:medicare/utils/constant_string.dart';
import 'package:medicare/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {

  AuthService _authService = locator<AuthService>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();


    bool isFirstTime =  preferences.getBool(Constant.firstTimeUser) ?? true;


    if (isFirstTime) {


      await preferences.setBool(Constant.firstTimeUser, !isFirstTime);

       Get.offAndToNamed(RouteName.on_boarding);
    } else {
      if(_authService.isLoggedIn()){
        Get.offAndToNamed(RouteName.homeScreen);
      } else {
        Get.offAndToNamed(RouteName.login);
      }
    }

  }

}
