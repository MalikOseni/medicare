
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medicare/ui/shared/full_screen_dialog_appbar.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (model){
        return Scaffold(
          appBar: fullScreenDialogAppBar(title: "Recover Password"),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Stack(
                children: [
                  Container(
                    height: Get.height - 130,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil()
                                .setSp(30, allowFontScalingSelf: true)),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      Text(
                        "Let us help you get back in",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil()
                                .setSp(14, allowFontScalingSelf: true)),
                      ),

                      SizedBox(
                        height: 41.h,
                      ),
                      TextField(
                        focusNode: model.emailFocus,
                        onEditingComplete: (){
                          model.emailFocus.unfocus();
                        },
                        controller: model.emailController,
                        decoration: InputDecoration(
                          hintStyle:     TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          fontSize: ScreenUtil()
                              .setSp(15, allowFontScalingSelf: true)),
                            hintText: "Enter your email address"),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontSize: ScreenUtil()
                                .setSp(15, allowFontScalingSelf: true)),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [


                        FlatButton(onPressed:model.loginClicked, child: Text(
                          "Login Instead",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenUtil()
                                .setSp(12, allowFontScalingSelf: true),
                          ),
                        ),
                        ),

                        SizedBox(
                          width: 10,
                        ),



                        SizedBox(
                          height: 30.h,
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: model.forgotPasswordClicked,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            height: 56.h,
                            child: Center(
                              child: Text(
                                "Recover Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil()
                                        .setSp(15, allowFontScalingSelf: true),
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
