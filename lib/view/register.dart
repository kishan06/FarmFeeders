import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

ScrollController? controller;
ScrollController? _scrollviewcontroller;

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 250.h,
                color: Color(0xFF0E5F02),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      //  alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          left: -12 * fem,
                          top: -18 * fem,
                          child: SvgPicture.asset(
                            "assets/grass.svg",
                          ),
                        ),
                        Positioned(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),
                              Center(
                                child: Image.asset(
                                  "assets/logo.png",
                                  height: 200.h,
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFF0E5F02),
                child: Container(
                  // height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        textBlack25W600Mon("Register to get started"),
                        SizedBox(
                          height: 35.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Full Name"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              leadingIcon: SvgPicture.asset(
                                  "assets/images/profileimage.svg"),

                              hintText: "",
                              validatorText: "",
                              //  isInputPassword: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Date Of Birth"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              leadingIcon: SvgPicture.asset(
                                  "assets/images/calender.svg"),
                              hintText: "",
                              validatorText: "",
                              isInputPassword: false,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Contact Number"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              leadingIcon:
                                  SvgPicture.asset("assets/images/phone.svg"),
                              hintText: "",
                              validatorText: "",
                              isInputPassword: false,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Email Address"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              leadingIcon:
                                  SvgPicture.asset("assets/images/mail.svg"),
                              hintText: "",
                              validatorText: "",
                              isInputPassword: false,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Address"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              leadingIcon: SvgPicture.asset(
                                  "assets/images/location (2).svg"),
                              hintText: "",
                              validatorText: "",
                              isInputPassword: false,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Password"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              leadingIcon: SvgPicture.asset(
                                  "assets/images/password.svg"),
                              hintText: "",
                              validatorText: "",
                              isInputPassword: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Confirm Password"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              leadingIcon: SvgPicture.asset(
                                  "assets/images/password.svg"),
                              hintText: "",
                              validatorText: "",
                              isInputPassword: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 55.h,
                        ),
                        CustomButton(text: "Register",
                          onTap: (){
                            Get.toNamed("/verifyYourIdentity");
                          }
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already Have An Account? ",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/loginScreen");
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.buttoncolour,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
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
    );
  }
}
