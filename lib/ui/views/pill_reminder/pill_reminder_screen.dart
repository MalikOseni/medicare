import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medicare/ui/views/home_screen_controller.dart';
import 'package:medicare/utils/constant_string.dart';

import 'pill_reminder_controller.dart';

class PillReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PillReminderScreenController>(
        init: PillReminderScreenController(),
        builder: (model){
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverList(delegate: SliverChildListDelegate(([

                Column(
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
                                            fit: BoxFit.contain,
                                              image:
                                              AssetImage(Constant.pillsImage))
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Pill Reminder",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),

                                Text(
                                  "Get drug notification",
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
                      height: 20,
                    ),

                    Center(
                      child: Text(

                        model.getTitle().toUpperCase(),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            shadows: [Shadow(offset: Offset(0, -5))],
                            color: Colors.transparent,
                            decorationColor: Color(0xff00F98D),
                            decorationThickness: 4,
                            fontSize: 13),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),

              ]))),


              SliverList(delegate: SliverChildBuilderDelegate(

                      (c, i){

                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            top: 10,
                            left: 8,
                            right: 8
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[200]),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [



                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Container(
                                  height: 50, width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200]

                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(Constant.pillsImage))
                                      ),
                                    ),
                                  ),
                                ),

                                title: Text(model.notificationList[i].title, style: TextStyle(

                                  color: Colors.black,
                                  fontSize: 17

                                ),),


                                trailing: IconButton(icon: Icon(Icons.delete, color:  Colors.red,), onPressed: (){
                                  model.deleteReminder(i);
                                })


                              ),
                            ),
                          ),
                        );
                      },
                childCount: model.notificationList.length,


              ))

            ],
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
