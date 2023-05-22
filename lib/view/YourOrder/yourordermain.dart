import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Yourorder extends StatefulWidget {
  const Yourorder({super.key});

  @override
  State<Yourorder> createState() => _YourorderState();
}

class _YourorderState extends State<Yourorder> {
  TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Your Order",
                    style: TextStyle(
                      color: Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(29.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300.w,
                    height: 46.h,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0XFF141414),
                      ),
                      cursorColor: AppColors.black,
                      controller: textcontroller,
                      decoration: InputDecoration(
                        hintText: "Search here",
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0XFF141414),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            top: 15.h,
                            bottom: 15.h,
                          ),
                          child: SvgPicture.asset(
                            "assets/images/searchorder.svg",
                            width: 15.w,
                            height: 15.h,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0XFFF1F1F1),
                        contentPadding:
                            EdgeInsets.only(top: 11.h, bottom: 11.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(5.w),
                  Container(
                    width: 53.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      color: Color(0XFF0E5F02),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/order.svg",
                        width: 31.w,
                        height: 31.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBoxHeight(22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ongoing Order",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF141414)),
                      ),
                      Spacer(),
                      Text(
                        "See more",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF0E5F02)),
                      ),
                    ],
                  ),
                  sizedBoxHeight(15.h),
                  Container(
                    width: 358.w,
                    height: 221.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x48B9B9BE),
                              blurRadius: 8.0,
                              spreadRadius: 0)
                        ]),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.w, top: 12.h, bottom: 28.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30.h,
                                width: 123.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.h),
                                  color: Color.fromARGB(255, 236, 135, 135),
                                ),
                                child: Center(
                                  child: Text(
                                    "Arriving Soon",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color.fromARGB(255, 221, 89, 89),
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ),
                              sizedBoxHeight(18.h),
                              Image.asset(
                                "assets/images/yourorder2.png",
                                width: 105.w,
                                height: 98.h,
                              ),
                              sizedBoxHeight(7.h),
                              Text(
                                "Pre calve gain gold",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Color(0XFF141414)),
                              )
                            ],
                          ),
                        ),
                        sizedBoxWidth(29.w),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 19.h),
                        //   child: SvgPicture.asset(
                        //     "assets/images/orderlocate.svg",
                        //     width: 30.w,
                        //     height: 189.h,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: 19.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              status(),
                              DottedLine(
                                direction: Axis.vertical,
                                lineLength: 30,
                                lineThickness: 2.0,
                                dashLength: 4.0,
                                dashColor: Color(0XFF0E5F02),
                              ),
                              status(),
                              DottedLine(
                                direction: Axis.vertical,
                                lineLength: 30,
                                lineThickness: 2.0,
                                dashLength: 4.0,
                                dashColor: Color(0XFF0E5F02),
                              ),
                              status(),
                              DottedLine(
                                direction: Axis.vertical,
                                lineLength: 30,
                                lineThickness: 2.0,
                                dashLength: 4.0,
                                dashColor: Color(0XFF0E5F02),
                              ),
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    border: Border.all(
                                        color: AppColors.buttoncolour)),
                              )
                            ],
                          ),
                        ),
                        sizedBoxWidth(9.w),
                        Padding(
                          padding: EdgeInsets.only(top: 18.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ordered",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0XFF0E5F02),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/clock-svgrepo-com (1).svg",
                                    width: 6.w,
                                    height: 6.w,
                                  ),
                                  sizedBoxWidth(6.w),
                                  Text(
                                    "9.30 Pm, 10 May2023",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 8.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(14.h),
                              Text(
                                "Packed and ready",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0XFF0E5F02),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/clock-svgrepo-com (1).svg",
                                    width: 6.w,
                                    height: 6.w,
                                  ),
                                  sizedBoxWidth(6.w),
                                  Text(
                                    "9.30 Pm, 10 May2023",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 8.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(13.h),
                              Container(
                                height: 30.h,
                                width: 123.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.h),
                                  color: Color(0XFFF1F1F1),
                                ),
                                child: Center(
                                  child: Text(
                                    "Out for delivery",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0XFF0E5F02),
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ),
                              sizedBoxHeight(25.h),
                              Text(
                                "Delivered",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0XFF4D4D4D),
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget status() {
    return Column(
      children: [
        CircularPercentIndicator(
          center: CircleAvatar(
            child: SizedBox(),
            radius: 5.h,
            backgroundColor: AppColors.buttoncolour,
          ),
          radius: 10.h,
          lineWidth: 1,
          backgroundColor: Color(0XFFACC8A8),
          // progressColor: Color(0XFFACC8A8),
          //fillColor: Color(0XFFACC8A8),
        )
      ],
    );
  }

  // Widget statusRow(
  //   txt1,
  //   date,
  // ) {
  //   return Row(
  //     children: [
  //       CircularPercentIndicator(
  //         center: CircleAvatar(
  //           child: SizedBox(),
  //           radius: 10.h,
  //           backgroundColor: AppColors.buttoncolour,
  //         ),
  //         radius: 20.h,
  //         lineWidth: 1,
  //         fillColor: Color(0XFFACC8A8),
  //       ),
  //       sizedBoxWidth(15.w),
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             txt1,
  //             style: TextStyle(
  //               fontSize: 16.sp,
  //             ),
  //           ),
  //           Spacer(),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               SvgPicture.asset(
  //                 "assets/images/clock-svgrepo-com (1).svg",
  //                 width: 6.w,
  //                 height: 6.w,
  //               ),
  //               sizedBoxWidth(6.w),
  //               Text(
  //                 date,
  //                 style: TextStyle(
  //                   color: Color(0xff707070),
  //                   fontSize: 12.sp,
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       )
  //     ],
  //   );
  // }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = AppColors.buttoncolour
      ..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
