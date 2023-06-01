import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
String? dateregistercontroller;
DateTime? _selectedDate;
String? _password;

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit() {
    final FormState? form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      // Do something with the user credentials, such as login to the backend
      // server and navigate to the home screen.
      Get.toNamed("/verifyYourIdentity");
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Full Name';
                                  }
                                  if (!RegExp(r'^[a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid name';
                                  }
                                  // v2 = true;
                                  return null;
                                },
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
                              GestureDetector(
                                onTap: () {
                                  _presentDatePicker();
                                },
                                child: Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F1F1),
                                    border: Border.all(
                                      color: Color(0xffF1F1F1),
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/images/calender.svg"),
                                            sizedBoxWidth(10.w)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            sizedBoxWidth(20.w),
                                            Text(
                                              _selectedDate == null
                                                  ? ''
                                                  : '$dateregistercontroller',
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                texttype: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                leadingIcon:
                                    SvgPicture.asset("assets/images/phone.svg"),
                                hintText: "",
                                validator: (value) {
                                  if (value == value.isEmpty) {
                                    return 'Mobile number is required';
                                  } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                                      .hasMatch(value)) {
                                    return 'Enter valid mobile number';
                                  }
                                  // v3 = true;
                                  return null;
                                },
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
                                texttype: TextInputType.emailAddress,
                                leadingIcon:
                                    SvgPicture.asset("assets/images/mail.svg"),
                                hintText: "",
                                validator: (value) {
                                  if (value == value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  // v4 = true;
                                  return null;
                                },
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
                                  "assets/images/location.svg",
                                ),
                                hintText: "",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter address';
                                  }
                                  return null;
                                },
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
                                validator: (value) {
                                  if (value == value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  _password = value;
                                  // v5 = true;
                                  return null;
                                },
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
                                validator: (value) {
                                  if (value == value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value != _password) {
                                    return 'Passwords do not match';
                                  }
                                  // v6 = true;
                                  return null;
                                },
                                hintText: "",
                                validatorText: "",
                                isInputPassword: true,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 55.h,
                          ),
                          CustomButton(
                              text: "Register",
                              onTap: () {
                                _submit();
                                //   Get.toNamed("/verifyYourIdentity");
                              }),
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
      ),
    );
  }

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1922),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return setState(() {
          dateregistercontroller = '';
        });
      }
      setState(() {
        _selectedDate = pickedDate;
        dateregistercontroller =
            "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
      });
    });
  }
}
