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
        builder: (model) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate(([
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
                            padding: const EdgeInsets.only(
                                top: 30, left: 20, right: 20),
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
                                              image: AssetImage(
                                                  Constant.pillsImage))),
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
              model.addDrugInterface
                  ? SliverList(
                      delegate: SliverChildListDelegate(([

                        Padding(padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [

                            SizedBox(
                              height: 15,
                            ),

                            Text("Input name"),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onEditingComplete: () {},
                              textInputAction: TextInputAction.next,
                              controller: model.editingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(25)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(25)),
                                  focusColor: Theme.of(context).primaryColor,
                                  hintStyle: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  hintText: "Name"),
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Text("Drug Type"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                PopupMenuButton<DrugType>(
                                  //   initialValue: model.paymentTime,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        height: 45,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  "${model.getDrugTypeTitle(drugType: model.drugType)} ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(
                                                color:
                                                Theme.of(context).primaryColor)),
                                      )
                                    ],
                                  ),
                                  onSelected: model.selectDatePressed,
                                  itemBuilder: (BuildContext context) {
                                    return DrugType.values.map((choice) {
                                      return PopupMenuItem<DrugType>(
                                        value: choice,
                                        child: Text(
                                          "${model.getDrugTypeTitle(drugType: choice)}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color),
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Text("Intake daily"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                PopupMenuButton<Intake>(
                                  //   initialValue: model.paymentTime,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        height: 45,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  "${model.getIntakeTitle(intake: model.intake)} ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              SizedBox(
                                                width: 70,
                                              ),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(
                                                color:
                                                Theme.of(context).primaryColor)),
                                      )
                                    ],
                                  ),
                                  onSelected: model.updateIntake,
                                  itemBuilder: (BuildContext context) {
                                    return Intake.values.map((choice) {
                                      return PopupMenuItem<Intake>(
                                        value: choice,
                                        child: Text(
                                          "${model.getIntakeTitle(intake: choice)}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color),
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),


                            Row(
                              children: [
                                Text("Everyday", style: TextStyle(
                                    color: Colors.black,
                                  fontSize: 16
                                ),),

                                Checkbox(value: model.everyday, onChanged: model.updateEveryDay)

                              ],
                            ),

                            SizedBox(
                              height: 51,
                            ),
                            InkWell(
                              onTap: model.addDrug,
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xff5584DF)),
                                child: Center(
                                  child: Text(
                                    "Add drug".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 50,
                            ),

                          ],
                        ),
                        )


                    ])))
                  : model.notificationList.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(Constant.emptyPill),
                                  )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Add pills to reminder to fill this space")
                              ],
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                          (c, i) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 10, left: 8, right: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[200]),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: []),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[200]),
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Constant.pillsImage))),
                                          ),
                                        ),
                                      ),
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            model.notificationList[i].name,
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 15),
                                          ),

                                          SizedBox(
                                            width: 10,
                                          ),

                                          Text(
                                            "( ${model.notificationList[i].intake} x daily )",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                                color: Colors.black, fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            model.deleteReminder(i);
                                          })),
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
