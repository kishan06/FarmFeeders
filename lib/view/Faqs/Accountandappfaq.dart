import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Accountapp extends StatefulWidget {
  const Accountapp({super.key});

  @override
  State<Accountapp> createState() => _AccountappState();
}

class _AccountappState extends State<Accountapp> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: SingleChildScrollView(
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
                                  )
                                ],
                              ),
                              sizedBoxHeight(33.h),
                              Text(
                                "We're Happy To Help",
                                style: TextStyle(
                                  color: const Color(0xFF141414),
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
              color: const Color(0xFF80B918),
              child: Container(
                width: 390.w,
                //  height: Get.height / 1.41,
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
                    sizedBoxHeight(17.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                      ),
                      child: Text(
                        dashboardController.faqText,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFF141414),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 50,
                        top: 15,
                      ),
                      height: Get.height / 1.5,
                      child: dashboardController.faqModel.data!.isEmpty
                          ? Center(
                              child: Text(
                                "No Data Available",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: const Color(0xFF141414),
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  dashboardController.faqModel.data!.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                    margin: EdgeInsets.only(bottom: 11.h),
                                    child: faq1(
                                        dashboardController
                                            .faqModel.data![index].question!,
                                        dashboardController
                                            .faqModel.data![index].answer!,
                                        index));
                              }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget faq1(String title, message, int index) {
    bool isExpanded = index == 0 ? true : false;
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
          trailing: const Text(""),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 290.w,
                child: Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF141414),
                      fontWeight: FontWeight.w600),
                ),
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
                  message,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF4D4D4D),
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
