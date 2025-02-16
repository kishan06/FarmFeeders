import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/view/deleteAccount/deleteAccountScreen.dart';
import 'package:farmfeeders/view_models/LoginAPI.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/NotificationModel/notification_status_model.dart';
import 'view_models/NotificationAPI.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Add this method to log events
  void _logAnalyticsEvent(String eventName, [Map<String, Object>? parameters]) {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  bool state = false;
  bool fingerstate = false;
  @override
  void initState() {
    _logAnalyticsEvent('screen_view', {'screen_name': 'settings'});
    NotificationAPI().getNotificationStatus().then((value) {
      NotificationStatusModel notificationStatusModel =
          NotificationStatusModel.fromJson(value.data);
      if (notificationStatusModel.data!.isNotEmpty) {
        state = false;
      } else {
        state = true;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 18.w, top: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
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
                                color: const Color(0xFF141414),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(
                          color: const Color(0xFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    // Spacer(),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Get.toNamed("/notification");
                    //   },
                    //   child: SvgPicture.asset(
                    //     "assets/images/Notificationicon.svg",
                    //     width: 20.w,
                    //     height: 24.h,
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     shape: CircleBorder(),
                    //     // padding: EdgeInsets.all(10),
                    //     elevation: 2,
                    //     backgroundColor: AppColors.white,
                    //     shadowColor: Color(0xFF444444), // <-- Splash color
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Set Up Alert Notification",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 39.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.h),
                  color: AppColors.greyF1F1F1,
                ),

                margin: EdgeInsets.symmetric(horizontal: 16.w),
                // color: AppColors.greyF1F1F1,
                child: CustomListTile(
                  title: "Order Details And Alerts",
                  statecontroller: state,
                  //sizefactor: MediaQuery.of(context).size.width * 0.4,
                ),
              ),
              sizedBoxHeight(25.h),
              GestureDetector(
                onTap: () {
                  _logAnalyticsEvent('settings_faq_click');
                  Get.toNamed("/faq");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF0E5F02),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              sizedBoxHeight(12.h),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed("/SubscriptionPlan");
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16.w),
              //     child: Text(
              //       "Subscription Plans",
              //       style: TextStyle(
              //           fontSize: 20.sp,
              //           color: const Color(0XFF0E5F02),
              //           fontFamily: "Poppins",
              //           fontWeight: FontWeight.w600),
              //     ),
              //   ),
              // ),
              // sizedBoxHeight(12.h),
              GestureDetector(
                onTap: () {
                  _logAnalyticsEvent('settings_feedback_click');
                  Get.toNamed("/feedBack");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Feedback",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF0E5F02),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              sizedBoxHeight(12.h),
              GestureDetector(
                onTap: () {
                  _logAnalyticsEvent('settings_contact_click');
                  Get.toNamed("/contactus");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF0E5F02),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              sizedBoxHeight(12.h),
              GestureDetector(
                onTap: () {
                  _logAnalyticsEvent('settings_delete_account_click');
                  Get.to(() => const DeleteAccountScreen());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Delete Account",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF0E5F02),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              sizedBoxHeight(12.h),
              GestureDetector(
                onTap: () {
                  _logAnalyticsEvent('settings_logout_click');
                  buildprofilelogoutdialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF0E5F02),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildprofiledeletedialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    "mailto:assets/images/bin@2x.png",
                    width: 35.w,
                    height: 34.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to Request Deletion Of Your Account?",
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
                      onTap: () {
                        Navigator.pop(context);
                        buildprofiledelete2dialog(context);
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

  buildprofiledelete2dialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor:
                    Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
                contentPadding: EdgeInsets.fromLTRB(57.w, 46.h, 57.w, 21.h),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Get.isDarkMode
                          ? Colors.grey
                          : const Color(0XFFFFFFFF)),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //sizedBoxHeight(46.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Request Send To The Admin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    sizedBoxHeight(21.h),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/images/profilrcheck.svg",
                        width: 67.w,
                        height: 67.h,
                      ),
                    ),
                    // sizedBoxHeight(44.h)
                  ],
                ),
              ),
            ],
          );
        });
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
                        LoginAPI({}).logoutApi().then((value) async {
                          if (value.status == ResponseStatus.SUCCESS) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('accessToken', "");
                            await prefs.setString('token', "");
                            token = null;
                            Get.offAllNamed("/loginScreen");
                          }
                        });
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
}

class CustomListTile extends StatefulWidget {
  CustomListTile({
    super.key,
    required this.title,
    required this.statecontroller,
    this.addVideoPage = false,

    //required this.sizefactor
  });

  final String? title;
  bool statecontroller;
  bool addVideoPage;
  //double sizefactor;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.addVideoPage ? 0 : 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: 20.sp,
                // color: Color(0XFF4D4D4D),
              ),
            ),
            const Spacer(),
            FlutterSwitch(
              switchBorder: Border.all(
                strokeAlign: BorderSide.strokeAlignCenter,
                style: BorderStyle.solid,
                width: 1,
                color: const Color(0xffCCCCCC),
              ),
              width: 50.0,
              height: 25.0,
              toggleColor: const Color(0xFF0E5F02),
              activeColor: AppColors.white,
              inactiveColor: Colors.white,
              inactiveToggleColor: const Color(0xff686868),
              value: widget.statecontroller,
              onToggle: (val) {
                setState(() {
                  FirebaseAnalytics.instance.logEvent(
                      name: 'settings_notification_toggle',
                      parameters: {
                        'enabled': val,
                      });
                  widget.statecontroller = val;
                  NotificationAPI().notificationSettingsApi(3).then((value) {});
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
