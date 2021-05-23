
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medicare/ui/theme/theme_dark.dart';
import 'package:medicare/utils/constant_string.dart';
import 'package:medicare/utils/locator.dart';

import 'splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // setupScreenUtil();
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: true);

    return GetBuilder<SplashScreenController>(
     init: SplashScreenController(),
     builder: (model){
       return Scaffold(

         body: Center(
           child:  Container(
             width: 150,
             height: 100,
             decoration: BoxDecoration(
                 image: DecorationImage(image: AssetImage(Constant.logoImage),
                     fit: BoxFit.contain
                 )
             ),
           ),
         )
       );
     },
   );
  }
}
