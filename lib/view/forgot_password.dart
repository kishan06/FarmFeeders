
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
                    radius: 15.h,
                    // backgroundColor: ,
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}