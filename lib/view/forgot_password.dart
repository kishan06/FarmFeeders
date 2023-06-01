import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

// sing
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Forgot Password"),

        // backgroundColor: Color(0xFFF5F8FA),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                key: _form,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      "assets/lotties/forgotPassword.json",
                      width: 200.w,
                      height: 200.w,
                    ),
              
                    SizedBox(
                      width: 270.w,
                      child: textBlack16W5000(
                        "Please enter your phone number to receive a verification code.",
                      ),
                    ),
              
                    sizedBoxHeight(35.h),
              
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textBlack16W5000("Phone Number"),
                    ),
              
                    sizedBoxHeight(8.h),
              
                    CustomTextFormField(
                        texttype: TextInputType.phone,
                        textEditingController: phoneController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter a Phone Number";
                          } else if (!RegExp(
                                  r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                              .hasMatch(value)) {
                            return "Please Enter a Valid Phone Number";
                          }
                          return null;
                        },
                        hintText: "Enter your Phone Number",
                        validatorText: "Enter your Phone Number"
                      ),
                    // Spacer(),
              
                    sizedBoxHeight(130.h),
              
                    customButtonCurve(
                        text: "Next",
                        onTap: () {
                          // Get.toNamed("/verifyNumber");
                          final isValid = _form.currentState?.validate();
                          if (isValid!) {
                            Get.toNamed("/verifyNumber",
                              arguments: phoneController.text
                            );
                          } 
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
