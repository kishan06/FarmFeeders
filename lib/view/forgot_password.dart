
import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

                  Text("Forgot Password",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
              
            ],
          ),
        )
      ),
    );
  }
}