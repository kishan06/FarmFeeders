import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/colors.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  String? token;
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token').toString();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lotties/error_animation.json",
                height: 300.h, width: Get.width, fit: BoxFit.contain),
            const Gap(80),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                    "Harvesting data is on hold! We're sowing the seeds for a better User experience.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ))),
            const Gap(80),
            GestureDetector(
              onTap: () {
                if (token == null || token!.isEmpty) {
                  Get.offAndToNamed("/loginScreen");
                } else {
                  Get.toNamed('/sideMenu');
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 80),
                width: Get.width,
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.buttoncolour,
                ),
                child: Center(
                  child: Text("Retry",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
