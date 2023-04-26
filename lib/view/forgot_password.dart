
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w,35.h,16.w,0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.h,
                    backgroundColor: AppColors.greyF1F1F1,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Icon(Icons.arrow_back_ios,
                          size: 25.h,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 15.w,
                  ),

                  textBlack20W7000Mon("Forgot Password")

                ],
              ),

              Lottie.asset("assets/lotties/forgotPassword.json",
                width: 250.w,
                height: 250.w
              ),

              SizedBox(
                width: 270.w,
                child: textBlack16W5000("Please enter your phone number to receive a verification code."),
              ),

              sizedBoxHeight(35.h),

              Align(
                alignment: Alignment.centerLeft,
                child: textBlack16W5000("Phone Number")
              )

              
              


              
            ],
          ),
        )
      ),
    );
  }
}