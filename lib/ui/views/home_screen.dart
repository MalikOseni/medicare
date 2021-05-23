import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare/utils/constant_string.dart';
import 'package:medicare/utils/locator.dart';

import 'appointment/appointment_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'home_screen_controller.dart';
import 'notification/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // setupScreenUtil(context);

    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            flexibleSpace: SafeArea(
              child: SizedBox(
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Constant.logoImage),
                            fit: BoxFit.contain)),
                  )),
            ),
            actions: <Widget>[
              //
              // Icon(
              //   Icons.cancel
              // ),

              SizedBox(
                  height: 40,
                  width: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(Constant.onBoardingOne),
                            fit: BoxFit.cover)),
                  )),

              SizedBox(
                width: 10,
              ),
            ],
          ),
          drawer: Drawer(
            child: _menu(context: context, model: model),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 0, right: 0),
            child: getDashboardWidget(model),
          ),
        );
      },
    );
  }

  Widget getDashboardWidget(HomeScreenController model) {
    switch (model.selectedItem) {
      case HomeMenu.dashboard:
        return DashboardScreen();

      case HomeMenu.appointment:
        return AppointmentScreen();

      case HomeMenu.notifications:
        return NotificationScreen();

    }

    return Container(); // UnverifiedScreen();
  }

  Widget _menu({BuildContext context, HomeScreenController model}) {
    String name = model.studentData.name;
    String matric =  model.studentData.matric;
    String email = model.studentData.email;

    return Padding(
      padding: EdgeInsets.only(left: 0, top: 0),
      child: Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        Color(0xff5584DF),
                        Color(0xff00F98D),
                      ])),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(
                              width: 20,
                            ),

                            Container(
                              height : 60,
                              width : 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(Constant.onBoardingOne),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                                Text(matric, style: TextStyle(
                                  color: Colors.white,
                                ),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Visibility(
                    visible: !model.isAssistant,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              model.closeDrawer(HomeMenu.dashboard);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 0),
                              child: dashBoardMenuItem(
                                  FontAwesome.home, "Dashboard"),
                            )),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      model.closeDrawer(HomeMenu.appointment);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 0),
                      child: dashBoardMenuItem(Icons.note_add, "Appointment"),
                    )),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      model.closeDrawer(HomeMenu.pill_reminder);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 0),
                      child: dashBoardMenuItem(Icons.note_add, "Pill Reminder"),
                    )),
                Visibility(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          model.closeDrawer(HomeMenu.appointment_history);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 0),
                          child: dashBoardMenuItem(
                              FontAwesome.home, "Appointment History"),
                        )),
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      model.closeDrawer(HomeMenu.signOut);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 0),
                      child:
                          dashBoardMenuItem(Icons.fastfood_outlined, "Log Out"),
                    )),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    "Created by Malik",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget dashBoardMenuItem(IconData icon, String name) {
    return Container(
      color: Color(0xffF3F3F3),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.blue,
            ),
            SizedBox(
              width: 19,
            ),
            Text(
              name,
              style: GoogleFonts.roboto(
                  color: Colors.blue,
                  fontSize: 16,
                  fontStyle: FontStyle.normal),
            )
          ],
        ),
      ),
    );
  }
}
