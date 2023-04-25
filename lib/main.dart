import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/resources/routes/routes.dart';
import 'package:farmfeeders/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        title: 'Farm Flow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        getPages: AppRoutes.appRoutes(),
      ),
    );
  }
}
