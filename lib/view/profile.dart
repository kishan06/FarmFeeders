// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_print, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_import

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/view/Profile/personalinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController datecontroller = TextEditingController();

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
  // bool editBool = false;

  final ProfileImageController editProfileImage =
      Get.put(ProfileImageController());

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
                                      : Image.asset(
                                          "assets/images/profile.png")),
                            ),
                          ),
                          sizedBoxWidth(18.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameValue == null || nameValue!.isEmpty
                                    ? 'Kevin'
                                    : '$nameValue',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: 'Poppins',
                                  color: Color(0XFF141414),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              sizedBoxHeight(1.h),
                              Text(
                                phoneValue == null || phoneValue!.isEmpty
                                    ? '0863621359'
                                    : '$phoneValue',
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
                            "Animal Information",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/images/profileEdit.svg',
                            width: 18.w,
                            height: 19.h,
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
                            "Farm Feed Tracker",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/images/profileEdit.svg',
                            width: 18.w,
                            height: 19.h,
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
                            "Farm Info",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/images/profileEdit.svg',
                            width: 18.w,
                            height: 19.h,
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
                                "DFE32FDDF4",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/images/Communication - Share_Android.svg',
                            width: 23.w,
                            height: 23.h,
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
