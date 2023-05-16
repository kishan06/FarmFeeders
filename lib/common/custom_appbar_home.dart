import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget customAppBarHome({required String text}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      children: [
        SizedBox(
          width: 40.w,
        ),
        textBlack20W7000Mon(text),
        Spacer(),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            radius: 20.h,
            backgroundColor: AppColors.greyF1F1F1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25.h,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            radius: 20.h,
            backgroundColor: AppColors.greyF1F1F1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25.h,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
