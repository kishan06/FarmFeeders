import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/models/OrderModel/orders_model.dart';
import 'package:farmfeeders/view/YourOrder/orderListScreen.dart';
import 'package:farmfeeders/view_models/orderApi/order_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/utils.dart';

class Yourorder extends StatefulWidget {
  const Yourorder({super.key});

  @override
  State<Yourorder> createState() => _YourorderState();
}

class _YourorderState extends State<Yourorder> {
  RxBool isLoading = true.obs;
  OrdersModel ordersModel = OrdersModel();

  String loginStatus = "";
  @override
  void initState() {
    getData();
    OrderApi().getOrdersListApi().then((value) {
      ordersModel = OrdersModel.fromJson(value.data);
      isLoading.value = false;
    });
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginStatus = prefs.getString("loginStatus")!;

    setState(() {});
  }

  void passToOrders(
    String text,
  ) {
    Get.to(const OrderListScreen(), arguments: {"name": text});
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
                      color: const Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.buttoncolour,
                      )),
                    )
                  : Expanded(
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
                                    color: const Color(0XFF141414)),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  passToOrders("ongoing");
                                },
                                child: Text(
                                  "See more",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0XFF0E5F02)),
                                ),
                              ),
                            ],
                          ),
                          sizedBoxHeight(15.h),
                          ordersModel.data!.ongoingOrder == null
                              ? Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Center(
                                      child: Text(
                                    "No Ongoing Orders Right Now",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0XFF141414)),
                                  )),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/ongoingorder", arguments: {
                                      "id": ordersModel.data!.orderHeaderId!,
                                    });
                                  },
                                  child: Container(
                                    height: 230.h,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
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
                                        Expanded(
                                          child: Padding(
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
                                                        BorderRadius.circular(
                                                            25.h),
                                                    color:
                                                        const Color(0XFFFFB7B7),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Arriving Soon",
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: const Color(
                                                            0XFFAC2A33),
                                                        fontFamily: "Poppins",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                sizedBoxHeight(15.h),
                                                Image.network(
                                                  "${ApiUrls.baseImageUrl}/${ordersModel.data!.ongoingOrder!.smallImageUrl}",
                                                  width: 105.w,
                                                  height: 98.h,
                                                ),
                                                //  sizedBoxHeight(7.h),
                                                Text(
                                                  ordersModel.data!
                                                      .ongoingOrder!.title!,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: const Color(
                                                          0XFF141414)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 19.h),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    status(),
                                                    const DottedLine(
                                                      direction: Axis.vertical,
                                                      lineLength: 30,
                                                      lineThickness: 2.0,
                                                      dashLength: 4.0,
                                                      dashColor:
                                                          Color(0XFF0E5F02),
                                                    ),
                                                    ordersModel
                                                            .data!.orderStatus!
                                                            .any((item) =>
                                                                item.deliveryStatusXid ==
                                                                4)
                                                        ? status()
                                                        : (ordersModel.data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        1) ||
                                                                ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        3))
                                                            ? CircleAvatar(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .buttoncolour,
                                                                radius: 11.w,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 9.w,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .pistaE3FFE9,
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          "assets/images/delivery.svg"),
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 15,
                                                                height: 15,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .buttoncolour)),
                                                              ),
                                                    const DottedLine(
                                                      direction: Axis.vertical,
                                                      lineLength: 30,
                                                      lineThickness: 2.0,
                                                      dashLength: 4.0,
                                                      dashColor:
                                                          Color(0XFF0E5F02),
                                                    ),
                                                    ordersModel
                                                            .data!.orderStatus!
                                                            .any((item) =>
                                                                item.deliveryStatusXid ==
                                                                5)
                                                        ? status()
                                                        : ordersModel.data!
                                                                .orderStatus!
                                                                .any((item) =>
                                                                    item.deliveryStatusXid ==
                                                                    4)
                                                            ? CircleAvatar(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .buttoncolour,
                                                                radius: 11.w,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 9.w,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .pistaE3FFE9,
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          "assets/images/delivery.svg"),
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 15,
                                                                height: 15,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .buttoncolour)),
                                                              ),
                                                    const DottedLine(
                                                      direction: Axis.vertical,
                                                      lineLength: 30,
                                                      lineThickness: 2.0,
                                                      dashLength: 4.0,
                                                      dashColor:
                                                          Color(0XFF0E5F02),
                                                    ),
                                                    ordersModel
                                                            .data!.orderStatus!
                                                            .any((item) =>
                                                                item.deliveryStatusXid ==
                                                                7)
                                                        ? status()
                                                        : (ordersModel.data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        5) ||
                                                                ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        6))
                                                            ? CircleAvatar(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .buttoncolour,
                                                                radius: 11.w,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 9.w,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .pistaE3FFE9,
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          "assets/images/delivery.svg"),
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 15,
                                                                height: 15,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .buttoncolour)),
                                                              ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ordered",
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: const Color(
                                                              0XFF0E5F02),
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/images/clock-svgrepo-com (1).svg",
                                                          width: 6.w,
                                                          height: 6.w,
                                                        ),
                                                        sizedBoxWidth(6.w),
                                                        Text(
                                                          Utils.convertUtcToCustomFormat(
                                                              ordersModel.data!
                                                                  .orderDate!),
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff4D4D4D),
                                                              fontSize: 8.sp,
                                                              fontFamily:
                                                                  "Poppins"),
                                                        )
                                                      ],
                                                    ),
                                                    sizedBoxHeight(14.h),
                                                    Container(
                                                      height: 30.h,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.h),
                                                        color: (ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        3) &&
                                                                ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid !=
                                                                        4))
                                                            ? Colors.transparent
                                                            : const Color(
                                                                0XFFF1F1F1),
                                                      ),
                                                      child: Text(
                                                        "Packed and ready",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        4)
                                                                ? const Color(
                                                                    0XFF0E5F02)
                                                                : const Color(
                                                                    0XFF4D4D4D),
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                                    ),
                                                    ordersModel
                                                            .data!.orderStatus!
                                                            .any((item) =>
                                                                item.deliveryStatusXid ==
                                                                4)
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/clock-svgrepo-com (1).svg",
                                                                width: 6.w,
                                                                height: 6.w,
                                                              ),
                                                              sizedBoxWidth(
                                                                  6.w),
                                                              Text(
                                                                Utils.convertUtcToCustomFormat(
                                                                    ordersModel
                                                                        .data!
                                                                        .orderStatus![
                                                                            3]
                                                                        .createdAt!),
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                        0xff4D4D4D),
                                                                    fontSize:
                                                                        8.sp,
                                                                    fontFamily:
                                                                        "Poppins"),
                                                              )
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    sizedBoxHeight(19.h),
                                                    Container(
                                                      height: 30.h,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.h),
                                                        color: !(ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        4) &&
                                                                ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid !=
                                                                        5))
                                                            ? Colors.transparent
                                                            : const Color(
                                                                0XFFF1F1F1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Out for delivery",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid ==
                                                                        5)
                                                                ? const Color(
                                                                    0XFF0E5F02)
                                                                : const Color(
                                                                    0XFF4D4D4D),
                                                            fontFamily:
                                                                "Poppins",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ordersModel
                                                            .data!.orderStatus!
                                                            .any((item) =>
                                                                item.deliveryStatusXid ==
                                                                5)
                                                        ? Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/clock-svgrepo-com (1).svg",
                                                                width: 6.w,
                                                                height: 6.w,
                                                              ),
                                                              sizedBoxWidth(
                                                                  6.w),
                                                              Text(
                                                                Utils.convertUtcToCustomFormat(
                                                                    ordersModel
                                                                        .data!
                                                                        .orderStatus![
                                                                            3]
                                                                        .createdAt!),
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                        0xff4D4D4D),
                                                                    fontSize:
                                                                        8.sp,
                                                                    fontFamily:
                                                                        "Poppins"),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    sizedBoxHeight(15.h),
                                                    Container(
                                                      height: 30.h,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.h),
                                                        color: !((ordersModel
                                                                        .data!
                                                                        .orderStatus!
                                                                        .any((item) =>
                                                                            item.deliveryStatusXid ==
                                                                            5) ||
                                                                    ordersModel
                                                                        .data!
                                                                        .orderStatus!
                                                                        .any((item) =>
                                                                            item.deliveryStatusXid ==
                                                                            6)) &&
                                                                ordersModel
                                                                    .data!
                                                                    .orderStatus!
                                                                    .any((item) =>
                                                                        item.deliveryStatusXid !=
                                                                        7))
                                                            ? Colors.transparent
                                                            : const Color(
                                                                0XFFF1F1F1),
                                                      ),
                                                      child: Text(
                                                        "Delivered",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: const Color(
                                                                0XFF4D4D4D),
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                                    ),
                                                    ordersModel
                                                            .data!.orderStatus!
                                                            .any((item) =>
                                                                item.deliveryStatusXid ==
                                                                7)
                                                        ? Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/clock-svgrepo-com (1).svg",
                                                                width: 6.w,
                                                                height: 6.w,
                                                              ),
                                                              sizedBoxWidth(
                                                                  6.w),
                                                              Text(
                                                                Utils.convertUtcToCustomFormat(
                                                                    ordersModel
                                                                        .data!
                                                                        .orderStatus![
                                                                            5]
                                                                        .createdAt!),
                                                                style: TextStyle(
                                                                    color: ordersModel
                                                                            .data!
                                                                            .orderStatus!
                                                                            .any((item) =>
                                                                                item.deliveryStatusXid ==
                                                                                7)
                                                                        ? const Color(
                                                                            0XFF0E5F02)
                                                                        : const Color(
                                                                            0XFF4D4D4D),
                                                                    fontSize:
                                                                        8.sp,
                                                                    fontFamily:
                                                                        "Poppins"),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.recurringOrders == null
                                  ? const SizedBox()
                                  : sizedBoxHeight(19.h),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.recurringOrders!.isEmpty
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Recurring Orders",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0XFF141414)),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            passToOrders("recurring");
                                          },
                                          child: Text(
                                            "See more",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0XFF0E5F02)),
                                          ),
                                        ),
                                      ],
                                    ),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.recurringOrders == null
                                  ? const SizedBox()
                                  : sizedBoxHeight(6.h),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.recurringOrders!.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                      width: 358.w,
                                      // height: 123.h,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
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
                                          ordersModel.data!.recurringOrders!
                                                  .isEmpty
                                              ? const SizedBox()
                                              : SizedBox(
                                                  width: Get.width / 3.5,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 15.w,
                                                      top: 14.h,
                                                      bottom: 24.h,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.network(
                                                          "${ApiUrls.baseImageUrl}/${ordersModel.data!.recurringOrders![0].smallImageUrl}",
                                                          width: 80.w,
                                                          height: 69.h,
                                                        ),
                                                        sizedBoxHeight(5.h),
                                                        Text(
                                                          ordersModel
                                                              .data!
                                                              .recurringOrders![
                                                                  0]
                                                              .title!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: const Color(
                                                                  0XFF141414),
                                                              fontFamily:
                                                                  "Poppins"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          const Spacer(),
                                          ordersModel.data!.recurringOrders!
                                                      .length <
                                                  2
                                              ? const SizedBox()
                                              : SizedBox(
                                                  width: Get.width / 3.5,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 15.w,
                                                      top: 14.h,
                                                      bottom: 24.h,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Center(
                                                          child: Image.network(
                                                            "${ApiUrls.baseImageUrl}/${ordersModel.data!.recurringOrders![1].smallImageUrl!}",
                                                            width: 80.w,
                                                            height: 69.h,
                                                          ),
                                                        ),
                                                        sizedBoxHeight(5.h),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            ordersModel
                                                                .data!
                                                                .recurringOrders![
                                                                    1]
                                                                .title!,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: const Color(
                                                                    0XFF141414),
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          const Spacer(),
                                          ordersModel.data!.recurringOrders!
                                                      .length <
                                                  3
                                              ? const SizedBox()
                                              : SizedBox(
                                                  width: Get.width / 3.5,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 15.w,
                                                      top: 14.h,
                                                      bottom: 24.h,
                                                      right: 15.w,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.network(
                                                          "${ApiUrls.baseImageUrl}/${ordersModel.data!.recurringOrders![2].smallImageUrl!}",
                                                          width: 80.w,
                                                          height: 69.h,
                                                        ),
                                                        sizedBoxHeight(5.h),
                                                        Text(
                                                          ordersModel
                                                              .data!
                                                              .recurringOrders![
                                                                  2]
                                                              .title!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: const Color(
                                                                  0XFF141414),
                                                              fontFamily:
                                                                  "Poppins"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.cancelledOrders!.isEmpty
                                  ? const SizedBox()
                                  : sizedBoxHeight(16.h),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.cancelledOrders!.isEmpty
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cancelled Orders",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0XFF141414)),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            passToOrders("cancelled");
                                          },
                                          child: Text(
                                            "See more",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0XFF0E5F02)),
                                          ),
                                        ),
                                      ],
                                    ),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.cancelledOrders!.isEmpty
                                  ? const SizedBox()
                                  : sizedBoxHeight(6.h),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      ordersModel.data!.cancelledOrders!.length,
                                  itemBuilder: (ctx, index) {
                                    return index > 3
                                        ? SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/cancelorder",
                                                      arguments: {
                                                        "id": ordersModel
                                                            .data!
                                                            .cancelledOrders![
                                                                index]
                                                            .orderId!,
                                                      });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 15),
                                                  width: 358.w,
                                                  // height: 125.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          color: Color(
                                                              0XFF0000001F),
                                                          boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x48B9B9BE),
                                                          //  / blurRadius: 1.0,
                                                          offset:
                                                              Offset(0.0, 0.75),
                                                          // spreadRadius: 0
                                                        )
                                                      ]),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          "${ApiUrls.baseImageUrl}/${ordersModel.data!.cancelledOrders![index].inventory!.smallImageUrl!}",
                                                          width: 90.w,
                                                          height: 100.h,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                Get.width / 1.7,
                                                            child: Text(
                                                              ordersModel
                                                                  .data!
                                                                  .cancelledOrders![
                                                                      index]
                                                                  .inventory!
                                                                  .title!,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                fontSize: 17.sp,
                                                                color: const Color(
                                                                    0XFF141414),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins",
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Get.width / 1.7,
                                                            child: Text(
                                                              "Order cancelled on ${Utils.convertUtcToCustomFormat(ordersModel.data!.cancelledOrders![index].createdAt!)}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: const Color(
                                                                      0XFF6D6D6D)),
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   "Cow feed",
                                                          //   style: TextStyle(
                                                          //     fontSize: 16.sp,
                                                          //     color: const Color(
                                                          //         0XFF141414),
                                                          //     fontWeight:
                                                          //         FontWeight.w600,
                                                          //     fontFamily: "Poppins",
                                                          //   ),
                                                          // ),
                                                          sizedBoxHeight(8.h),
                                                          // Container(
                                                          //   height: 25.h,
                                                          //   width: 91.w,
                                                          //   decoration: BoxDecoration(
                                                          //     borderRadius:
                                                          //         BorderRadius.circular(
                                                          //             25.h),
                                                          //     color:
                                                          //         AppColors.buttoncolour,
                                                          //   ),
                                                          //   child: Center(
                                                          //     child: Text(
                                                          //       "Reorder",
                                                          //       style: TextStyle(
                                                          //         fontSize: 14.sp,
                                                          //         color: const Color(
                                                          //             0XFFFFFFFF),
                                                          //         fontFamily: "Poppins",
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      // sizedBoxWidth(10.w),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                  }),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.pastOrders!.isEmpty
                                  ? const SizedBox()
                                  : sizedBoxHeight(16.h),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.pastOrders!.isEmpty
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Past Orders",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0XFF141414)),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            passToOrders("past");
                                          },
                                          child: Text(
                                            "See more",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0XFF0E5F02)),
                                          ),
                                        ),
                                      ],
                                    ),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ordersModel.data!.pastOrders!.isEmpty
                                  ? const SizedBox()
                                  : sizedBoxHeight(6.h),
                          loginStatus ==
                                  "Subscription Inactive and Orders Pending"
                              ? const SizedBox()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      ordersModel.data!.pastOrders!.length,
                                  itemBuilder: (ctx, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/deliveredorder",
                                                arguments: {
                                                  "id": ordersModel
                                                      .data!
                                                      .pastOrders![index]
                                                      .orderId!,
                                                });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              bottom: 15,
                                            ),
                                            width: 358.w,
                                            // height: 125.h,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Color(0XFF0000001F),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x48B9B9BE),
                                                    //  / blurRadius: 1.0,
                                                    offset: Offset(0.0, 0.75),
                                                    // spreadRadius: 0
                                                  )
                                                ]),
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    "${ApiUrls.baseImageUrl}/${ordersModel.data!.pastOrders![index].inventory!.smallImageUrl!}",
                                                    width: 90.w,
                                                    height: 100.h,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width / 1.7,
                                                      child: Text(
                                                        ordersModel
                                                            .data!
                                                            .pastOrders![index]
                                                            .inventory!
                                                            .title!,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 17.sp,
                                                          color: const Color(
                                                              0XFF141414),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: "Poppins",
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width / 1.7,
                                                      child: Text(
                                                        "Order delivered on ${Utils.convertUtcToCustomFormat(ordersModel.data!.pastOrders![index].createdAt!)}",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: const Color(
                                                                0XFF6D6D6D)),
                                                      ),
                                                    ),
                                                    sizedBoxHeight(8.h),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                          sizedBoxHeight(29.h),
                        ],
                      ),
                    )),
            )
          ],
        ),
      ),
    );
  }

  Widget status() {
    return CircleAvatar(
      backgroundColor: const Color(0XFFACC8A8),
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
