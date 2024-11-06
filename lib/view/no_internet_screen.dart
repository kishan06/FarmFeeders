import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Utils/colors.dart';

class NoInternetscreen extends StatefulWidget {
  const NoInternetscreen({super.key});

  @override
  _NoInternetscreenState createState() => _NoInternetscreenState();
}

class _NoInternetscreenState extends State<NoInternetscreen> {
  String? string;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: Column(children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            height: 180.h,
            width: Get.width,
            child: Lottie.asset("assets/lotties/no_internet.json",
                height: 130.h, width: Get.width, fit: BoxFit.cover),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text("Whoops!",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        "Internet Connection is Down!\n\nEnsure your internet's up and running.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () async {
                      final connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.wifi ||
                          connectivityResult == ConnectivityResult.mobile) {
                        setState(() {
                          Get.back();
                        });
                      } else {
                        utils.showToast("Internet is still down");
                      }
                    },
                    child: Container(
                      height: 54.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          color: AppColors.buttoncolour),
                      child: Center(
                        child: Text(
                          "Try Again",
                          style: TextStyle(
                              color: AppColors.white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
