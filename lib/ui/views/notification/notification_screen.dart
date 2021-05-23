import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/ui/views/home_screen_controller.dart';
import 'package:medicare/utils/constant_string.dart';

import 'notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (model){
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: Get.width,
                    height: Get.height * 0.4,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff5584DF),
                              Color(0xff00F98D),
                            ])),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(

                                    shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                          AssetImage(Constant.alarmClock))
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Notifications,",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),

                            Text(
                              "View Notifications",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )),


                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}

class CurveArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    paint.color = Colors.white;

    final path = Path();

    path.moveTo(0, size.height * 0.95);

    //   path.lineTo( size.width * 0.35, size.height * 0.75);

    path.quadraticBezierTo(
        0, size.height * 0.85, size.width * 0.25, size.height * 0.7);

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.25, size.height * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
