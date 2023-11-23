import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/models/OrderModel/orders_model.dart';
import 'package:farmfeeders/view_models/orderApi/order_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Yourorder extends StatefulWidget {
  const Yourorder({super.key});

  @override
  State<Yourorder> createState() => _YourorderState();
}

class _YourorderState extends State<Yourorder> {
  TextEditingController textcontroller = TextEditingController();
  RxBool isLoading = true.obs;
  OrdersModel ordersModel = OrdersModel();

  @override
  void initState() {
    OrderApi().getOrdersListApi().then((value) {
      ordersModel = OrdersModel.fromJson(value.data);
      isLoading.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  // sizedBoxWidth(5.w),
                  filter(),

                  // InkWell(
                  //   onTap: () {
                  //    filter();
                  //   },
                  //   child: Container(
                  //     width: 53.w,
                  //     height: 45.h,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.h),
                  //       color: Color(0XFF0E5F02),
                  //     ),
                  //     child: Center(
                  //       child: SvgPicture.asset(
                  //         "assets/images/order.svg",
                  //         width: 31.w,
                  //         height: 31.w,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                  Obx(
                    () => isLoading.value
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : ordersModel.data!.ongoingOrder == null
                            ? Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Center(
                                    child: Text(
                                  "No Ongoing Orders Right Now",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF141414)),
                                )),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Get.toNamed("/ongoingorder", arguments: {
                                    "id": ordersModel.data!.orderHeaderId!,
                                  });
                                },
                                child: Container(
                                  width: 358.w,
                                  height: 230.h,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
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
                                            left: 18.w,
                                            top: 12.h,
                                            bottom: 28.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30.h,
                                              width: 123.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.h),
                                                color: Color(0XFFFFB7B7),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Arriving Soon",
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Color(0XFFAC2A33),
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizedBoxHeight(18.h),
                                            Image.network(
                                              "${ApiUrls.baseImageUrl}/${ordersModel.data!.ongoingOrder!.smallImageUrl}",
                                              width: 105.w,
                                              height: 98.h,
                                            ),
                                            sizedBoxHeight(7.h),
                                            Text(
                                              ordersModel
                                                  .data!.ongoingOrder!.title!,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Color(0XFF141414)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColors.buttoncolour,
                                              radius: 11.w,
                                              child: CircleAvatar(
                                                radius: 9.w,
                                                backgroundColor:
                                                    AppColors.pistaE3FFE9,
                                                child: SvgPicture.asset(
                                                    "assets/images/delivery.svg"),
                                              ),
                                            ),
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
                                                      color: AppColors
                                                          .buttoncolour)),
                                            )
                                          ],
                                        ),
                                      ),
                                      sizedBoxWidth(9.w),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ordered",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color(0XFF0E5F02),
                                                  fontFamily: "Poppins"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
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
                                            sizedBoxHeight(19.h),
                                            Container(
                                              height: 30.h,
                                              width: 123.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.h),
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
                                            sizedBoxHeight(29.h),
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
                                ),
                              ),
                  ),
                  sizedBoxHeight(19.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recurring Order",
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
                  sizedBoxHeight(6.h),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/reorder");
                    },
                    child: Container(
                      width: 358.w,
                      // height: 123.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0XFF0000001F),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x48B9B9BE),
                              //  / blurRadius: 1.0,
                              offset: Offset(0.0, 0.75),
                              // spreadRadius: 0
                            )
                          ]),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              top: 14.h,
                              bottom: 24.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/product1.png",
                                  width: 80.w,
                                  height: 69.h,
                                ),
                                sizedBoxHeight(5.h),
                                Text(
                                  "Pre calve gain gold",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Color(0XFF141414),
                                      fontFamily: "Poppins"),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, top: 14.h, bottom: 4.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    "assets/images/product2.png",
                                    width: 80.w,
                                    height: 69.h,
                                  ),
                                ),
                                sizedBoxHeight(5.h),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Agrofeed \nRuminant Feed",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Color(0XFF141414),
                                        fontFamily: "Poppins"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w,
                                top: 14.h,
                                bottom: 24.h,
                                right: 16.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/product3.png",
                                  width: 80.w,
                                  height: 69.h,
                                ),
                                sizedBoxHeight(5.h),
                                Text(
                                  "Medow HPC 64",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Color(0XFF141414),
                                      fontFamily: "Poppins"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight(16.h),
                  Text(
                    "Past",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF141414)),
                  ),
                  sizedBoxHeight(6.h),
                  Text(
                    "Order delivered on 6 Feb 2023 at 09.41",
                    style: TextStyle(fontSize: 12.sp, color: Color(0XFF6D6D6D)),
                  ),
                  sizedBoxHeight(7.h),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/deliveredorder");
                    },
                    child: Container(
                      width: 358.w,
                      // height: 125.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0XFF0000001F),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x48B9B9BE),
                              //  / blurRadius: 1.0,
                              offset: Offset(0.0, 0.75),
                              // spreadRadius: 0
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.w, top: 9.h, bottom: 18.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pre calve gain gold",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Color(0XFF141414),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                Text(
                                  "Cow feed",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Color(0XFF141414),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                sizedBoxHeight(8.h),
                                Container(
                                  height: 25.h,
                                  width: 91.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.h),
                                    color: AppColors.buttoncolour,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Reorder",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0XFFFFFFFF),
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // sizedBoxWidth(10.w),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 3),
                            child: Image.asset(
                              "assets/images/redfood.png",
                              width: 94.w,
                              height: 135.h,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight(28.h),
                  Text(
                    "Order delivered on 6 Feb 2023 at 09.41",
                    style: TextStyle(fontSize: 12.sp, color: Color(0XFF6D6D6D)),
                  ),
                  sizedBoxHeight(7.h),
                  Container(
                    width: 358.w,
                    // height: 125.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0XFF0000001F),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x48B9B9BE),
                            //  / blurRadius: 1.0,
                            offset: Offset(0.0, 0.75),
                            // spreadRadius: 0
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, top: 9.h, bottom: 18.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agrofeed Ruminant Feed",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0XFF141414),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              Text(
                                "Cow feed",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0XFF141414),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              sizedBoxHeight(8.h),
                              Container(
                                height: 25.h,
                                width: 91.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.h),
                                  color: AppColors.buttoncolour,
                                ),
                                child: Center(
                                  child: Text(
                                    "Reorder",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0XFFFFFFFF),
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // sizedBoxWidth(10.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 3),
                          child: Image.asset(
                            "assets/images/yellowfood.png",
                            width: 94.w,
                            height: 135.h,
                          ),
                        )
                      ],
                    ),
                  ),
                  sizedBoxHeight(28.h),
                  Text(
                    "Order delivered on 6 Feb 2023 at 09.41",
                    style: TextStyle(fontSize: 12.sp, color: Color(0XFF6D6D6D)),
                  ),
                  sizedBoxHeight(7.h),
                  Container(
                    width: 358.w,
                    // height: 125.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0XFF0000001F),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x48B9B9BE),
                            //  / blurRadius: 1.0,
                            offset: Offset(0.0, 0.75),
                            // spreadRadius: 0
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, top: 9.h, bottom: 18.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pre calve gain gold",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0XFF141414),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              Text(
                                "Cow feed",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0XFF141414),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              sizedBoxHeight(8.h),
                              Container(
                                height: 25.h,
                                width: 91.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.h),
                                  color: AppColors.buttoncolour,
                                ),
                                child: Center(
                                  child: Text(
                                    "Reorder",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0XFFFFFFFF),
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // sizedBoxWidth(10.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 3),
                          child: Image.asset(
                            "assets/images/redfood.png",
                            width: 94.w,
                            height: 135.h,
                          ),
                        )
                      ],
                    ),
                  ),
                  sizedBoxHeight(28.h),
                  Text(
                    "Order delivered on 6 Feb 2023 at 09.41",
                    style: TextStyle(fontSize: 12.sp, color: Color(0XFF6D6D6D)),
                  ),
                  sizedBoxHeight(7.h),
                  Container(
                    width: 358.w,
                    // height: 125.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0XFF0000001F),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x48B9B9BE),
                            //  / blurRadius: 1.0,
                            offset: Offset(0.0, 0.75),
                            // spreadRadius: 0
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, top: 9.h, bottom: 18.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agrofeed Ruminant Feed",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0XFF141414),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              Text(
                                "Cow feed",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0XFF141414),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              sizedBoxHeight(8.h),
                              Container(
                                height: 25.h,
                                width: 91.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.h),
                                  color: AppColors.buttoncolour,
                                ),
                                child: Center(
                                  child: Text(
                                    "Reorder",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0XFFFFFFFF),
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // sizedBoxWidth(10.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 3),
                          child: Image.asset(
                            "assets/images/yellowfood.png",
                            width: 94.w,
                            height: 135.h,
                          ),
                        )
                      ],
                    ),
                  ),
                  sizedBoxHeight(29.h),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  List filterList = ['beef', 'cow', 'sheep', 'pigs', 'hen'];
  Widget filter() {
    return PopupMenuButton(
      icon: SvgPicture.asset(
        'assets/images/filter.svg',
        // width: 53.w,
        // height: 60.h,
        fit: BoxFit.cover,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                itemFilter(0),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.cancel_outlined))
              ]),
              itemFilter(1),
              itemFilter(2),
              itemFilter(3),
              itemFilter(4),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolour,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: textWhite16('Apply Now')),
                  ))
            ],
          ))
        ];
      },
    );
  }

  Widget itemFilter(int index) {
    RxBool filter = false.obs;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            activeColor: AppColors.buttoncolour,
            value: filter.value,
            onChanged: (value) {
              filter.value = !filter.value;
            },
          ),
        ),
        Image.asset('assets/images/${filterList[index]}.png',
            width: 40.w, height: 24.h),
        sizedBoxWidth(5.w),
        textblack14M(filterList[index]),
      ],
    );
  }

  Widget status() {
    return CircleAvatar(
      backgroundColor: Color(0XFFACC8A8),
      radius: 11.h,
      child: CircleAvatar(
        radius: 7.h,
        backgroundColor: AppColors.buttoncolour,
      ),
    );
  }
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
