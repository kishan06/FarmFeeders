// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_print, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_import

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/controller/profile_controller.dart';
import 'package:farmfeeders/controller/set_farm.dart';
import 'package:farmfeeders/models/SetupFarmInfoModel/farm_info_model.dart';
import 'package:farmfeeders/resources/routes/route_name.dart';
import 'package:farmfeeders/view/Profile/personalinfo.dart';
import 'package:farmfeeders/view_models/SetupFarmInfoAPI.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/base_manager.dart';
import '../view_models/ProfileAPI.dart';

String? nameValue;
String? dateValue;
String? phoneValue;
String? emailValue;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  // bool editBool = false;

  final ProfileImageController editProfileImage =
      Get.put(ProfileImageController());
  SetFarm setFarm = Get.put(SetFarm());
  ProfileController profileController = Get.put(ProfileController());
  DashboardController dashboardController = Get.put(DashboardController());

  buildprofiledelete2dialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 16),
                backgroundColor:
                    Get.isDarkMode ? Colors.black : Color(0XFFFFFFFF),
                contentPadding: EdgeInsets.fromLTRB(57.w, 46.h, 57.w, 21.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Get.isDarkMode ? Colors.grey : Color(0XFFFFFFFF)),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //sizedBoxHeight(46.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Your Account is Deleted",
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

  buildprofiledeletedialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Get.isDarkMode ? Colors.black : Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/bin@2x.png",
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
                    "Are you sure you want to delete your account?",
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
                            border: Border.all(color: Color(0XFF0E5F02)),
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

  accessDeniedDialog(context, text) {
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
                    "assets/images/delete.png",
                    width: 80.w,
                    height: 80.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XFF0E5F02)),
                        borderRadius: BorderRadius.circular(10.h),
                        color: AppColors.buttoncolour),
                    child: Center(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildprofilelogoutdialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Get.isDarkMode ? Colors.black : Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Color(0XFFFFFFFF)),
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
                      onTap: () {
                        Get.toNamed("/loginScreen");
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
                            border: Border.all(color: Color(0XFF0E5F02)),
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: CircleAvatar(
                  //     radius: 20.h,
                  //     backgroundColor: Color(0XFFF1F1F1),
                  //     child: Center(
                  //       child: Padding(
                  //         padding: EdgeInsets.only(left: 8.w),
                  //         child: Icon(
                  //           Icons.arrow_back_ios,
                  //           size: 25.h,
                  //           color: Color(0XFF141414),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // sizedBoxWidth(15.w),
                  Text(
                    "My Profile",
                    style: TextStyle(
                      color: Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(43.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _formKey,
                  child:
                      // editBool
                      //     ? editProfile()
                      //     :
                      Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => ClipOval(
                              child: SizedBox.fromSize(
                                  size: Size.fromRadius(60.r),
                                  child: editProfileImage
                                              .profilePicPath.value !=
                                          ''
                                      ? Image(
                                          image: FileImage(File(editProfileImage
                                              .profilePicPath.value)),
                                          fit: BoxFit.cover,
                                          width: 200.w,
                                          height: 200.h,
                                        )
                                      : (profileController
                                                      .profileInfoModel
                                                      .value
                                                      .data!
                                                      .profilePhoto ==
                                                  null ||
                                              profileController
                                                  .profileInfoModel
                                                  .value
                                                  .data!
                                                  .profilePhoto!
                                                  .isEmpty)
                                          ? Image.asset(
                                              "assets/default_image.jpg")
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  "${ApiUrls.baseImageUrl}/${profileController.profileInfoModel.value.data!.profilePhoto}")),
                            ),
                          ),
                          sizedBoxWidth(18.w),
                          Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController
                                      .profileInfoModel.value.data!.userName!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    color: Color(0XFF141414),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                sizedBoxHeight(1.h),
                                Text(
                                  profileController.profileInfoModel.value.data!
                                      .phoneNumber!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF4D4D4D),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                Get.toNamed("personalinfo");
                                //  editBool = true;
                              });
                            }),
                            child: SvgPicture.asset(
                              'assets/images/profileEdit.svg',
                              width: 22.w,
                              height: 24.h,
                            ),
                          ),
                        ],
                      ),
                      sizedBoxHeight(36.w),
                      Text(
                        "Other Settings",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Color(0XFF141414),
                          fontFamily: "Montserrat",
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      sizedBoxHeight(25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0XFF59BD7D),
                            radius: 25.r,
                            child: SvgPicture.asset(
                              "assets/images/profileannual.svg",
                              width: 29.w,
                              height: 20.h,
                            ),
                          ),
                          sizedBoxWidth(24.w),
                          Text(
                            // "Animal Information",
                            'Livestock Information',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              FirebaseAnalytics.instance.logEvent(
                                name: 'view_livestock_info',
                                parameters: {
                                  'user_id': profileController
                                      .profileInfoModel.value.data!.id!,
                                },
                              );
                              SetupFarmInfoApi()
                                  .getLivestockTypeApi()
                                  .then((value) {
                                if (value.message == "Access Denied") {
                                  accessDeniedDialog(context, value.message);
                                } else {
                                  Get.toNamed(RouteName.liveStockInfoMain);
                                }
                              });
                            },
                            child: SvgPicture.asset(
                              'assets/images/profileEdit.svg',
                              width: 18.w,
                              height: 19.h,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.h,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0XFFEEC224),
                            radius: 25.r,
                            child: Image.asset(
                              "assets/images/tracking@2x.png",
                              width: 33.w,
                              height: 33.h,
                            ),
                          ),
                          sizedBoxWidth(24.w),
                          Text(
                            "Feed Information",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              FirebaseAnalytics.instance.logEvent(
                                name: 'view_feed_info',
                                parameters: {
                                  'user_id': profileController
                                      .profileInfoModel.value.data!.id!,
                                },
                              );
                              SetupFarmInfoApi()
                                  .getFeedLivestockApi()
                                  .then((value) {
                                if (value.message == "Access Denied") {
                                  accessDeniedDialog(context, value.message);
                                } else {
                                  Get.toNamed("/farmfeedtracker",
                                      arguments: {"fromScreeen": "inside"});
                                }
                              });
                            },
                            child: SvgPicture.asset(
                              'assets/images/profileEdit.svg',
                              width: 18.w,
                              height: 19.h,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.h,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0XFFC8C9CE),
                            radius: 25.r,
                            child: Image.asset(
                              "assets/images/farm@2x.png",
                              width: 27.w,
                              height: 27.h,
                            ),
                          ),
                          sizedBoxWidth(24.w),
                          Text(
                            "Farm Information",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              FirebaseAnalytics.instance.logEvent(
                                name: 'view_farm_info',
                                parameters: {
                                  'user_id': profileController
                                      .profileInfoModel.value.data!.id!,
                                 },
                              );
                              SetupFarmInfoApi().getFarmInfoApi().then((value) {
                                setFarm.isFarmInfoUpdate.value = true;
                                setFarm.farmInfoModel =
                                    FarmInfoModel.fromJson(value.data);
                                Get.toNamed("/farmsInfo");
                              });
                            },
                            child: SvgPicture.asset(
                              'assets/images/profileEdit.svg',
                              width: 18.w,
                              height: 19.h,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.h,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0XFF80B918),
                            radius: 25.r,
                            child: Image.asset(
                              "assets/images/connect@2x.png",
                              width: 30.w,
                              height: 30.h,
                            ),
                          ),
                          sizedBoxWidth(24.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Connect Code :",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600),
                              ),
                              sizedBoxHeight(1.h),
                              Text(
                                dashboardController.connectionCodeValue,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              FirebaseAnalytics.instance.logEvent(
                                name: 'share_connect_code',
                                parameters: {
                                  'user_id': profileController
                                      .profileInfoModel.value.data!.id!,
                                  'connect_code':
                                      dashboardController.connectionCodeValue,
                                },
                              );
                              Share.share(
                                  "Farmer Connect Code:\n${dashboardController.connectionCodeValue}");
                            },
                            child: SvgPicture.asset(
                              'assets/images/Communication - Share_Android.svg',
                              width: 23.w,
                              height: 23.h,
                            ),
                          ),
                        ],
                      ),
                      // Divider(
                      //   thickness: 1.h,
                      //   color: Colors.grey.shade200,
                      // ),
                      // sizedBoxHeight(13.h),
                      // GestureDetector(
                      //   onTap: () {
                      //     buildprofiledeletedialog(context);
                      //   },
                      //   child: Text(
                      //     "Delete Account",
                      //     style: TextStyle(
                      //         fontSize: 20.sp,
                      //         color: Color(0XFF0E5F02),
                      //         fontFamily: "Poppins",
                      //         fontWeight: FontWeight.w600),
                      //   ),
                      // ),
                      // sizedBoxHeight(12.h),
                      // GestureDetector(
                      //   onTap: () {
                      //     buildprofilelogoutdialog(context);
                      //   },
                      //   child: Text(
                      //     "Logout",
                      //     style: TextStyle(
                      //         fontSize: 20.sp,
                      //         color: Color(0XFF0E5F02),
                      //         fontFamily: "Poppins",
                      //         fontWeight: FontWeight.w600),
                      //   ),
                      // ),
                    ],
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
