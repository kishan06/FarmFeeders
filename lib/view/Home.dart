import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_appbar_home.dart';
import 'package:farmfeeders/common/custom_button.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../common/status.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool lowFeed = true;
  bool saved = false;

  List currentFeedData = [
    {
      "imagePath": "assets/images/buffalo.png",
      "feedFor": "Current Feed for Buffalo",
      "qty": "100"
    },
    {
      "imagePath": "assets/images/cow.png",
      "feedFor": "Current Feed for Cow",
      "qty": "600"
    },
    {
      "imagePath": "assets/images/sheep.png",
      "feedFor": "Current Feed for Sheep",
      "qty": "100"
    },
    {
      "imagePath": "assets/images/pig.png",
      "feedFor": "Current Feed for Pig",
      "qty": "600"
    },
    {
      "imagePath": "assets/images/hen.png",
      "feedFor": "Current Feed for Hen",
      "qty": "100"
    },
  ];

  int selectedCurrentFeed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: customAppBarHome(text: "knc"),
        //   backgroundColor: Colors.white,
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   titleSpacing: 0,
        // ),
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(75.w, 10.h, 16.w, 10.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBlack20W7000Mon("Welcome Back"),
                    textBlack25W600Mon("Kevin")
                  ],
                ),
                Spacer(),
                Container(
                  height: 42.h,
                  width: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.h),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5.h,
                        spreadRadius: 2.h,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed("/notification");
                        },
                        child: SvgPicture.asset(
                          "assets/images/notification_bell.svg",
                          height: 28.h,
                          width: 28.h,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxWidth(10.w),
                Container(
                  height: 42.h,
                  width: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.h),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5.h,
                        spreadRadius: 2.h,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Icons.settings,
                      //   size: 3.h,
                      //   // color: app,
                      // )
                      InkWell(
                        onTap: () {
                          // Get.toNamed("/settings");
                        },
                        child: SvgPicture.asset(
                          "assets/images/Settings.svg",
                          height: 28.h,
                          width: 28.h,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                            color: AppColors.pistaE3FFE9,
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Lottie.asset(
                                      "assets/lotties/cloud2.json",
                                      height: 200.h,
                                      width: 200.w,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        36.w, 25.h, 36.w, 12.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/images/locationconnect.svg",
                                                          color:
                                                              AppColors.black,
                                                          height: 20.h,
                                                          width: 20.h,
                                                        ),

                                                        sizedBoxWidth(5.w),

                                                        // textBlack20W7000("Ireland"),
                                                        textBlack18W5000(
                                                            "Ireland")
                                                      ],
                                                    ),
                                                    textGreen50Bold("22° C"),
                                                    textBlack18W5000(
                                                        "Sat, 3 Nov -12.32PM"),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            // LottieBuilder.asset(name)
                                            // Lottie.asset("assets/lotties/cloud.json",
                                            //   height: 100.h,
                                            //   width: 200.w
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 10.h),
                                child: Container(
                                  // width: 358.w,
                                  // height: 221.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(19.h)),
                                      color: AppColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x48B9B9BE),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 15.h),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30.h,
                                              width: 123.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.h),
                                                color: Color(0XFFFFB7B7),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Arriving Soon",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Color(0XFFAC2A33),
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizedBoxHeight(18.h),

                                            textBlack20W7000("Dairy Feed"),
                                            textGrey4D4D4D_14("100 Tonnes"),

                                            Lottie.asset(
                                                "assets/lotties/delivery_track.json",
                                                height: 120.h,
                                                width: 137.w)

                                            // Lottie
                                            // Image.asset(
                                            //   "assets/images/yourorder2.png",
                                            //   width: 105.w,
                                            //   height: 98.h,
                                            // ),
                                            // sizedBoxHeight(7.h),
                                          ],
                                        ),
                                        // sizedBoxWidth(25.w),
                                        // Padding(
                                        //   padding: EdgeInsets.only(top: 19.h),
                                        //   child: SvgPicture.asset(
                                        //     "assets/images/orderlocate.svg",
                                        //     width: 30.w,
                                        //     height: 189.h,
                                        //   ),
                                        // ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            status(),
                                            DottedLine(
                                              direction: Axis.vertical,
                                              lineLength: 30,
                                              lineThickness: 2.0,
                                              dashLength: 4.0,
                                              dashColor: Color(0XFF0E5F02),
                                            ),
                                            status(),
                                            DottedLine(
                                              direction: Axis.vertical,
                                              lineLength: 30,
                                              lineThickness: 2.0,
                                              dashLength: 4.0,
                                              dashColor: Color(0XFF0E5F02),
                                            ),
                                            // status(),
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColors.buttoncolour,
                                              radius: 11.w,
                                              child: CircleAvatar(
                                                radius: 9.w,
                                                backgroundColor:
                                                    AppColors.pistaE3FFE9,
                                                child: SvgPicture.asset(
                                                    "assets/images/delivery-truck-svgrepo-com.svg"),
                                              ),
                                            ),

                                            DottedLine(
                                              direction: Axis.vertical,
                                              lineLength: 30,
                                              lineThickness: 2.0,
                                              dashLength: 4.0,
                                              dashColor: Color(0XFF0E5F02),
                                            ),
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .buttoncolour)),
                                            )
                                          ],
                                        ),
                                        sizedBoxWidth(9.w),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ordered",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color(0XFF0E5F02),
                                                  fontFamily: "Poppins"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/clock-svgrepo-com (1).svg",
                                                  width: 6.w,
                                                  height: 6.w,
                                                ),
                                                sizedBoxWidth(6.w),
                                                Text(
                                                  "9.30 Pm, 10 May2023",
                                                  style: TextStyle(
                                                      color: Color(0xff4D4D4D),
                                                      fontSize: 8.sp,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(14.h),
                                            Text(
                                              "Loaded",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color(0XFF0E5F02),
                                                  fontFamily: "Poppins"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/clock-svgrepo-com (1).svg",
                                                  width: 6.w,
                                                  height: 6.w,
                                                ),
                                                sizedBoxWidth(6.w),
                                                Text(
                                                  "9.30 Pm, 10 May2023",
                                                  style: TextStyle(
                                                      color: Color(0xff4D4D4D),
                                                      fontSize: 8.sp,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            ),
                                            sizedBoxHeight(13.h),
                                            Container(
                                              height: 30.h,
                                              width: 123.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.h),
                                                color: Color(0XFFF1F1F1),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Out for delivery",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color(0XFF0E5F02),
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizedBoxHeight(29.h),
                                            Text(
                                              "Delivered",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color(0XFF4D4D4D),
                                                  fontFamily: "Poppins"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        sizedBoxHeight(10.h),
                        Stack(
                          // fit: StackFit.loose,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  )
                                ],
                                color: AppColors.pistaE3FFE9,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 15.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                          5,
                                          (index) => currentFeedSelection(
                                              imagePath: currentFeedData[index]
                                                  ["imagePath"],
                                              index: index)),
                                    ),

                                    sizedBoxHeight(10.h),

                                    textBlack18W600Mon(
                                        currentFeedData[selectedCurrentFeed]
                                            ["feedFor"]),
                                    // /
                                    sizedBoxHeight(15.h),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/current_feed.svg",
                                          height: 170.h,
                                          width: 100.w,
                                        ),

                                        // sizedBoxWidth(20.w),
                                        // Spacer(),

                                        SizedBox(
                                          // height: 200.h,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 93.h,
                                                width: 230.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.h),
                                                  color: AppColors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.04),
                                                      blurRadius: 10,
                                                      spreadRadius: 2,
                                                    )
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 13.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      textGrey4D4D4D_22(
                                                          "Dairy"),
                                                      textBlack25W7000(
                                                          currentFeedData[
                                                                      selectedCurrentFeed]
                                                                  ["qty"] +
                                                              " Kg")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              sizedBoxHeight(10.h),
                                              Container(
                                                height: 93.h,
                                                width: 230.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.h),
                                                  color: AppColors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.04),
                                                      blurRadius: 10,
                                                      spreadRadius: 2,
                                                    )
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 13.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      textGrey4D4D4D_16(
                                                          "Reordering Date"),
                                                      // textGrey4D4D4D_22("Dairy"),
                                                      // textBlack25W7000("100 Kg")
                                                      // Row()
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 20.h,
                                                            backgroundColor:
                                                                AppColors
                                                                    .greyF1F1F1,
                                                            child: Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 20.h,
                                                              color: AppColors
                                                                  .buttoncolour,
                                                            ),
                                                          ),
                                                          sizedBoxWidth(10.w),
                                                          textBlack20W7000(
                                                              "02/05/2023")
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    sizedBoxHeight(10.h),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          size: 30.h,
                                          color: AppColors.redFA5658,
                                        ),
                                        textBlack18W7000(" Your Feed is Low!"),
                                        Spacer(),
                                        SizedBox(
                                          height: 45.h,
                                          width: 120.w,
                                          child: customButtonCurve(
                                              text: "Refill Now", onTap: () {}),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight(20.h),
                        textBlack18W7000("Profile"),
                        Container(
                          // height: 93.h,
                          // width: 230.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white,
                            border: Border.all(
                                color: AppColors.buttoncolour, width: 1.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            child: Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    SizedBox(
                                      height: 55.w,
                                      width: 55.w,
                                      child: CircularProgressIndicator(
                                        value: 0.42,
                                        strokeWidth: 5.w,
                                        // semanticsValue: "df",
                                        // color: AppColors.redFA5658,
                                        backgroundColor: AppColors.buttoncolour,
                                        valueColor:
                                            AlwaysStoppedAnimation(Colors.red),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -5.h,
                                      left: 20.h,
                                      child: Container(
                                        // height: 93.h,
                                        // width: 230.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2.h),
                                          color: AppColors.white,
                                          border: Border.all(
                                              color: AppColors.buttoncolour,
                                              width: 1.h),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.04),
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w),
                                          child: textBlack10("42 %"),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 15.h,
                                        left: 22.5.h,
                                        child: textBlack18W7000("K"))
                                  ],
                                ),
                                sizedBoxWidth(20.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textBlack18W7000("Hey Kevin"),

                                    InkWell(
                                      onTap: () {
                                        Get.toNamed("/profile");
                                        // Get
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width: 175.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            color: AppColors.buttoncolour),
                                        child: Center(
                                          child: Text(
                                            "Complete Your Profile",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                    )

                                    // SizedBox(
                                    //   height: 40.h,
                                    //   // width: 175.w,
                                    //   child: customButton(text: "Complete Your Profile"))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        sizedBoxHeight(25.h),
                        InkWell(
                          onTap: () {
                            Get.toNamed("/trainingmain");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(27.h),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ],
                              color: AppColors.pistaE3FFE9,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 13.w, vertical: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBlack18W600Mon("Training"),
                                  sizedBoxHeight(15.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/images/training1.png",
                                        width: 104.w,
                                        height: 90.h,
                                      ),
                                      sizedBoxWidth(14.w),
                                      // SvgPicture.asset("assets/images/current_feed.svg",
                                      //   height: 170.h,
                                      //   width: 100.w,
                                      // ),

                                      // sizedBoxWidth(20.w),
                                      // Spacer(),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textBlack18W600Mon(
                                                "Animal husbandry and management"),
                                            textGrey4D4D4D_16(
                                                "textext of the printing andt"),
                                            textGreen14("14 Minutes ago")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        sizedBoxHeight(20.h),
                        InkWell(
                          onTap: () {
                            Get.toNamed("/newsandarticlemain");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.grey4D4D4D, width: 0.5.h),
                              borderRadius: BorderRadius.circular(27.h),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ],
                              color: AppColors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 13.w, vertical: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBlack18W600Mon("News & Articles"),
                                  sizedBoxHeight(15.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/images/news&arti.png",
                                        width: 104.w,
                                        height: 90.h,
                                      ),
                                      sizedBoxWidth(14.w),
                                      // SvgPicture.asset("assets/images/current_feed.svg",
                                      //   height: 170.h,
                                      //   width: 100.w,
                                      // ),

                                      // sizedBoxWidth(20.w),
                                      // Spacer(),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textGrey4D4D4D_16("Livestock"),

                                            textBlack18W600Mon(
                                                "Lorem Ipsum Is Simply Dummy Of The Printing"),

                                            // textGreen14("14 Minutes ago")
                                            sizedBoxHeight(10.h),

                                            Row(
                                              children: [
                                                textGrey4D4D4D_14("7 Feb 2023"),
                                                Spacer(),
                                                InkWell(
                                                  onTap: share,
                                                  child: Container(
                                                    height: 25.h,
                                                    width: 25.h,
                                                    child: SvgPicture.asset(
                                                      "assets/images/share.svg",
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      saved = !saved;
                                                    });
                                                  },
                                                  child: saved
                                                      ? Container(
                                                          height: 25.h,
                                                          width: 25.h,
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/saveblank.svg",
                                                          ))
                                                      : Container(
                                                          height: 25.h,
                                                          width: 25.h,
                                                          child: SvgPicture.asset(
                                                              "assets/images/save.svg")),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: lowFeed,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                      child: Container(
                        // clipBehavior: Clip.none,
                        height: 93.h,

                        // width: double.negativeInfinity,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          color: AppColors.redFCDADA,
                          border: Border.all(
                              color: AppColors.redFA5658, width: 1.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.h,
                                backgroundColor: AppColors.redFA5658,
                                child: CircleAvatar(
                                  radius: 18.h,
                                  backgroundColor: AppColors.white,
                                  child: Icon(
                                    Icons.warning_amber_rounded,
                                    size: 25.h,
                                    color: AppColors.redFA5658,
                                  ),
                                ),
                              ),

                              sizedBoxWidth(20.w),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBlack18W7000("Feed Low! Refill Now"),
                                  textGrey4D4D4D_14("Feed Quantity At 10%")
                                ],
                              ),

                              Spacer(),

                              // circle
                              // ListWheelScrollView(itemExtent: itemExtent, children: children)

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    lowFeed = false;
                                  });
                                  // lowFeed = false;
                                },
                                child: CircleAvatar(
                                  radius: 17.h,
                                  backgroundColor: AppColors.white,
                                  child: Icon(
                                    Icons.close,
                                    size: 25.h,
                                    color: AppColors.grey4D4D4D,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget currentFeedSelection({required String imagePath, required int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCurrentFeed = index;
        });
      },
      child: Container(
        width: 40.w,
        height: 30.h,
        decoration: BoxDecoration(
            // dec
            color: selectedCurrentFeed == index
                ? Color.fromARGB(255, 236, 248, 239)
                : AppColors.white,
            borderRadius: BorderRadius.circular(5.h),
            border: Border.all(
                color: selectedCurrentFeed == index
                    ? AppColors.buttoncolour
                    : AppColors.grey4D4D4D)),
        child: Padding(
          padding: EdgeInsets.all(4.h),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Example share',
      // text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      // chooserTitle: 'Example Chooser Title'
    );
  }
}
