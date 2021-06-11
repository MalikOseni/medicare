import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medicare/ui/views/appointment/appointment_screen_controller.dart';
import 'package:medicare/utils/constant_string.dart';
import 'package:medicare/utils/locator.dart';

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setupScreenUtil(context);
    return GetBuilder<AppointmentScreenController>(
        init: AppointmentScreenController(),
        builder: (model) {
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
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(Constant.onBoardingOne)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Dr. Aisha",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Medical Practitioner,",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: model.submittedAppointment ? SizedBox(height: 5,): Text(
                          model.showAppointTime
                              ? "pick appointment time".toUpperCase()
                              : "Make A Complaint".toUpperCase(),
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
                        height: 30,
                      ),


                     model.showAppointTime ? Center(
                       child: model.submittedAppointment ? Column(children: [



                         Text("Appointment pending".toUpperCase(), style: TextStyle(
                           fontSize: 25,
                           color: Colors.grey

                         ),),


                         SizedBox(
                           height: 20,
                         ),

                         Container(
                           height: 150,
                           width: 150,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             image: DecorationImage(
                                 fit: BoxFit.cover,
                                 image: AssetImage(Constant.pauseIcon)),
                           ),
                         ),

                       ],) : Wrap(
                         runSpacing: 25,
                         spacing: 30,
                         children: ScheduleTime.values.map((e) => InkWell(
                           onTap: (){
                             model.selectTime(e);
                           },
                           child: Container(
                             decoration: BoxDecoration(
                               color:model.scheduleTime == e ? Color(0xff00F98D) : null,
                               borderRadius: BorderRadius.circular(5),
                               border: Border.all(color: Colors.grey)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(model.getTitle(e)),
                             ),
                           ),
                         )).toList(),
                       ),
                     ) : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Tell us how you are feeling.. ",
                            style: TextStyle(fontSize: 11),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            focusNode: model.complainFocus,
                            onEditingComplete: () {
                              model.complainFocus.unfocus();
                            },
                            textInputAction: TextInputAction.next,
                            controller: model.complaintController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                focusColor: Theme.of(context).primaryColor,
                                hintStyle: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: 13),
                                hintText: "Enter your complaint"),
                            style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                                fontSize: 13),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 51,
                      ),
                      InkWell(
                        onTap: model.nextClicked,
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xff5584DF)),
                          child: Center(
                            child: Text( model.getButtonText(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
