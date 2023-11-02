import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../Utils/colors.dart';
import '../Utils/custom_button.dart';
import '../Utils/sized_box.dart';
import '../Utils/texts.dart';
import '../common/custom_button_curve.dart';
import 'payment_successfull.dart';

class BasicSubscriptionPlan extends StatelessWidget {
  const BasicSubscriptionPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              sizedBoxHeight(30.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffE3FFE9),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xffE3FFE9))),
                child: SvgPicture.asset('assets/images/basePlan.svg'),
              ),
              sizedBoxHeight(10.h),
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
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
                              children: [
                                textBlack20Bold('€'),
                                sizedBoxHeight(40.h)
                              ],
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
                        customButtonCurve(
                          text: 'Get a 3 Months Trail',
                          onTap: () {
                            Get.offAll(() => const PaymentSuccessfull());

                            Future.delayed(Duration(seconds: 3), () {
                              showDialog(
                                  context: context,
                                  builder: (context) => addCommunityDailog());
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SvgPicture.asset('assets/images/Line.svg'),
                  SvgPicture.asset('assets/images/Line2.svg'),
                ],
              ),
              sizedBoxHeight(20.h)
            ],
          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          size: 30.h,
                          color: AppColors.grey4D4D4D,
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight(35.h),
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
                          // Get.to(() => SideMenu());
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

  Widget rowWidget(String txt) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                sizedBoxHeight(5.h),
                SvgPicture.asset('assets/images/check2.svg'),
              ],
            ),
            sizedBoxWidth(15.w),
            Flexible(child: textBlack18W7000(txt))
          ],
        ),
        sizedBoxHeight(20.h)
      ],
    );
  }
}
