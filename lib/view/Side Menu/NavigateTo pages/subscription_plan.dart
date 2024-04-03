import 'dart:developer';

import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/controller/profile_controller.dart';
import 'package:farmfeeders/models/SubscriptionModel/subscription_model.dart';
import 'package:farmfeeders/models/SubscriptionModel/subscription_plan_model.dart';
import 'package:farmfeeders/view/Side%20Menu/webview_subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/global.dart';
import '../../../data/stripe/api_service.dart';
import '../../../view_models/subscriptionApi.dart';
import 'package:http/http.dart' as http;

class SubscriptionPlan extends StatefulWidget {
  String? fromScreen;
  SubscriptionPlan({super.key, required this.fromScreen});

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  ProfileController profileController = Get.put(ProfileController());
  RxBool selectedSubscription = true.obs;
  RxBool isLoading = true.obs;
  SubscriptionPlanModel subscriptionPlanModel = SubscriptionPlanModel();
  SubscriptionPlanModel1 subscriptionPlanModel1 = SubscriptionPlanModel1();
  DashboardController dashboardController = Get.put(DashboardController());
  String name = '';
  String email = '';
  String id = '';
  String customerId = '';
  @override
  void initState() {
    getData();
    log(widget.fromScreen.toString());
    if (widget.fromScreen == "fromSetUpFarm" ||
        widget.fromScreen == "SubscriptionInActive" ||
        widget.fromScreen == "fromHomePage") {
      SubscriptionApi().getSubscriptionPlanApi().then((value) {
        subscriptionPlanModel1 = SubscriptionPlanModel1.fromJson(value.data);
        isLoading.value = false;
      });
      subscriptionPlanModel = SubscriptionPlanModel(data: [
        SubscriptionData(plan: false),
        SubscriptionData(plan: false),
      ]);
    } else {
      SubscriptionApi().getSubscriptionPlanApi().then((value) {
        subscriptionPlanModel1 = SubscriptionPlanModel1.fromJson(value.data);

        if (widget.fromScreen != "fromSetUpFarm" &&
            widget.fromScreen != "SubscriptionInActive" &&
            widget.fromScreen != "fromHomePage") {
          SubscriptionApi().getSubscriptionData().then((value) {
            subscriptionPlanModel = SubscriptionPlanModel.fromJson(value.data);
            if (subscriptionPlanModel.data![0].plan!) {
              selectedSubscription.value = false;
            } else {
              selectedSubscription.value = true;
            }
            isLoading.value = false;
          });
        } else {
          subscriptionPlanModel = SubscriptionPlanModel(data: [
            SubscriptionData(plan: false),
            SubscriptionData(plan: false),
          ]);
        }
      });
    }

    super.initState();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    email = prefs.getString("email")!;
    id = prefs.getString("id")!;
    if (widget.fromScreen == "SubscriptionInActive" ||
        widget.fromScreen == "fromHomePage") {
      customerId = prefs.getString("customerId")!;
    }
  }

  buildprofilelogoutdialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logout (1)@2x.png",
                    width: 40.w,
                    height: 50.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to Logout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('accessToken', "");
                        await prefs.setString('token', "");
                        token = null;
                        Get.offAllNamed("/loginScreen");
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Subscription Plan",
            style: TextStyle(
              color: const Color(0XFF141414),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            (widget.fromScreen == "SubscriptionInActive" ||
                    widget.fromScreen == "fromSetUpFarm")
                ? InkWell(
                    onTap: () {
                      buildprofilelogoutdialog(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Logout",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  )
                : SizedBox(),
          ],
          leading: widget.fromScreen == "fromSetUpFarm" ||
                  widget.fromScreen == "SubscriptionInActive"
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      radius: 20.h,
                      backgroundColor: const Color(0XFFF1F1F1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.h,
                            color: const Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        body: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttoncolour,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizedBoxHeight(20.h),
                        Image.asset("assets/images/subscription_image.png"),
                        sizedBoxHeight(20.h),
                        Obx(
                          () => Container(
                            margin: const EdgeInsets.all(16),
                            height: Get.height / 2.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: const Color(0xFF7BD47B)),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                !subscriptionPlanModel.data![1].plan!
                                    ? (subscriptionPlanModel.data![0].plan! ||
                                            subscriptionPlanModel
                                                .data![1].plan!)
                                        ? const SizedBox()
                                        : Container(
                                            height: selectedSubscription.value
                                                ? 130.h
                                                : 65.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0xFF7BD47B)),
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  selectedSubscription.value
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment
                                                          .center,
                                              children: [
                                                SizedBox(
                                                  height:
                                                      selectedSubscription.value
                                                          ? 10
                                                          : 0,
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            selectedSubscription
                                                                .value = true;
                                                          },
                                                          child: Container(
                                                            width: 31,
                                                            height: 31,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: selectedSubscription
                                                                      .value
                                                                  ? const Color(
                                                                      0xFF008000)
                                                                  : Colors
                                                                      .white,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: const Color(
                                                                      0xFF7BD47B)),
                                                            ),
                                                            child: selectedSubscription
                                                                    .value
                                                                ? const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )
                                                                : const SizedBox(),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          subscriptionPlanModel1
                                                              .data![1]
                                                              .description!,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    // Container(
                                                    //   height: 35.h,
                                                    //   padding: EdgeInsets.symmetric(
                                                    //       horizontal: 10),
                                                    //   decoration: BoxDecoration(
                                                    //       borderRadius:
                                                    //           BorderRadius.circular(4),
                                                    //       color: Color(0xFFE3FFE9)),
                                                    //   child: Center(
                                                    //       child: Text(
                                                    //     "-25% Off",
                                                    //     style: GoogleFonts.montserrat(
                                                    //       fontSize: 16.sp,
                                                    //       fontWeight: FontWeight.w500,
                                                    //     ),
                                                    //   )),
                                                    // )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      selectedSubscription.value
                                                          ? 10
                                                          : 0,
                                                ),
                                                selectedSubscription.value
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  "€${subscriptionPlanModel1.data![1].monthlyFee!}",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                color: AppColors
                                                                    .buttoncolour,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                  text: '/year',
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    color: AppColors
                                                                        .buttoncolour,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          )
                                    : Container(
                                        height: selectedSubscription.value
                                            ? 150.h
                                            : 65.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xFF7BD47B)),
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              selectedSubscription.value
                                                  ? MainAxisAlignment.start
                                                  : MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: selectedSubscription.value
                                                  ? 10
                                                  : 0,
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        selectedSubscription
                                                            .value = true;
                                                      },
                                                      child: Container(
                                                        width: 31,
                                                        height: 31,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              selectedSubscription
                                                                      .value
                                                                  ? const Color(
                                                                      0xFF008000)
                                                                  : Colors
                                                                      .white,
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color(
                                                                  0xFF7BD47B)),
                                                        ),
                                                        child: selectedSubscription
                                                                .value
                                                            ? const Center(
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      subscriptionPlanModel1
                                                          .data![1]
                                                          .description!,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: selectedSubscription.value
                                                  ? 10
                                                  : 0,
                                            ),
                                            selectedSubscription.value
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              "€${subscriptionPlanModel1.data![1].monthlyFee!}",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color: AppColors
                                                                .buttoncolour,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '/year',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                color: AppColors
                                                                    .buttoncolour,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            subscriptionPlanModel.data![1].plan!
                                                ? Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            Colors.redAccent),
                                                    child: Text(
                                                      "Next Payment Date : ${subscriptionPlanModel.data![1].nextPaymentDate!.split(" ")[0]}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                const SizedBox(
                                  height: 13,
                                ),
                                !subscriptionPlanModel.data![0].plan!
                                    ? (subscriptionPlanModel.data![0].plan! ||
                                            subscriptionPlanModel
                                                .data![1].plan!)
                                        ? const SizedBox()
                                        : Container(
                                            height: !selectedSubscription.value
                                                ? 130.h
                                                : 65.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0xFF7BD47B)),
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  !selectedSubscription.value
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment
                                                          .center,
                                              children: [
                                                SizedBox(
                                                  height: !selectedSubscription
                                                          .value
                                                      ? 10
                                                      : 0,
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        selectedSubscription
                                                            .value = false;
                                                      },
                                                      child: Container(
                                                        width: 31,
                                                        height: 31,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              !selectedSubscription
                                                                      .value
                                                                  ? const Color(
                                                                      0xFF008000)
                                                                  : Colors
                                                                      .white,
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color(
                                                                  0xFF7BD47B)),
                                                        ),
                                                        child: !selectedSubscription
                                                                .value
                                                            ? const Center(
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      subscriptionPlanModel1
                                                          .data![0]
                                                          .description!,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: !selectedSubscription
                                                          .value
                                                      ? 10
                                                      : 0,
                                                ),
                                                !selectedSubscription.value
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  "€${subscriptionPlanModel1.data![0].monthlyFee!}",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                color: AppColors
                                                                    .buttoncolour,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                  text: '/mo',
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    color: AppColors
                                                                        .buttoncolour,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // RichText(
                                                          //   text: TextSpan(
                                                          //     text:
                                                          //         "€${(double.parse(subscriptionPlanModel1.data![0].monthlyFee!) / 30).toStringAsFixed(2)}",
                                                          //     style: GoogleFonts
                                                          //         .montserrat(
                                                          //       color: const Color(
                                                          //           0xFF141414),
                                                          //       fontSize: 22,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .w500,
                                                          //     ),
                                                          //     children: <TextSpan>[
                                                          //       TextSpan(
                                                          //         text: '/day',
                                                          //         style: GoogleFonts
                                                          //             .montserrat(
                                                          //           color: const Color(
                                                          //               0xFF141414),
                                                          //           fontSize:
                                                          //               16,
                                                          //           fontWeight:
                                                          //               FontWeight
                                                          //                   .w500,
                                                          //         ),
                                                          //       ),
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                        ],
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          )
                                    : Container(
                                        height: !selectedSubscription.value
                                            ? 150.h
                                            : 65.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xFF7BD47B)),
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              !selectedSubscription.value
                                                  ? MainAxisAlignment.start
                                                  : MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:
                                                  !selectedSubscription.value
                                                      ? 10
                                                      : 0,
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    selectedSubscription.value =
                                                        false;
                                                  },
                                                  child: Container(
                                                    width: 31,
                                                    height: 31,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          !selectedSubscription
                                                                  .value
                                                              ? const Color(
                                                                  0xFF008000)
                                                              : Colors.white,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFF7BD47B)),
                                                    ),
                                                    child: !selectedSubscription
                                                            .value
                                                        ? const Center(
                                                            child: Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  subscriptionPlanModel
                                                      .data![0].description!,
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  !selectedSubscription.value
                                                      ? 10
                                                      : 0,
                                            ),
                                            !selectedSubscription.value
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              "€${subscriptionPlanModel1.data![0].monthlyFee!}",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color: AppColors
                                                                .buttoncolour,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '/mo',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                color: AppColors
                                                                    .buttoncolour,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            subscriptionPlanModel.data![0].plan!
                                                ? Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            Colors.redAccent),
                                                    child: Text(
                                                      "Next Payment Date : ${subscriptionPlanModel.data![0].nextPaymentDate!.split(" ")[0]}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Select the right plan according your requirements. You can always upgrade or downgrade later.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        sizedBoxHeight(20.h),
                        InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              var result = await Get.to(WebViewSubscription(
                                  id: id,
                                  token: prefs
                                      .getString('accessToken')
                                      .toString()));
                              if (result != null && result) {
                                log("THIS ==> ${widget.fromScreen!}");
                                isLoading.value = true;
                                SubscriptionApi()
                                    .getSubscriptionPlanApi()
                                    .then((value) {
                                  subscriptionPlanModel1 =
                                      SubscriptionPlanModel1.fromJson(
                                          value.data);

                                  SubscriptionApi()
                                      .getSubscriptionData()
                                      .then((value) async {
                                    subscriptionPlanModel =
                                        SubscriptionPlanModel.fromJson(
                                            value.data);
                                    if (subscriptionPlanModel.data![0].plan!) {
                                      selectedSubscription.value = false;
                                    } else {
                                      selectedSubscription.value = true;
                                    }
                                    isLoading.value = false;
                                    if (subscriptionPlanModel.data![0].plan! ||
                                        subscriptionPlanModel.data![1].plan!) {
                                      if (widget.fromScreen ==
                                          "fromSetUpFarm") {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        Get.offAllNamed('/letsSetUpYourFarm',
                                            arguments: {
                                              'id': prefs
                                                  .getString("id")
                                                  .toString(),
                                            });
                                      } else if (widget.fromScreen ==
                                              "SubscriptionInActive" ||
                                          widget.fromScreen == "fromHomePage") {
                                        Get.offAndToNamed('/sideMenu');
                                      }
                                    }
                                  });
                                });
                              }
                            },
                            child: customButtonCurve(
                                bgColor: (subscriptionPlanModel
                                            .data![0].plan! ||
                                        subscriptionPlanModel.data![1].plan!)
                                    ? Colors.red
                                    : AppColors.buttoncolour,
                                text: (subscriptionPlanModel.data![0].plan! ||
                                        subscriptionPlanModel.data![1].plan!)
                                    ? "Cancel Subscription"
                                    : 'Activate Subscription')),
                        sizedBoxHeight(25.h),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // Stripe payment
  Future<void> init() async {
    Map<String, dynamic>? customer;
    if (widget.fromScreen != "SubscriptionInActive" ||
        widget.fromScreen != "fromHomePage") {
      if (subscriptionPlanModel.data![0].customerId == null) {
        customer = await createCustomer();
        customerId = customer["id"];
      }
    }

    Map<String, dynamic> paymentIntent = await createPaymentIntent(
      widget.fromScreen == "SubscriptionInActive" ||
              widget.fromScreen == "fromHomePage"
          ? customerId
          : subscriptionPlanModel.data![0].customerId ?? customer!['id'],
    );
    await createCreditCard(
        widget.fromScreen == "SubscriptionInActive" ||
                widget.fromScreen == "fromHomePage"
            ? customerId
            : subscriptionPlanModel.data![0].customerId ?? customer!['id'],
        paymentIntent['client_secret']);
    Map<String, dynamic> customerPaymentMethods =
        await getCustomerPaymentMethods(
      widget.fromScreen == "SubscriptionInActive" ||
              widget.fromScreen == "fromHomePage"
          ? customerId
          : subscriptionPlanModel.data![0].customerId ?? customer!['id'],
    );

    await createSubscription(
      widget.fromScreen == "SubscriptionInActive" ||
              widget.fromScreen == "fromHomePage"
          ? customerId
          : subscriptionPlanModel.data![0].customerId ?? customer!['id'],
      customerPaymentMethods['data'][0]['id'],
    );
  }

  // Create Customer
  Future<Map<String, dynamic>> createCustomer() async {
    final customerCreationResponse = await apiService(
      endpoint: 'customers',
      requestMethod: ApiServiceMethodType.post,
      requestBody: {
        'name': widget.fromScreen == "fromSetUpFarm"
            ? name
            : profileController.profileInfoModel.value.data!.userName,
        'email': widget.fromScreen == "fromSetUpFarm"
            ? email
            : profileController.profileInfoModel.value.data!.emailAddress,
      },
    );

    return customerCreationResponse!;
  }

  //setup payment intent
  Future<Map<String, dynamic>> createPaymentIntent(String customerId) async {
    final paymentIntentCreationResponse = await apiService(
      requestMethod: ApiServiceMethodType.post,
      endpoint: 'setup_intents',
      requestBody: {
        'customer': customerId,
        'automatic_payment_methods[enabled]': 'true',
      },
    );

    return paymentIntentCreationResponse!;
  }

  //create credit card
  Future<void> createCreditCard(
    String customerId,
    String paymentIntentClientSecret,
  ) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        primaryButtonLabel: !selectedSubscription.value
            ? 'Subscribe \$${subscriptionPlanModel1.data![0].monthlyFee}'
            : 'Subscribe \$${subscriptionPlanModel1.data![1].monthlyFee}',
        style: ThemeMode.dark,
        merchantDisplayName: 'Farm Feeders',
        customerId: customerId,
        setupIntentClientSecret: paymentIntentClientSecret,
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  }

  //get customer payment method
  Future<Map<String, dynamic>> getCustomerPaymentMethods(
    String customerId,
  ) async {
    final customerPaymentMethodsResponse = await apiService(
      endpoint: 'customers/$customerId/payment_methods',
      requestMethod: ApiServiceMethodType.get,
    );

    return customerPaymentMethodsResponse!;
  }

  // create subscription
  Future<void> createSubscription(
    String customerId,
    String paymentId,
  ) async {
    try {
      Utils.loader();
      final requestResponse = await http.post(
        Uri.parse('https://api.stripe.com/v1/subscriptions'),
        headers: requestHeaders,
        body: {
          'customer': customerId,
          'items[0][price]': subscriptionPlanModel.data![0].plan!
              ? subscriptionPlanModel1.data![0].stripePriceId
              : subscriptionPlanModel1.data![1].stripePriceId,
          'default_payment_method': paymentId,
          "metadata[userId]": widget.fromScreen == "fromSetUpFarm" ||
                  widget.fromScreen == "SubscriptionInActive" ||
                  widget.fromScreen == "fromHomePage"
              ? id
              : profileController.profileInfoModel.value.data!.id!.toString(),
          "metadata[planId]": selectedSubscription.value ? "8" : "7",
        },
      );
      if (requestResponse.statusCode == 200 ||
          requestResponse.statusCode == 201 ||
          requestResponse.statusCode == 202) {
        Get.back();
        isLoading.value = true;
        Future.delayed(const Duration(seconds: 2), () async {
          if (widget.fromScreen == "fromSetUpFarm") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Get.offAllNamed('/letsSetUpYourFarm', arguments: {
              'id': prefs.getString("id").toString(),
            });
          } else if (widget.fromScreen == "SubscriptionInActive") {
            Get.offAndToNamed('/sideMenu');
          } else {
            SubscriptionApi().getSubscriptionPlanApi().then((value) {
              subscriptionPlanModel1 =
                  SubscriptionPlanModel1.fromJson(value.data);
              SubscriptionApi().getSubscriptionData().then((value) async {
                subscriptionPlanModel =
                    SubscriptionPlanModel.fromJson(value.data);

                isLoading.value = false;
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setString('loginStatus', "");
                if (widget.fromScreen == "fromHomePage") {
                  Get.offAndToNamed('/sideMenu');
                }
                setState(() {});
              });
            });
          }
        });
      }
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  //delete Subscription
  Future<void> deleteSubscription(
    String subscriptionid,
  ) async {
    try {
      final requestResponse = await http.delete(
        Uri.parse('https://api.stripe.com/v1/subscriptions/$subscriptionid'),
        headers: requestHeaders,
      );
      if (requestResponse.statusCode == 200 ||
          requestResponse.statusCode == 201 ||
          requestResponse.statusCode == 202) {
        isLoading.value = true;
        Future.delayed(const Duration(seconds: 2), () {
          SubscriptionApi().getSubscriptionPlanApi().then((value) {
            subscriptionPlanModel1 =
                SubscriptionPlanModel1.fromJson(value.data);
            SubscriptionApi().getSubscriptionData().then((value) {
              subscriptionPlanModel =
                  SubscriptionPlanModel.fromJson(value.data);

              isLoading.value = false;
              setState(() {});
            });
          });
        });
      }
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  Widget rowWidget(String txt) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                sizedBoxHeight(5.h),
                SvgPicture.asset('assets/images/checkCircle.svg'),
              ],
            ),
            sizedBoxWidth(15.w),
            Flexible(child: textBlack20(txt))
          ],
        ),
        sizedBoxHeight(20.h)
      ],
    );
  }
}
