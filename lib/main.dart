import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/resources/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // GlobalVariables globalVariables = GlobalVariables();
  token = prefs.getString('accessToken');
  // log(token!);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: "Poppins",
              scaffoldBackgroundColor: AppColors.white,
              primarySwatch: Colors.blue,
            ),


            initialRoute: (token == null || token == "") ? '/' : '/sideMenu',
                //  initialRoute: '/letsSetUpYourFarm',


            getPages: AppRoutes.appRoutes(),
          );
        });
  }
}
