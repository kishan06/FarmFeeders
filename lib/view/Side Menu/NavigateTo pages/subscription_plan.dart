import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    radius: 20.h,
                    backgroundColor: const Color(0XFFF1F1F1),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25.h,
                          color: const Color(0XFF141414),
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxWidth(15.w),
                Text(
                  "Subscription Plan",
                  style: TextStyle(
                    color: const Color(0XFF141414),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            sizedBoxHeight(20.h),
            Container(
              padding: EdgeInsets.only(
                  top: 20.h, left: 20.w, right: 20.w, bottom: 35.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xffC9E0FB))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textBlack141414_22w600('Basic Farmer Plan'),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [textBlack20Bold('€'), sizedBoxHeight(40.h)],
                      ),
                      textBlack60w600('99.9 '),
                      textBlack20Bold('/mo')
                    ],
                  ),
                  sizedBoxHeight(10.h),
                  rowWidget('Attractive Discounts on all Feed Orders'),
                  rowWidget('Feed Storage Tracking and Alerts'),
                  rowWidget('Feed Delivery Tracking'),
                  rowWidget('Connect with experts for assistance'),
                  rowWidget('Farm Hand Training: Videos and Notes'),
                  sizedBoxHeight(20.h),
                  customButtonCurve(text: 'Manage Subscription')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowWidget(String txt) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                sizedBoxHeight(5.h),
                SvgPicture.asset('assets/images/checkCircle.svg'),
              ],
            ),
            sizedBoxWidth(15.w),
            Flexible(child: textBlack20(txt))
          ],
        ),
        sizedBoxHeight(20.h)
      ],
    );
  }
}
