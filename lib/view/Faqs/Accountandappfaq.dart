import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Accountapp extends StatefulWidget {
  const Accountapp({super.key});

  @override
  State<Accountapp> createState() => _AccountappState();
}

class _AccountappState extends State<Accountapp> {
  bool isExpanded = true;
  bool isExpanded2 = false;

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
            color: Color(0xFF80B918),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 20,
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
                                    backgroundColor: Color(0xFFF1F1F1),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 25.h,
                                          color: Color(0xFF141414),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sizedBoxWidth(15.w),
                                Text(
                                  "FAQ's",
                                  style: TextStyle(
                                    color: Color(0xFF141414),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            sizedBoxHeight(33.h),
                            Text(
                              "We're Happy To Help",
                              style: TextStyle(
                                color: Color(0xFF141414),
                                fontSize: 20.sp,
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
            color: Color(0xFF80B918),
            child: Container(
              width: 390.w,
              height: 625.h,
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
                          color: Color(0xFF141414),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  sizedBoxHeight(17.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                    ),
                    child: Text(
                      "Accont &App",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF141414),
                      ),
                    ),
                  ),
                  sizedBoxHeight(11.h),
                  faq1(),
                  sizedBoxHeight(11.h),
                  faq2(),
                  sizedBoxHeight(11.h),
                  faq2(),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget faq1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: 358.w,
        decoration: BoxDecoration(
          color: AppColors.greyF1F1F1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ExpansionTile(
          childrenPadding:
              EdgeInsets.only(left: 6.w, right: 6.w, bottom: 8.h, top: 10.h),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (bool expanding) {
            setState(() {
              isExpanded = expanding;
            });
          },
          trailing: Text(""),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What Is Farm Flow?",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF141414),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: 345.w,
              // height: 109.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Text(
                  "Farmflow Specialises In Helping Farmers Manage And Estimate Feed Requirements Accurately.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF4D4D4D),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget faq2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: 358.w,
        decoration: BoxDecoration(
          color: AppColors.greyF1F1F1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ExpansionTile(
          childrenPadding:
              EdgeInsets.only(left: 6.w, right: 6.w, bottom: 8.h, top: 10.h),
          initiallyExpanded: isExpanded2,
          onExpansionChanged: (bool expanding) {
            setState(() {
              isExpanded2 = expanding;
            });
          },
          trailing: Text(""),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What Is Farm Flow Work?",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF141414),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: 345.w,
              // height: 109.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Text(
                  "Farmflow Specialises In Helping Farmers Manage And Estimate Feed Requirements Accurately.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF4D4D4D),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
