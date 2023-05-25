import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Connectcode extends StatefulWidget {
  const Connectcode({super.key});

  @override
  State<Connectcode> createState() => _ConnectcodeState();
}

class _ConnectcodeState extends State<Connectcode> {
  String quote = "KEVIN63395";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      radius: 20.h,
                      backgroundColor: Color(0XFFF1F1F1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.h,
                            color: Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(15.w),
                  Text(
                    "Connection Code",
                    style: TextStyle(
                      color: Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(52.h),
            Text(
              "Connect to a Sales Rep by providing them with your Connection Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(0xff141414),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
            sizedBoxHeight(86.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Code !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(0xff141414),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            sizedBoxHeight(10.h),
            Container(
                height: 50.h,
                width: 358.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    color: Color(0xffF1F1F1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedBoxWidth(122.w),
                    Text(
                      quote,
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontFamily: "Poppins",
                        color: Color(0xff000000),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: quote)).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Content copied to clipboard")));
                          });
                          print("content copied");
                        },
                        child: SvgPicture.asset(
                          "assets/images/copy.svg",
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
