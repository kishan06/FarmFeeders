import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Reset Password"),

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
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset(
                    "assets/lotties/resetPassword.json",
                    width: 200.w,
                    height: 200.w,
                  ),
                  SizedBox(
                    width: 270.w,
                    child: textBlack16W5000(
                        "Your new password must be different from previously used password"
                        // "Please enter your phone number to receive a verification code.",
                        ),
                  ),
                  sizedBoxHeight(10.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textBlack16W5000("New Password"),
                  ),
                  sizedBoxHeight(8.h),
                  CustomTextFormField(
                    // leadingIcon:
                    //     SvgPicture.asset("assets/images/password.svg"),
                    hintText: "",
                    validatorText: "",
                    isInputPassword: true,
                  ),
                  sizedBoxHeight(13.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textBlack16W5000("Confirm Password"),
                  ),
                  sizedBoxHeight(8.h),
                  CustomTextFormField(
                    // leadingIcon:
                    //     SvgPicture.asset("assets/images/password.svg"),
                    hintText: "",
                    validatorText: "",
                    isInputPassword: true,
                  ),
                  sizedBoxHeight(70.h),
                  customButtonCurve(
                      text: "Next",
                      onTap: () {
                        // Get.toNamed("/verifyNumber");
                      }),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
