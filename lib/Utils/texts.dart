import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textBlack25W600Mon(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 25.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontFamily: "Montserrat"),
  );
}

Widget textBlack20W7000Mon(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 20.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w700,
        fontFamily: "Montserrat"),
  );
}

Widget textBlack16W5000(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.w500),
  );
}
