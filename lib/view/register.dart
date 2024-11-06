import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/view_models/RegisterAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

ScrollController? controller;
ScrollController? _scrollviewcontroller;
String? dateregistercontroller;

String? _password;

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? _selectedDate;

//  void _submit() {
  //   final FormState? form = _formKey.currentState;
  //   if (form != null && form.validate()) {
  //     form.save();

  //     // Do something with the user credentials, such as login to the backend
  //     // server and navigate to the home screen.
  //     Get.toNamed("/verifyYourIdentity");
  //   }
  // }

  NetworkApiServices networkApiServices = NetworkApiServices();
  _registercheck() async {
    final isValid = _formKey.currentState?.validate();
     SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('accessToken');

      String? playerId = OneSignal.User.pushSubscription.id;
      if (playerId != null) {
        print("Directly fetched Player ID -> $playerId");

        await prefs.setString("playerId", playerId);
      }
    if (isValid!) {
      Utils.loader();
      Map<String, String> updata = {
        "name": nameController.text,
        "dob": dateController.text.toString(),
        "phone_number": phoneController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "c_password": cpasswordController.text,
        "player_id": prefs.getString('playerId')!,
      };
      final resp = await RegisterAPI(updata).registerApi();
      Get.back();
      if (resp.status == ResponseStatus.SUCCESS) {
        int? id = resp.data['data']['id'];
        Get.toNamed('/verifyYourIdentity',
            arguments: {'id': id, 'phonenumber': emailController.text});
        nameController.clear();
        dateController.clear();
        phoneController.clear();
        emailController.clear();
        passwordController.clear();
        cpasswordController.clear();
      } else if (resp.status == ResponseStatus.PRIVATE) {
        String? message = resp.data['message'];
        utils.showToast("$message");
      } else {
        utils.showToast(resp.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])(?=.{8,})',
    );
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
                  height: 250,
                  color: const Color(0xFF0E5F02),
                  child: Center(
                    child: Image.asset(
                      "assets/grass.png",
                      height: 0.297.sh,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: const Color(0xFF0E5F02),
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
                                textEditingController: nameController,
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
                              CustomTextFormField(
                                onTap: () {
                                  _presentDatePicker();
                                },
                                readonly: true,
                                textEditingController: dateController,
                                leadingIcon: SvgPicture.asset(
                                    "assets/images/calender.svg"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter date of birth';
                                  }

                                  // v2 = true;
                                  return null;
                                },
                                hintText: "",
                                validatorText: "",
                                //  isInputPassword: true,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     _presentDatePicker();
                              //   },
                              //   child: Container(
                              //     height: 60.h,
                              //     width: double.infinity,
                              //     decoration: BoxDecoration(
                              //       color: Color(0xFFF1F1F1),
                              //       border: Border.all(
                              //         color: Color(0xffF1F1F1),
                              //       ),
                              //       borderRadius: BorderRadius.circular(10.r),
                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 14.0),
                              //       child: Row(
                              //         children: [
                              //           Row(
                              //             children: [
                              //               SvgPicture.asset(
                              //                   "assets/images/calender.svg"),
                              //               sizedBoxWidth(10.w)
                              //             ],
                              //           ),
                              //           Row(
                              //             children: [
                              //               sizedBoxWidth(20.w),
                              //               Text(
                              //                 _selectedDate == null
                              //                     ? ''
                              //                     : '$dateregistercontroller',
                              //                 style: TextStyle(
                              //                     color: Colors.black),
                              //               ),
                              //             ],
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                                textEditingController: phoneController,
                                texttype: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(9),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                leadingIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset("assets/images/phone.svg"),
                                    sizedBoxWidth(5.w),
                                    Text(
                                      "+353",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                    )
                                  ],
                                ),
                                hintText: "",
                                validator: (value) {
                                  if (value == value.isEmpty) {
                                    return 'Mobile number is required';
                                  } else if (!value
                                      .toString()
                                      .startsWith("8")) {
                                    return 'Enter a valid mobile number starting with 8';
                                  } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{9}$)')
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
                                textEditingController: emailController,
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
                              textBlack16W5000("Password"),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                textEditingController: passwordController,
                                leadingIcon: SvgPicture.asset(
                                    "assets/images/password.svg"),
                                hintText: "",
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (!passwordRegex.hasMatch(value!)) {
                                    return 'Password must be at least 8 characters long, '
                                        'include one uppercase letter, one lowercase letter, '
                                        'one number, and one special character.';
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
                                textEditingController: cpasswordController,
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
                                _registercheck();
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
    DateTime eighteenYearsAgo =
        DateTime.now().subtract(const Duration(days: 365 * 18));
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(1922),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.buttoncolour,
                onPrimary: AppColors.white,
                onSurface: Colors.blueAccent,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.buttoncolour,
                ),
              ),
            ),
            child: child!);
      },
    ).then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return setState(() {
          dateController.text = '';
        });
      }
      if (pickedDate.isBefore(eighteenYearsAgo)) {
        setState(() {
          _selectedDate = pickedDate;
          dateController.text =
              "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Age Restriction"),
              content: const Text("Sorry, you must be above 18 years age"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
