import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/faq_model.dart';
import '../../view_models/FAQApi.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  DashboardController dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 177.h,
            width: Get.width,
            color: const Color(0xFF80B918),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 22,
                      left: 129,
                      right: 111,
                      child: SvgPicture.asset(
                        "assets/images/Ellipse 701.svg",
                        width: 150.w,
                        height: 137.h,
                      ),
                    ),
                    Positioned(
                      left: 210,
                      right: 70,
                      bottom: 40,
                      child: SvgPicture.asset(
                        "assets/images/Ellipse 701.svg",
                        width: 111.w,
                        height: 101.h,
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBoxHeight(39.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: CircleAvatar(
                                    radius: 20.h,
                                    backgroundColor: const Color(0xFFF1F1F1),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 25.h,
                                          color: const Color(0xFF141414),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sizedBoxWidth(15.w),
                                Text(
                                  "FAQ's",
                                  style: TextStyle(
                                    color: const Color(0xFF141414),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight(33.h),
                            Text(
                              "We're Happy To Help",
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sizedBoxHeight(10.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF80B918),
            child: Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 23.h),
                    child: Text(
                      "Frequently Asked Quetions:",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: const Color(0xFF141414),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 28.w, right: 28.w, top: 38.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FAQApi().getFAQData("7").then((value) {
                              dashboardController.faqModel =
                                  FAQModel.fromJson(value.data);
                              dashboardController.faqText = "Account & App";
                              Get.toNamed('/accountfaq');
                            });
                          },
                          child: SizedBox(
                            width: Get.width / 2.5,
                            height: 150.h,
                            child: Card(
                              color: const Color(0xffF1F1F1),
                              // shadowColor: Color(0XFF00000029),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/account_app.svg",
                                    width: 67.w,
                                    height: 67.h,
                                  ),
                                  sizedBoxHeight(6.h),
                                  Text(
                                    "Account \n& App",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            FAQApi().getFAQData("8").then((value) {
                              dashboardController.faqModel =
                                  FAQModel.fromJson(value.data);
                              dashboardController.faqText = "Services";
                              Get.toNamed('/accountfaq');
                            });
                          },
                          child: SizedBox(
                            width: Get.width / 2.5,
                            height: 150.h,
                            child: Card(
                              color: const Color(0xffF1F1F1),
                              // shadowColor: Color(0XFF00000029),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/services.svg",
                                    width: 67.w,
                                    height: 67.h,
                                  ),
                                  sizedBoxHeight(6.h),
                                  Text(
                                    "Services",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 28.w, right: 28.w, top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FAQApi().getFAQData("9").then((value) {
                              dashboardController.faqModel =
                                  FAQModel.fromJson(value.data);
                              dashboardController.faqText = "Subscription";
                              Get.toNamed('/accountfaq');
                            });
                          },
                          child: SizedBox(
                            width: Get.width / 2.5,
                            height: 150.h,
                            child: Card(
                              color: const Color(0xffF1F1F1),
                              // shadowColor: Color(0XFF00000029),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/subscription.svg",
                                    width: 67.w,
                                    height: 67.h,
                                  ),
                                  sizedBoxHeight(6.h),
                                  Text(
                                    "Subscription",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            FAQApi().getFAQData("10").then((value) {
                              dashboardController.faqModel =
                                  FAQModel.fromJson(value.data);
                              dashboardController.faqText =
                                  "Connect with Experts";
                              Get.toNamed('/accountfaq');
                            });
                          },
                          child: SizedBox(
                            width: Get.width / 2.5,
                            height: 150.h,
                            child: Card(
                              color: const Color(0xffF1F1F1),
                              // shadowColor: Color(0XFF00000029),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/connect_with_experts.svg",
                                    width: 67.w,
                                    height: 67.h,
                                  ),
                                  sizedBoxHeight(6.h),
                                  Text(
                                    "Connect with\nExperts",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
