import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicare/ui/route/route_names.dart';
import 'package:medicare/ui/theme/theme_light.dart';
import 'package:medicare/utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  setupServices();

 // await Firebase.initializeApp();

  initializeNotifications();


  await initializeLocalNotifications();

  runApp(
    MedicareApp(),
  );
}

class MedicareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.homeScreen,

      getPages: RouteName.getPages(),
      theme: DeggiaLightTheme.appLightTheme(),
      //onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}
