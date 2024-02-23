import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/models/OrderModel/cancelled_order_model.dart';
import 'package:farmfeeders/models/OrderModel/ongoing_order_model.dart';
import 'package:farmfeeders/models/OrderModel/past_order_model.dart';
import 'package:farmfeeders/models/OrderModel/recurring_order_model.dart';
import 'package:farmfeeders/view/YourOrder/recurringOrder.dart';
import 'package:farmfeeders/view_models/orderApi/order_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Utils/colors.dart';
import '../../Utils/sized_box.dart';
import '../../Utils/texts.dart';
import '../../Utils/utils.dart';
import '../../common/custom_appbar.dart';
import '../../common/status.dart';

enum SingingCharacter {
  All,
  Today,
  Week,
  Month,
  Threemonth,
  Year,
}

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String textV = "";
  TextEditingController textcontroller = TextEditingController();
  RxBool isLoading = true.obs;

  OngoingOrderListModel ongoingOrderListModel = OngoingOrderListModel();
  CancelledOrderListModel cancelledOrderListModel = CancelledOrderListModel();
  PastOrderListModel pastOrderListModel = PastOrderListModel();
  RecurringOrderListModel recurringOrderListModel = RecurringOrderListModel();
  SingingCharacter? _character = SingingCharacter.All;

  @override
  void initState() {
    textV = Get.arguments["name"];
    if (textV == "ongoing") {
      OrderApi()
          .getMoreOrdersListApi(ApiUrls.ongoingOrdersApi, 100)
          .then((value) {
        ongoingOrderListModel = OngoingOrderListModel.fromJson(value.data);
        isLoading.value = false;
      });
    } else if (textV == "recurring") {
      OrderApi()
          .getMoreOrdersListApi(ApiUrls.recurringOrdersApi, 100)
          .then((value) {
        recurringOrderListModel = RecurringOrderListModel.fromJson(value.data);
        isLoading.value = false;
      });
    } else if (textV == "cancelled") {
      OrderApi()
          .getMoreOrdersListApi(ApiUrls.cancelledOrdersApi, 0)
          .then((value) {
        cancelledOrderListModel = CancelledOrderListModel.fromJson(value.data);
        isLoading.value = false;
      });
    } else {
      OrderApi().getMoreOrdersListApi(ApiUrls.pastOrdersApi, 0).then((value) {
        pastOrderListModel = PastOrderListModel.fromJson(value.data);
        isLoading.value = false;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          (textV == "ongoing" || textV == "recurring")
              ? const SizedBox()
              : PopupMenuButton(
                  offset: const Offset(0, 50),
                  color: const Color(0xFFFFFFFF),
                  tooltip: '',
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black,
                  ),
                  onSelected: (value) {
                    setState(() {
                      _character = value;
                    });
                    Get.back();
                  },
                  itemBuilder: (BuildContext bc) {
                    return [
                      PopupMenuItem(
                        child: RadioListTile<SingingCharacter>(
                          title: const Text('All'),
                          value: SingingCharacter.All,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                            Get.back();
                            isLoading.value = true;
                            OrderApi()
                                .getMoreOrdersListApi(
                                    textV == "past"
                                        ? ApiUrls.pastOrdersApi
                                        : ApiUrls.cancelledOrdersApi,
                                    0)
                                .then((value) {
                              if (textV == "past") {
                                cancelledOrderListModel =
                                    CancelledOrderListModel.fromJson(
                                        value.data);
                              } else {
                                pastOrderListModel =
                                    PastOrderListModel.fromJson(value.data);
                              }

                              isLoading.value = false;
                            });
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: RadioListTile<SingingCharacter>(
                          title: const Text('Today'),
                          value: SingingCharacter.Today,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                            Get.back();
                            isLoading.value = true;
                            OrderApi()
                                .getMoreOrdersListApi(
                                    textV == "past"
                                        ? ApiUrls.pastOrdersApi
                                        : ApiUrls.cancelledOrdersApi,
                                    1)
                                .then((value) {
                              if (textV == "past") {
                                cancelledOrderListModel =
                                    CancelledOrderListModel.fromJson(
                                        value.data);
                              } else {
                                pastOrderListModel =
                                    PastOrderListModel.fromJson(value.data);
                              }
                              isLoading.value = false;
                            });
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: RadioListTile<SingingCharacter>(
                          title: const Text('Last Week'),
                          value: SingingCharacter.Week,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                            Get.back();
                            isLoading.value = true;
                            OrderApi()
                                .getMoreOrdersListApi(
                                    textV == "past"
                                        ? ApiUrls.pastOrdersApi
                                        : ApiUrls.cancelledOrdersApi,
                                    2)
                                .then((value) {
                              if (textV == "past") {
                                cancelledOrderListModel =
                                    CancelledOrderListModel.fromJson(
                                        value.data);
                              } else {
                                pastOrderListModel =
                                    PastOrderListModel.fromJson(value.data);
                              }
                              isLoading.value = false;
                            });
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: RadioListTile<SingingCharacter>(
                          title: const Text('Last Month'),
                          value: SingingCharacter.Month,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                            Get.back();
                            isLoading.value = true;
                            OrderApi()
                                .getMoreOrdersListApi(
                                    textV == "past"
                                        ? ApiUrls.pastOrdersApi
                                        : ApiUrls.cancelledOrdersApi,
                                    3)
                                .then((value) {
                              if (textV == "past") {
                                cancelledOrderListModel =
                                    CancelledOrderListModel.fromJson(
                                        value.data);
                              } else {
                                pastOrderListModel =
                                    PastOrderListModel.fromJson(value.data);
                              }
                              isLoading.value = false;
                            });
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: RadioListTile<SingingCharacter>(
                          title: const Text('Last 3 Month'),
                          value: SingingCharacter.Threemonth,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                            Get.back();
                            isLoading.value = true;
                            OrderApi()
                                .getMoreOrdersListApi(
                                    textV == "past"
                                        ? ApiUrls.pastOrdersApi
                                        : ApiUrls.cancelledOrdersApi,
                                    4)
                                .then((value) {
                              if (textV == "past") {
                                cancelledOrderListModel =
                                    CancelledOrderListModel.fromJson(
                                        value.data);
                              } else {
                                pastOrderListModel =
                                    PastOrderListModel.fromJson(value.data);
                              }
                              isLoading.value = false;
                            });
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: RadioListTile<SingingCharacter>(
                          title: const Text('Last Year'),
                          value: SingingCharacter.Year,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                            Get.back();
                            isLoading.value = true;
                            OrderApi()
                                .getMoreOrdersListApi(
                                    textV == "past"
                                        ? ApiUrls.pastOrdersApi
                                        : ApiUrls.cancelledOrdersApi,
                                    5)
                                .then((value) {
                              if (textV == "past") {
                                cancelledOrderListModel =
                                    CancelledOrderListModel.fromJson(
                                        value.data);
                              } else {
                                pastOrderListModel =
                                    PastOrderListModel.fromJson(value.data);
                              }
                              isLoading.value = false;
                            });
                          },
                        ),
                      ),
                    ];
                  },
                ),
        ],

        backgroundColor: AppColors.white,
        title: customAppBar(
            text: textV == "ongoing"
                ? "Ongoing Orders"
                : textV == "recurring"
                    ? "Recurring Orders"
                    : textV == "cancelled"
                        ? "Cancelled Orders"
                        : "Past Orders"),

        // backgroundColor: Color(0xFFF5F8FA),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          strokeWidth: 3,
          displacement: 250,
          backgroundColor: Colors.white,
          color: AppColors.buttoncolour,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1500));
            if (textV == "ongoing") {
              isLoading.value = true;
              OrderApi()
                  .getMoreOrdersListApi(ApiUrls.ongoingOrdersApi, 100)
                  .then((value) {
                ongoingOrderListModel =
                    OngoingOrderListModel.fromJson(value.data);
                isLoading.value = false;
              });
            } else if (textV == "recurring") {
              isLoading.value = true;
              OrderApi()
                  .getMoreOrdersListApi(ApiUrls.recurringOrdersApi, 100)
                  .then((value) {
                recurringOrderListModel =
                    RecurringOrderListModel.fromJson(value.data);
                isLoading.value = false;
              });
            } else if (textV == "cancelled") {
              isLoading.value = true;
              OrderApi()
                  .getMoreOrdersListApi(ApiUrls.cancelledOrdersApi, 0)
                  .then((value) {
                cancelledOrderListModel =
                    CancelledOrderListModel.fromJson(value.data);
                isLoading.value = false;
              });
            } else {
              isLoading.value = true;
              OrderApi()
                  .getMoreOrdersListApi(ApiUrls.pastOrdersApi, 0)
                  .then((value) {
                pastOrderListModel = PastOrderListModel.fromJson(value.data);
                isLoading.value = false;
              });
            }
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Obx(
                  () => isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            textV == "ongoing"
                                ? ongoingOrderListModel.data!.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          LottieBuilder.asset(
                                              "assets/lotties/no_data_found.json"),
                                          textGrey4D4D4D_22(
                                              "No Ongoing Orders Found !"),
                                        ],
                                      )
                                    : SizedBox(
                                        height: Get.height,
                                        child: ListView.builder(
                                            itemCount: ongoingOrderListModel
                                                .data!.length,
                                            itemBuilder: (ctx, index) {
                                              return ongoingOrderListModel
                                                          .data![index]
                                                          .product ==
                                                      null
                                                  ? const SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            "/ongoingorder",
                                                            arguments: {
                                                              "id": ongoingOrderListModel
                                                                  .data![index]
                                                                  .orderHeaderId!,
                                                            });

                                                        if (ongoingOrderListModel
                                                                .data![index]
                                                                .orderType ==
                                                            "new") {
                                                          Get.toNamed(
                                                              "/ongoingorder",
                                                              arguments: {
                                                                "id": ongoingOrderListModel
                                                                    .data![
                                                                        index]
                                                                    .orderHeaderId!,
                                                              });
                                                        } else {
                                                          Get.to(
                                                              () =>
                                                                  const RecurringOrder(),
                                                              arguments: {
                                                                "id": ongoingOrderListModel
                                                                    .data![
                                                                        index]
                                                                    .orderHeaderId!,
                                                              });
                                                        }
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 15),
                                                        height: 230.h,
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            color: AppColors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color(
                                                                      0x48B9B9BE),
                                                                  blurRadius:
                                                                      8.0,
                                                                  spreadRadius:
                                                                      0)
                                                            ]),
                                                        child: Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 18
                                                                            .w,
                                                                        top: 12
                                                                            .h,
                                                                        bottom:
                                                                            28.h),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30.h,
                                                                      width:
                                                                          123.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(25.h),
                                                                        color: const Color(
                                                                            0XFFFFB7B7),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "Arriving Soon",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16.sp,
                                                                            color:
                                                                                const Color(0XFFAC2A33),
                                                                            fontFamily:
                                                                                "Poppins",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    sizedBoxHeight(
                                                                        15.h),
                                                                    CachedNetworkImage(
                                                                      imageUrl:
                                                                          "${ApiUrls.baseImageUrl}/${ongoingOrderListModel.data![index].product!.smallImageUrl}",
                                                                      width:
                                                                          105.w,
                                                                      height:
                                                                          98.h,
                                                                    ),
                                                                    //  sizedBoxHeight(7.h),
                                                                    Text(
                                                                      ongoingOrderListModel
                                                                          .data![
                                                                              index]
                                                                          .product!
                                                                          .title!,
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          color:
                                                                              const Color(0XFF141414)),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 19
                                                                            .h),
                                                                child: Row(
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        status(),
                                                                        const DottedLine(
                                                                          direction:
                                                                              Axis.vertical,
                                                                          lineLength:
                                                                              30,
                                                                          lineThickness:
                                                                              2.0,
                                                                          dashLength:
                                                                              4.0,
                                                                          dashColor:
                                                                              Color(0XFF0E5F02),
                                                                        ),
                                                                        ongoingOrderListModel.data![index].orderStatus!.any((item) =>
                                                                                item.deliveryStatusXid ==
                                                                                4)
                                                                            ? status()
                                                                            : (ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 1) || ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 3))
                                                                                ? CircleAvatar(
                                                                                    backgroundColor: AppColors.buttoncolour,
                                                                                    radius: 11.w,
                                                                                    child: CircleAvatar(
                                                                                      radius: 9.w,
                                                                                      backgroundColor: AppColors.pistaE3FFE9,
                                                                                      child: SvgPicture.asset("assets/images/delivery.svg"),
                                                                                    ),
                                                                                  )
                                                                                : Container(
                                                                                    width: 15,
                                                                                    height: 15,
                                                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white, border: Border.all(color: AppColors.buttoncolour)),
                                                                                  ),
                                                                        const DottedLine(
                                                                          direction:
                                                                              Axis.vertical,
                                                                          lineLength:
                                                                              30,
                                                                          lineThickness:
                                                                              2.0,
                                                                          dashLength:
                                                                              4.0,
                                                                          dashColor:
                                                                              Color(0XFF0E5F02),
                                                                        ),
                                                                        ongoingOrderListModel.data![index].orderStatus!.any((item) =>
                                                                                item.deliveryStatusXid ==
                                                                                5)
                                                                            ? status()
                                                                            : ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 4)
                                                                                ? CircleAvatar(
                                                                                    backgroundColor: AppColors.buttoncolour,
                                                                                    radius: 11.w,
                                                                                    child: CircleAvatar(
                                                                                      radius: 9.w,
                                                                                      backgroundColor: AppColors.pistaE3FFE9,
                                                                                      child: SvgPicture.asset("assets/images/delivery.svg"),
                                                                                    ),
                                                                                  )
                                                                                : Container(
                                                                                    width: 15,
                                                                                    height: 15,
                                                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white, border: Border.all(color: AppColors.buttoncolour)),
                                                                                  ),
                                                                        const DottedLine(
                                                                          direction:
                                                                              Axis.vertical,
                                                                          lineLength:
                                                                              30,
                                                                          lineThickness:
                                                                              2.0,
                                                                          dashLength:
                                                                              4.0,
                                                                          dashColor:
                                                                              Color(0XFF0E5F02),
                                                                        ),
                                                                        ongoingOrderListModel.data![index].orderStatus!.any((item) =>
                                                                                item.deliveryStatusXid ==
                                                                                7)
                                                                            ? status()
                                                                            : (ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 5) || ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 6))
                                                                                ? CircleAvatar(
                                                                                    backgroundColor: AppColors.buttoncolour,
                                                                                    radius: 11.w,
                                                                                    child: CircleAvatar(
                                                                                      radius: 9.w,
                                                                                      backgroundColor: AppColors.pistaE3FFE9,
                                                                                      child: SvgPicture.asset("assets/images/delivery.svg"),
                                                                                    ),
                                                                                  )
                                                                                : Container(
                                                                                    width: 15,
                                                                                    height: 15,
                                                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white, border: Border.all(color: AppColors.buttoncolour)),
                                                                                  ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Ordered",
                                                                          style: TextStyle(
                                                                              fontSize: 14.sp,
                                                                              color: const Color(0XFF0E5F02),
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
                                                                              Utils.convertUtcToCustomFormat(ongoingOrderListModel.data![index].orderDate!),
                                                                              style: TextStyle(color: const Color(0xff4D4D4D), fontSize: 8.sp, fontFamily: "Poppins"),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        sizedBoxHeight(
                                                                            14.h),
                                                                        Container(
                                                                          height:
                                                                              30.h,
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25.h),
                                                                            color: (ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 3) && ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid != 4))
                                                                                ? Colors.transparent
                                                                                : const Color(0XFFF1F1F1),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Packed and ready",
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 4) ? const Color(0XFF0E5F02) : const Color(0XFF4D4D4D),
                                                                                fontFamily: "Poppins"),
                                                                          ),
                                                                        ),
                                                                        ongoingOrderListModel.data![index].orderStatus!.any((item) =>
                                                                                item.deliveryStatusXid ==
                                                                                4)
                                                                            ? Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    "assets/images/clock-svgrepo-com (1).svg",
                                                                                    width: 6.w,
                                                                                    height: 6.w,
                                                                                  ),
                                                                                  sizedBoxWidth(6.w),
                                                                                  Text(
                                                                                    Utils.convertUtcToCustomFormat(ongoingOrderListModel.data![index].orderStatus![2].createdAt!),
                                                                                    style: TextStyle(color: const Color(0xff4D4D4D), fontSize: 8.sp, fontFamily: "Poppins"),
                                                                                  )
                                                                                ],
                                                                              )
                                                                            : const SizedBox(),
                                                                        sizedBoxHeight(
                                                                            19.h),
                                                                        Container(
                                                                          height:
                                                                              30.h,
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25.h),
                                                                            color: !(ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 4) && ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid != 5))
                                                                                ? Colors.transparent
                                                                                : const Color(0XFFF1F1F1),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "Out for delivery",
                                                                              style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 5) ? const Color(0XFF0E5F02) : const Color(0XFF4D4D4D),
                                                                                fontFamily: "Poppins",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        ongoingOrderListModel.data![index].orderStatus!.any((item) =>
                                                                                item.deliveryStatusXid ==
                                                                                5)
                                                                            ? Row(
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    "assets/images/clock-svgrepo-com (1).svg",
                                                                                    width: 6.w,
                                                                                    height: 6.w,
                                                                                  ),
                                                                                  sizedBoxWidth(6.w),
                                                                                  Text(
                                                                                    Utils.convertUtcToCustomFormat(ongoingOrderListModel.data![index].orderStatus![3].createdAt!),
                                                                                    style: TextStyle(color: const Color(0xff4D4D4D), fontSize: 8.sp, fontFamily: "Poppins"),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : const SizedBox(),
                                                                        sizedBoxHeight(
                                                                            15.h),
                                                                        Container(
                                                                          height:
                                                                              30.h,
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25.h),
                                                                            color: !((ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 5) || ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 6)) && ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid != 7))
                                                                                ? Colors.transparent
                                                                                : const Color(0XFFF1F1F1),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Delivered",
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: const Color(0XFF4D4D4D),
                                                                                fontFamily: "Poppins"),
                                                                          ),
                                                                        ),
                                                                        ongoingOrderListModel.data![index].orderStatus!.any((item) =>
                                                                                item.deliveryStatusXid ==
                                                                                7)
                                                                            ? Row(
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    "assets/images/clock-svgrepo-com (1).svg",
                                                                                    width: 6.w,
                                                                                    height: 6.w,
                                                                                  ),
                                                                                  sizedBoxWidth(6.w),
                                                                                  Text(
                                                                                    Utils.convertUtcToCustomFormat(ongoingOrderListModel.data![index].orderStatus![5].createdAt!),
                                                                                    style: TextStyle(color: ongoingOrderListModel.data![index].orderStatus!.any((item) => item.deliveryStatusXid == 7) ? const Color(0XFF0E5F02) : const Color(0XFF4D4D4D), fontSize: 8.sp, fontFamily: "Poppins"),
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
                                                    );
                                            }),
                                      )
                                : textV == "cancelled"
                                    ? cancelledOrderListModel
                                            .data!.cancelledOrders!.isEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              LottieBuilder.asset(
                                                  "assets/lotties/no_data_found.json"),
                                              textGrey4D4D4D_22(
                                                  "No Cancelled Orders Found !"),
                                            ],
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: cancelledOrderListModel
                                                .data!.cancelledOrders!.length,
                                            itemBuilder: (ctx, index) {
                                              return cancelledOrderListModel
                                                          .data!
                                                          .cancelledOrders![
                                                              index]
                                                          .inventory ==
                                                      null
                                                  ? const SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            "/cancelorder",
                                                            arguments: {
                                                              "id": cancelledOrderListModel
                                                                  .data!
                                                                  .cancelledOrders![
                                                                      index]
                                                                  .orderId!,
                                                            });
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                          bottom: 15,
                                                        ),
                                                        width: 358.w,
                                                        // height: 125.h,
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            color: Color(
                                                                0XFF0000001F),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(
                                                                    0x48B9B9BE),
                                                                //  / blurRadius: 1.0,
                                                                offset: Offset(
                                                                    0.0, 0.75),
                                                                // spreadRadius: 0
                                                              )
                                                            ]),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    "${ApiUrls.baseImageUrl}/${cancelledOrderListModel.data!.cancelledOrders![index].inventory!.smallImageUrl!}",
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
                                                                      Get.width /
                                                                          1.7,
                                                                  child: Text(
                                                                    cancelledOrderListModel
                                                                        .data!
                                                                        .cancelledOrders![
                                                                            index]
                                                                        .inventory!
                                                                        .title!,
                                                                    maxLines: 2,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          17.sp,
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
                                                                      Get.width /
                                                                          1.7,
                                                                  child: Text(
                                                                    "Order cancelled on ${Utils.convertUtcToCustomFormat(cancelledOrderListModel.data!.cancelledOrders![index].cancelledAt!)}",
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        color: const Color(
                                                                            0XFF6D6D6D)),
                                                                  ),
                                                                ),
                                                                sizedBoxHeight(
                                                                    8.h),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                            })
                                    : textV == "past"
                                        ? pastOrderListModel
                                                .data!.pastOrders!.isEmpty
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  LottieBuilder.asset(
                                                      "assets/lotties/no_data_found.json"),
                                                  textGrey4D4D4D_22(
                                                      "No Past Orders Found !"),
                                                ],
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: pastOrderListModel
                                                    .data!.pastOrders!.length,
                                                itemBuilder: (ctx, index) {
                                                  return pastOrderListModel
                                                              .data!
                                                              .pastOrders![
                                                                  index]
                                                              .inventory ==
                                                          null
                                                      ? const SizedBox()
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.toNamed(
                                                                    "/deliveredorder",
                                                                    arguments: {
                                                                      "id": pastOrderListModel
                                                                          .data!
                                                                          .pastOrders![
                                                                              index]
                                                                          .orderId!,
                                                                    });
                                                              },
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  bottom: 15,
                                                                ),
                                                                width: 358.w,
                                                                // height: 125.h,
                                                                decoration: const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            20)),
                                                                    color: Color(
                                                                        0XFF0000001F),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color(
                                                                            0x48B9B9BE),
                                                                        //  / blurRadius: 1.0,
                                                                        offset: Offset(
                                                                            0.0,
                                                                            0.75),
                                                                        // spreadRadius: 0
                                                                      )
                                                                    ]),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            "${ApiUrls.baseImageUrl}/${pastOrderListModel.data!.pastOrders![index].inventory!.smallImageUrl!}",
                                                                        width:
                                                                            90.w,
                                                                        height:
                                                                            100.h,
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
                                                                          child:
                                                                              Text(
                                                                            pastOrderListModel.data!.pastOrders![index].inventory!.title!,
                                                                            maxLines:
                                                                                2,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 17.sp,
                                                                              color: const Color(0XFF141414),
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: "Poppins",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              Get.width / 1.7,
                                                                          child:
                                                                              Text(
                                                                            "Order delivered on ${Utils.convertUtcToCustomFormat(pastOrderListModel.data!.pastOrders![index].createdAt!)}",
                                                                            style:
                                                                                TextStyle(fontSize: 12.sp, color: const Color(0XFF6D6D6D)),
                                                                          ),
                                                                        ),
                                                                        sizedBoxHeight(
                                                                            8.h),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                })
                                        : recurringOrderListModel
                                                .data!.recurringOrders!.isEmpty
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  LottieBuilder.asset(
                                                      "assets/lotties/no_data_found.json"),
                                                  textGrey4D4D4D_22(
                                                      "No Recurring Orders Found !"),
                                                ],
                                              )
                                            : Container(
                                                margin: const EdgeInsets.only(
                                                    top: 15),
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        recurringOrderListModel
                                                            .data!
                                                            .recurringOrders!
                                                            .length,
                                                    itemBuilder: (ctx, index) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  () =>
                                                                      const RecurringOrder(),
                                                                  arguments: {
                                                                    "id": recurringOrderListModel
                                                                        .data!
                                                                        .recurringOrders![
                                                                            index]
                                                                        .id!,
                                                                  });
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                bottom: 15,
                                                              ),
                                                              width: 358.w,
                                                              // height: 125.h,
                                                              decoration: const BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  color: Color(
                                                                      0XFF0000001F),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Color(
                                                                          0x48B9B9BE),
                                                                      //  / blurRadius: 1.0,
                                                                      offset: Offset(
                                                                          0.0,
                                                                          0.75),
                                                                      // spreadRadius: 0
                                                                    )
                                                                  ]),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    child: Image
                                                                        .network(
                                                                      "${ApiUrls.baseImageUrl}/${recurringOrderListModel.data!.recurringOrders![index].smallImageUrl!}",
                                                                      width:
                                                                          90.w,
                                                                      height:
                                                                          100.h,
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
                                                                        width: Get.width /
                                                                            1.7,
                                                                        child:
                                                                            Text(
                                                                          recurringOrderListModel
                                                                              .data!
                                                                              .recurringOrders![index]
                                                                              .title!,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                17.sp,
                                                                            color:
                                                                                const Color(0XFF141414),
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      SizedBox(
                                                                        width: Get.width /
                                                                            1.7,
                                                                        child:
                                                                            Text(
                                                                          "Next Delivery Date: ${Utils.convertUtcToCustomFormat(recurringOrderListModel.data!.recurringOrders![index].nextPaymentDate!)}",
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              color: const Color(0XFF6D6D6D)),
                                                                        ),
                                                                      ),
                                                                      sizedBoxHeight(
                                                                          8.h),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              )
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List filterList = ['beef', 'cow', 'sheep', 'pig', 'hen'];
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
}
