import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentSuccessfull extends StatefulWidget {
  const PaymentSuccessfull({super.key});

  @override
  State<PaymentSuccessfull> createState() => _PaymentSuccessfullState();
}

class _PaymentSuccessfullState extends State<PaymentSuccessfull> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed("/sideMenu");

      // showDialog(
      //     context: context,
      //     builder: (context) => addCommunityDailog());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            sizedBoxHeight(80.h),
            SvgPicture.asset("assets/images/subscriptiondone.svg"),
            sizedBoxHeight(53.h),
            textBlack131313_28MediumCenter(
                'You have successfully set up your farm'),
            sizedBoxHeight(20.h),
            textBlack2C2C2C_20Center(
                'This screen will be auto redirected to your Farm Dashboard.')
          ],
        ),
      ),
    );
  }

  Widget addCommunityDailog() {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 25.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         Get.back();
                  //       },
                  //       child: Icon(
                  //         Icons.close,
                  //         size: 30.h,
                  //         color: AppColors.grey4D4D4D,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  sizedBoxHeight(65.h),
                  textBlack25W600Mon("Thank You!"),
                  sizedBoxHeight(15.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Thank you for creating an account with ',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Farm Flow.',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.buttoncolour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBoxHeight(40.h),
                  SizedBox(
                    width: 270.w,
                    child: CustomButton(
                        text: "Go To Dashboard",
                        onTap: () {
                          Get.offAllNamed("/sideMenu");
                        }),
                  ),
                  sizedBoxHeight(40.h),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: -60.h,
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: AppColors.buttoncolour,
                radius: 60.h,
                child: SvgPicture.asset(
                  "assets/images/wareHouse.svg",
                  height: 60.h,
                  width: 60.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
