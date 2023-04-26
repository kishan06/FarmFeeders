import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/resources/routes/routes.dart';
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


      designSize: const Size(390, 844),
      builder: (context,child){
        return GetMaterialApp(
          
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Poppins",
            scaffoldBackgroundColor: AppColors.white,
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          getPages: AppRoutes.appRoutes(),
        );
      }
    );
    

  }
}
