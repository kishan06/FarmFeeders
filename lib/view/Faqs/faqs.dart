import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
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
            width: 390.w,
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
              width: 390.w,
              height: Get.height / 1.41,
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
                        EdgeInsets.only(left: 28.w, right: 28.w, top: 32.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/accountfaq');
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/images/faqimage.svg",
                                width: 67.w,
                                height: 67.h,
                              ),
                              sizedBoxHeight(7.h),
                              Text(
                                "Account \n& App",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF000000),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/faqservices.svg",
                                  width: 67.w,
                                  height: 67.h,
                                ),
                                sizedBoxHeight(7.h),
                                Text(
                                  "Services",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xFF000000),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/images/faqimage.svg",
                                width: 67.w,
                                height: 67.h,
                              ),
                              sizedBoxHeight(7.h),
                              Text(
                                "Account \n& App",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF000000),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 28.w, right: 28.w, top: 38.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/images/faqimage.svg",
                                width: 67.w,
                                height: 67.h,
                              ),
                              sizedBoxHeight(7.h),
                              Text(
                                "Account \n& App",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF000000),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/faqservices.svg",
                                  width: 67.w,
                                  height: 67.h,
                                ),
                                sizedBoxHeight(7.h),
                                Text(
                                  "Services",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xFF000000),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/images/faqimage.svg",
                                width: 67.w,
                                height: 67.h,
                              ),
                              sizedBoxHeight(7.h),
                              Text(
                                "Account \n& App",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF000000),
                                ),
                              )
                            ],
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
