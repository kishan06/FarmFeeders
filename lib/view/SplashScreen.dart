import 'dart:async';

import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Get.toNamed("/splashslider");
    });
    // Timer(
    //   Duration(seconds: 5), (timer) {
    //     Get.toNamed("/splashslider");
    //   }
    // );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttoncolour,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 80.h),
              child: InkWell(
                onTap: (){
                  Get.toNamed("/splashslider");
                },
                child: Stack(
                  // fit: StackFit.expand,
                  clipBehavior: Clip.none,
                      
                      
                  alignment: Alignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      
                    SizedBox(
                      height: 130.h,
                      child: Image.asset("assets/images/farmFlow.png",
                        width: 220.w,
                        height: 65.h,
                      ),
                    ),
                      
                    Positioned(
                      left: -110.h,
                      child: Lottie.asset("assets/lotties/loading.json",
                        height: 130.h,
                        width: 130.h
                      ),
                    ),
                      
                    
                      
                    
                      
                    // SvgPicture.asset("assets/images/farmFlow.svg",
                    //   width: 220.w,
                    //   height: 65.h,
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
        // child: IconButton(
        //     onPressed: () {
        //       Get.toNamed("/splashslider");
        //     },
        //     icon: Icon(Icons.skip_next)),
      ),
    );
  }
}
