import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_button.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Utils/sized_box.dart';

class Reorderscreen extends StatefulWidget {
  const Reorderscreen(
      {Key? key,
      this.minValue = 0,
      this.maxValue = 10,
      this.minValue2 = 0,
      this.maxValue2 = 10
      //  this.onChanged
      })
      : super(key: key);
  // ({super.key});

  final int minValue;
  final int maxValue;
  final int minValue2;
  final int maxValue2;

  // final ValueChanged<int> onChanged;

  @override
  State<Reorderscreen> createState() => _ReorderscreenState();
}

class _ReorderscreenState extends State<Reorderscreen> {
  buildpricesdialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            // contentPadding: EdgeInsets.fromLTRB(48, 60, 47, 37),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Text(
                      "The price of some products may have increased!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                sizedBoxHeight(37.h),
                customButton(text: "View Order Details", onTap: () {}),
                sizedBoxHeight(60.h)
              ],
            ),
          ),
        ],
      ),
    );
  }

  int counter = 0;
  int counter2 = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
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
                      "Reorder",
                      style: TextStyle(
                        color: const Color(0XFF141414),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxHeight(20.h),
              Text(
                "1 items currently unavailable",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0XFF141414),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              ),
              sizedBoxHeight(18.h),
              Container(
                width: 358.w,
                // height: 124.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF1F1F1),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x0000001F),
                          // blurRadius: 2.0,
                          offset: Offset(0.0, 0.75),
                          spreadRadius: 2)
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 21.w, right: 24.w, top: 9.h, bottom: 11.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feedmix",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "Poppins"),
                          ),
                          sizedBoxHeight(5.h),
                          Text(
                            "Text of the printing and \ntypesetting",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xff141414),
                                fontFamily: "Poppins"),
                          ),
                          sizedBoxHeight(11.h),
                          Text(
                            "3 Hours ago",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff141414),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          )
                        ],
                      ),
                      sizedBoxWidth(58.w),
                      Image.asset(
                        "assets/images/whitereorder.png",
                        width: 71.w,
                        height: 130.h,
                      )
                    ],
                  ),
                ),
              ),
              sizedBoxHeight(47.h),
              Text(
                "My Carts (2 Items)",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"),
              ),
              sizedBoxHeight(18.h),
              Container(
                width: 358.w,
                height: 120.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF1F1F1),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x0000001F),
                          // blurRadius: 2.0,
                          offset: Offset(0.0, 0.75),
                          spreadRadius: 2)
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pre-Calver Gain Gold",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff141414),
                                fontFamily: "Poppins"),
                          ),
                          sizedBoxHeight(3.h),
                          Text(
                            "€ 500",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff141414),
                                fontFamily: "Poppins"),
                          ),
                          sizedBoxHeight(3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  "Qty: $counter",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              sizedBoxWidth(64.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter > widget.minValue) {
                                      counter--;
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                  "assets/images/minusbutton.svg",
                                  // width: 20.w,
                                  // height: 40.h,
                                ),
                              ),
                              sizedBoxWidth(12.w),
                              SizedBox(
                                width: 14.w,
                                child: Text(
                                  "$counter",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff141414),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              sizedBoxWidth(8.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter < widget.maxValue) {
                                      counter++;
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                  "assets/images/plusreorder.svg",
                                  // width: 20.w,
                                  // height: 40.h,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      sizedBoxWidth(70.w),
                      Image.asset(
                        "assets/images/redreorder.png",
                        // width: 49.w,
                        // height: 87.h,
                      )
                    ],
                  ),
                ),
              ),
              sizedBoxHeight(15.h),
              Container(
                width: 358.w,
                height: 120.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF1F1F1),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x0000001F),
                          // blurRadius: 2.0,
                          offset: Offset(0.0, 0.75),
                          spreadRadius: 2)
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 22.w, right: 8.w, top: 8.h, bottom: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Agrofeed Ruminant Feed",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff141414),
                                fontFamily: "Poppins"),
                          ),
                          sizedBoxHeight(3.h),
                          Text(
                            "€ 500",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff141414),
                                fontFamily: "Poppins"),
                          ),
                          sizedBoxHeight(3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  "Qty: $counter2",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              sizedBoxWidth(64.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter2 > widget.minValue2) {
                                      counter2--;
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                  "assets/images/minusbutton.svg",
                                  // width: 20.w,
                                  // height: 40.h,
                                ),
                              ),
                              sizedBoxWidth(12.w),
                              SizedBox(
                                width: 14.w,
                                child: Text(
                                  "$counter2",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff141414),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              sizedBoxWidth(8.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter2 < widget.maxValue2) {
                                      counter2++;
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                  "assets/images/plusreorder.svg",
                                  // width: 20.w,
                                  // height: 40.h,
                                ),
                              ),
                            ],
                          ),
                          //  Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       "Qty: 5",
                          //       style: TextStyle(
                          //           fontSize: 14.sp,
                          //           color: Color(0xff4D4D4D),
                          //           fontFamily: "Poppins"),
                          //     ),
                          //     sizedBoxWidth(74.w),
                          //     GestureDetector(
                          //       onTap: () {},
                          //       child: SvgPicture.asset(
                          //         "assets/images/minusbutton.svg",
                          //         // width: 20.w,
                          //         // height: 40.h,
                          //       ),
                          //     ),
                          //     sizedBoxWidth(8.w),
                          //     Text(
                          //       "0",
                          //       style: TextStyle(
                          //           fontSize: 14.sp,
                          //           color: Color(0xff141414),
                          //           fontFamily: "Poppins",
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //     sizedBoxWidth(8.w),
                          //     GestureDetector(
                          //       onTap: () {},
                          //       child: SvgPicture.asset(
                          //         "assets/images/plusreorder.svg",
                          //         // width: 20.w,
                          //         // height: 40.h,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      sizedBoxWidth(33.w),
                      Image.asset(
                        "assets/images/yellowreorder.png",
                        // width: 49.w,
                        // height: 87.h,
                      )
                    ],
                  ),
                ),
              ),
              sizedBoxHeight(52.h),
              customButtonCurve(
                  text: "Contact Sales Representative",
                  onTap: () {
                    buildpricesdialog(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
