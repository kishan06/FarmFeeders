import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Deliveredorder extends StatefulWidget {
  const Deliveredorder({super.key});

  @override
  State<Deliveredorder> createState() => _DeliveredorderState();
}

class _DeliveredorderState extends State<Deliveredorder> {
  buildDelivercalldialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Get.isDarkMode ? Colors.black : Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/contentcall.svg",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to call sales rep for querry",
                    // "Are you sure you want to call sales rep to cancel order?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontFamily: "Poppins"
                        // fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Get.toNamed("/cancelorder");
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildDelivereddialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Get.isDarkMode ? Colors.black : Color(0XFFFFFFFF),
            contentPadding: EdgeInsets.fromLTRB(43, 32, 43, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Image.asset(
                  "assets/images/connectperson.png",
                  width: 76.w,
                  height: 76.h,
                ),
                SizedBox(
                  height: 11.h,
                ),
                Text(
                  "Dan O Connors Limerick",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/call.svg",
                      width: 19.w,
                      height: 18.h,
                    ),
                    sizedBoxWidth(5.w),
                    Text(
                      "0614149881",
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontSize: 20.sp,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/images/locationconnect.svg",
                      width: 13.w,
                      height: 18.h,
                    ),
                    sizedBoxWidth(5.w),
                    Text(
                      "Newtown, Athenry",
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontSize: 20.sp,
                      ),
                    )
                  ],
                ),
                sizedBoxHeight(25.h),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    buildDelivercalldialog(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: AppColors.buttoncolour),
                    child: Center(
                      child: Text(
                        "Call",
                        style:
                            TextStyle(color: AppColors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w),
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
                    "Order Details",
                    style: TextStyle(
                      color: Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(9.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Order Id : 54545645465",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color(0XFF141414),
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight(10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 16.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/images/location.svg",
                            // width: 13.w, height: 17.h/
                          ),
                          // sizedBoxWidth(6.w),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivering To",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0XFF4D4D4D),
                                      fontFamily: "Poppins"),
                                ),
                                sizedBoxHeight(1.h),
                                Text(
                                  "22b baker street St, Marylebone, \nIreland",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0XFF141414),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0XFF0E5F02),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(17.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 78.w,
                            height: 93.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(
                                  color: Color(0XFF918E8E),
                                ),
                                color: AppColors.white),
                            child: Image.asset(
                              "assets/images/product1.png",
                              width: 76.w,
                              height: 71.h,
                            ),
                          ),
                          sizedBoxWidth(15.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pre calve gain gold",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF141414),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "Quantity : 5",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF4D4D4D),
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "€ 500",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(9.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 78.w,
                            height: 93.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(
                                  color: Color(0XFF918E8E),
                                ),
                                color: AppColors.white),
                            child: Image.asset(
                              "assets/images/product2.png",
                              width: 76.w,
                              height: 71.h,
                            ),
                          ),
                          sizedBoxWidth(15.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agrofeed Ruminant Feed",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF141414),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "Quantity : 5",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF4D4D4D),
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "€ 500",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(9.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 78.w,
                            height: 93.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(
                                  color: Color(0XFF918E8E),
                                ),
                                color: AppColors.white),
                            child: Image.asset(
                              "assets/images/product3.png",
                              width: 76.w,
                              height: 71.h,
                            ),
                          ),
                          sizedBoxWidth(15.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agrofeed Ruminant Feed",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF141414),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "Quantity : 5",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF4D4D4D),
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "€ 500",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(26.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0XFF4D4D4D),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Cow Feed",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0XFF4D4D4D),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "€ 5000",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxWidth(11.h),
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Text(
                              "(3 Items)",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0XFF4D4D4D),
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(13.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: 358.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0XFF918E8E),
                          ),
                          color: AppColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/downloadorder.svg",
                              // width: 12.w,
                              // height: 13.h,
                            ),
                            sizedBoxWidth(10.w),
                            Text(
                              "Download Invoice",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  color: Color(0XFF0E5F02),
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    sizedBoxHeight(22.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.w,
                      ),
                      child: Container(
                          // height: 60.h,
                          width: 346.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.h),
                              color: AppColors.buttoncolour),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/Group 56578@2x.png",
                                  width: 36.w,
                                  height: 36.h,
                                ),
                                sizedBoxWidth(14.w),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivered",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            // fontWeight: FontWeight.w600,
                                            color: Color(0XFFFFFFFF),
                                            fontFamily: "Poppins"),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Monday",
                                            style: TextStyle(
                                                color: Color(0xffE3E3E3),
                                                fontSize: 14.sp,
                                                fontFamily: "Poppins"),
                                          ),
                                          sizedBoxWidth(3.w),
                                          SvgPicture.asset(
                                            "assets/images/Ellipse 834.svg",
                                            width: 4.w,
                                            height: 4.h,
                                          ),
                                          sizedBoxWidth(5.w),
                                          Text(
                                            "Feb 6, 9.08 AM",
                                            style: TextStyle(
                                                color: Color(0xffE3E3E3),
                                                fontSize: 14.sp,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 51.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // sizedBoxHeight(8.h),
                              // status(),

                              // DottedLine(
                              //   direction: Axis.vertical,
                              //   lineLength: 47,
                              //   lineThickness: 2.0,
                              //   dashLength: 4.0,
                              //   dashColor: Color(0XFF0E5F02),
                              // ),
                              Dash(
                                  direction: Axis.vertical,
                                  length: 25,
                                  dashLength: 49,
                                  dashGap: 0,
                                  dashColor: Color(0XFF0E5F02)),

                              status(),
                              Dash(
                                  direction: Axis.vertical,
                                  length: 25,
                                  dashLength: 49,
                                  dashGap: 0,
                                  dashColor: Color(0XFF0E5F02)),
                              status(),
                              Dash(
                                  direction: Axis.vertical,
                                  length: 25,
                                  dashLength: 39,
                                  dashGap: 0,
                                  dashColor: Color(0XFF0E5F02)),
                              status(),
                            ],
                          ),
                          sizedBoxWidth(18.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Delivered",
                              //   style: TextStyle(
                              //       fontSize: 16.sp,
                              //       fontWeight: FontWeight.w600,
                              //       color: Color(0XFF141414),
                              //       fontFamily: "Poppins"),
                              // ),
                              // Text(
                              //   "Pending",
                              //   style: TextStyle(
                              //       fontSize: 14.sp,
                              //       color: Color(0XFF4D4D4D),
                              //       fontFamily: "Poppins"),
                              // ),
                              sizedBoxHeight(49.h),
                              Text(
                                "Out For Delivery",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tuesday",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                  sizedBoxWidth(3.w),
                                  SvgPicture.asset(
                                    "assets/images/dotimage.svg",
                                    width: 4.w,
                                    height: 4.h,
                                  ),
                                  sizedBoxWidth(5.w),
                                  Text(
                                    "Jan 30, 10.12 PM",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(15.h),
                              Text(
                                "Packed & Ready",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wednesday",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                  sizedBoxWidth(3.w),
                                  SvgPicture.asset(
                                    "assets/images/dotimage.svg",
                                    width: 4.w,
                                    height: 4.h,
                                  ),
                                  sizedBoxWidth(5.w),
                                  Text(
                                    "Jan 30, 10.12 PM",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "Ordered",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF141414),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Friday",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                  sizedBoxWidth(3.w),
                                  SvgPicture.asset(
                                    "assets/images/dotimage.svg",
                                    width: 4.w,
                                    height: 4.h,
                                  ),
                                  sizedBoxWidth(5.w),
                                  Text(
                                    "Jan 30, 10.12 PM",
                                    style: TextStyle(
                                        color: Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(27.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                          // height: 69.h,
                          width: 358.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0XffF1F1F1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 22.w, top: 13.h, bottom: 13.h),
                                child: Text(
                                  "How was your \nexperience?",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Color(0XFF141414),
                                      fontFamily: "SF Pro Display",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              sizedBoxWidth(49.w),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 13.h, bottom: 13.h),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/greensmiley.svg",
                                      width: 27.w,
                                      height: 27.h,
                                    ),
                                    sizedBoxHeight(1.h),
                                    Text(
                                      "It was great",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff0E5F02),
                                          fontFamily: "SF Pro Display"),
                                    )
                                  ],
                                ),
                              ),
                              sizedBoxWidth(25.w),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 13.h,
                                  bottom: 13.h,
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/redsmiley.svg",
                                      width: 27.w,
                                      height: 27.h,
                                    ),
                                    sizedBoxHeight(1.h),
                                    Text(
                                      "Not so great.",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xffCF0000),
                                          fontFamily: "SF Pro Display"),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    sizedBoxHeight(26.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GestureDetector(
                        onTap: () {
                          buildDelivereddialog(context);
                        },
                        child: Container(
                          width: 358.w,
                          // height: 108.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: AppColors.white,
                              border: Border.all(
                                color: Color(0XFFC5C5C5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF00000029),
                                    blurRadius: 6.0,
                                    spreadRadius: 0)
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, top: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5.h),
                                  child: SvgPicture.asset(
                                    "assets/images/orderquestion.svg",
                                    width: 53.w,
                                    height: 53.h,
                                  ),
                                ),

                                // CircleAvatar(
                                //   backgroundColor: Color(0XFFD9EFD5),
                                //   radius: 20.w,
                                //   child: CircleAvatar(
                                //     radius: 12.w,
                                //     backgroundColor: AppColors.buttoncolour,
                                //     child: SvgPicture.asset(
                                //       "assets/images/qyestion.svg",
                                //       width: 6.w,
                                //       height: 13.h,
                                //     ),
                                //   ),
                                // ),
                                sizedBoxWidth(10.w),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 13),
                                //   child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 9.h),
                                      child: Text(
                                        "Querry With This Order?",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Color(0XFF141414),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                    sizedBoxHeight(3.h),
                                    Container(
                                      height: 36.h,
                                      width: 213.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.h),
                                          color: AppColors.greyF2F4F5),
                                      child: Center(
                                        child: Text(
                                          "Contact Customer Service",
                                          style: TextStyle(
                                              color: AppColors.buttoncolour,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    sizedBoxHeight(18.h)
                                  ],
                                ),
                                //)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxHeight(14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: 358.w,
                        // height: 210.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0XFFF1F1F1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF00000029),
                                  blurRadius: 6.0,
                                  spreadRadius: 0)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: SvgPicture.asset(
                                  "assets/images/orderphone.svg",
                                  width: 53.w,
                                  height: 53.h,
                                ),
                              ),
                              sizedBoxWidth(10.w),
                              Padding(
                                padding: EdgeInsets.only(top: 14.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your Mobile Number",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Color(0XFF141414),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(8.h),
                                    Text(
                                      "we use your number to notify you \nabout order status and may call you \nto coordinate your delivery or pickup.",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0XFF141414),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(12.h),
                                    SizedBox(
                                      width: 213.w,
                                      // height: 33.h,
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextStyle(
                                            color: const Color(0xFF0E5F02),
                                            fontSize: 14.sp,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w600),
                                        readOnly: false,
                                        cursorColor: const Color(0xFF3B3F43),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          errorStyle:
                                              TextStyle(fontSize: 14.sp),
                                          isCollapsed: true,
                                          suffixIconConstraints:
                                              const BoxConstraints(),
                                          contentPadding: EdgeInsets.all(8.h),
                                          filled: true,
                                          fillColor: AppColors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            borderSide: BorderSide(
                                                color: Color(0xFF0E5F02),
                                                width: 1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            borderSide: BorderSide(
                                                color: Color(0xFF0E5F02),
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            borderSide: BorderSide(
                                                color: Color(0xFF0E5F02),
                                                width: 1),
                                          ),
                                          hintStyle: TextStyle(
                                              color: const Color(0xFF0E5F02),
                                              fontSize: 14.sp,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w600),
                                          hintText: "02658416399",
                                          suffixIcon: Padding(
                                            padding:
                                                EdgeInsets.only(right: 12.w),
                                            child: SvgPicture.asset(
                                                "assets/images/Complete.svg"),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                      ),
                                    ),
                                    sizedBoxHeight(14.h),
                                  ],
                                ),
                              ),
                              //)
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedBoxHeight(18.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: 358.w,
                        // height: 115.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0XFFF1F1F1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF00000029),
                                  blurRadius: 6.0,
                                  spreadRadius: 0)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: SvgPicture.asset(
                                  "assets/images/orderlist.svg",
                                  width: 53.w,
                                  height: 53.h,
                                ),
                              ),
                              sizedBoxWidth(10.w),
                              Padding(
                                padding: EdgeInsets.only(top: 14.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Summary",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Color(0XFF141414),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(8.h),
                                    Text(
                                      "Order g: 408-0073624-7437935",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0XFF141414),
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(7.h),
                                    Text(
                                      "Ordered February 5, 2023 8:01 pm",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0XFF141414),
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(18.h),
                                  ],
                                ),
                              ),
                              //)
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedBoxHeight(20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget status() {
    return CircleAvatar(
      backgroundColor: AppColors.buttoncolour,
      radius: 6.h,
    );
  }
}
