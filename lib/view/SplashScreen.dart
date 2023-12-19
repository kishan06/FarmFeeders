import 'dart:async';

import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('accessToken');
      if ((token == null || token == "")) {
        Get.offAndToNamed("/splashslider");
      } else {
        Get.offAndToNamed("/sideMenu");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          "assets/images/farmFlow.png",
          width: Get.width,
          height: 200.h,
        ),
      ),
    );
  }
}
