import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/models/OrderModel/recurring_order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/api_urls.dart';
import '../../Utils/texts.dart';
import '../../Utils/utils.dart';
import '../../view_models/orderApi/order_api.dart';

class RecurringOrder extends StatefulWidget {
  const RecurringOrder({super.key});

  @override
  State<RecurringOrder> createState() => _RecurringorderState();
}

class _RecurringorderState extends State<RecurringOrder> {
  String? id;
  RxBool isLoading = true.obs;
  RecurringOrderDetailModel orderDetailsModel = RecurringOrderDetailModel();

  @override
  void initState() {
    var args = Get.arguments;
    id = args['id'].toString();
    OrderApi().getRecurringOrderDetails(id!).then((value) {
      orderDetailsModel = RecurringOrderDetailModel.fromJson(value.data);
      isLoading.value = false;
    });
    super.initState();
  }

  buildordercalldialog(
    context,
    String number,
  ) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
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
                    "Are you sure you want to call your sales rep to cancel order?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.sp,
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
                        launch("tel://$number");
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
                            border: Border.all(color: const Color(0XFF0E5F02)),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: Padding(
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
                  "Order Details",
                  style: TextStyle(
                    color: const Color(0XFF141414),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        body: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttoncolour,
                  ),
                )
              : RefreshIndicator(
                  strokeWidth: 3,
                  displacement: 250,
                  backgroundColor: Colors.white,
                  color: AppColors.buttoncolour,
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 1500));
                    isLoading.value = true;
                    OrderApi().getOrderDetails(id!).then((value) {
                      orderDetailsModel =
                          RecurringOrderDetailModel.fromJson(value.data);
                      isLoading.value = false;
                    });
                    setState(() {});
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxHeight(9.h),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Text(
                          "Order Id: ${orderDetailsModel.data!.orderDetails!.orderId!}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0XFF141414),
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBoxHeight(10.h),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 4.w, right: 16.w),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Delivering To",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0XFF4D4D4D),
                                                fontFamily: "Poppins"),
                                          ),
                                          sizedBoxHeight(1.h),
                                          SizedBox(
                                            width: Get.width / 1.25,
                                            child: Text(
                                              orderDetailsModel
                                                  .data!
                                                  .orderDetails!
                                                  .shippingAddress!,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color:
                                                      const Color(0XFF141414),
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              sizedBoxHeight(17.h),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: orderDetailsModel
                                      .data!.orderDetails!.orderDetails!.length,
                                  itemBuilder: (ctx, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.w, right: 16.w, bottom: 9.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 82.w,
                                            height: 88.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.h),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff918E8E),
                                                ),
                                                color: AppColors.white),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${ApiUrls.baseImageUrl}/${orderDetailsModel.data!.orderDetails!.orderDetails![index].inventoryImage}",
                                              width: 76.w,
                                              height: 71.h,
                                            ),
                                          ),
                                          sizedBoxWidth(15.w),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                orderDetailsModel
                                                    .data!
                                                    .orderDetails!
                                                    .orderDetails![index]
                                                    .inventoryTitle!,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color:
                                                        const Color(0XFF141414),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins"),
                                              ),
                                              sizedBoxHeight(2.h),
                                              Text(
                                                "Quantity : ${orderDetailsModel.data!.orderDetails!.orderDetails![index].quantity}",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        const Color(0XFF4D4D4D),
                                                    fontFamily: "Poppins"),
                                              ),
                                              sizedBoxHeight(2.h),
                                              Text(
                                                "Lot : ${orderDetailsModel.data!.orderDetails!.orderDetails![index].lot}",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        const Color(0XFF4D4D4D),
                                                    fontFamily: "Poppins"),
                                              ),
                                              sizedBoxHeight(2.h),
                                              Text(
                                                "€ ${double.parse(orderDetailsModel.data!.orderDetails!.orderDetails![index].itemUnitValue!) * orderDetailsModel.data!.orderDetails!.orderDetails![index].quantity!}",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0XFF141414),
                                                    fontFamily: "Poppins"),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              sizedBoxHeight(14.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text18w5004D4D4D('Total Amount'),
                                          text18w5004D4D4D(
                                              '€ ${orderDetailsModel.data!.orderDetails!.totalValue!}'),
                                        ]),
                                    sizedBoxHeight(15.h),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text18w5004D4D4D("Discount on MRP"),
                                          text18w5004D4D4D(orderDetailsModel
                                                      .data!
                                                      .orderDetails!
                                                      .discountType ==
                                                  "0"
                                              ? "- ${orderDetailsModel.data!.orderDetails!.discountValue} %"
                                              : '- € ${orderDetailsModel.data!.orderDetails!.discountValue}')
                                        ]),
                                    sizedBoxHeight(3.h),
                                    const Divider(
                                        thickness: 1,
                                        color: AppColors.buttoncolour),
                                    sizedBoxHeight(3.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        text18w5004D4D4D("Total Amount"),
                                        Row(
                                          children: [
                                            text18w5004D4D4D(
                                                "€ ${orderDetailsModel.data!.orderDetails!.netValue}"),
                                            sizedBoxWidth(11.h),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 2.h),
                                              child: Text(
                                                "(${orderDetailsModel.data!.orderDetails!.orderDetails!.length} Items)",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color:
                                                      const Color(0XFF4D4D4D),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              sizedBoxHeight(13.h),
                              InkWell(
                                onTap: () async {
                                  var permissionStatus =
                                      await Permission.storage.status;
                                  if (permissionStatus.isDenied) {
                                    await Permission.storage.request();
                                    permissionStatus =
                                        await Permission.storage.status;
                                    if (permissionStatus.isDenied) {
                                      await openAppSettings();
                                    }
                                  } else if (permissionStatus
                                      .isPermanentlyDenied) {
                                    await openAppSettings();
                                  } else {
                                    OrderApi()
                                        .downloadFile(
                                            "${ApiUrls.base}invoice/download/${orderDetailsModel.data!.orderDetails!.orderId!}",
                                            "invoice_${orderDetailsModel.data!.orderDetails!.orderId!}.pdf")
                                        .then((value) {});
                                  }
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Container(
                                    width: 358.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0XFF918E8E),
                                      ),
                                      color: AppColors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 15),
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
                                              color: const Color(0XFF0E5F02),
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              sizedBoxHeight(22.h),
                              orderDetailsModel
                                          .data!.orderDetails!.deliveryAgent ==
                                      null
                                  ? Center(
                                      child: Column(
                                        children: [
                                          LottieBuilder.asset(
                                            "assets/lotties/order_pending.json",
                                            width: 250,
                                            height: 150,
                                          ),
                                          Center(
                                            child: Text(
                                              "Your order is yet to be picked by our delivery agent",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors.buttoncolour,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(left: 51.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              sizedBoxHeight(8.h),
                                              status(),
                                              !orderDetailsModel
                                                      .data!.deliveryStatus!
                                                      .any((item) =>
                                                          item.deliveryStatusXid ==
                                                          7)
                                                  ? const DottedLine(
                                                      direction: Axis.vertical,
                                                      lineLength: 50,
                                                      lineThickness: 2.0,
                                                      dashLength: 4.0,
                                                      dashColor:
                                                          Color(0XFF0E5F02),
                                                    )
                                                  : const Dash(
                                                      direction: Axis.vertical,
                                                      length: 25,
                                                      dashLength: 49,
                                                      dashGap: 0,
                                                      dashColor:
                                                          Color(0XFF0E5F02)),
                                              status(),
                                              !orderDetailsModel
                                                      .data!.deliveryStatus!
                                                      .any((item) =>
                                                          item.deliveryStatusXid ==
                                                          5)
                                                  ? const DottedLine(
                                                      direction: Axis.vertical,
                                                      lineLength: 50,
                                                      lineThickness: 2.0,
                                                      dashLength: 4.0,
                                                      dashColor:
                                                          Color(0XFF0E5F02),
                                                    )
                                                  : const Dash(
                                                      direction: Axis.vertical,
                                                      length: 25,
                                                      dashLength: 49,
                                                      dashGap: 0,
                                                      dashColor:
                                                          Color(0XFF0E5F02)),
                                              status(),
                                              !orderDetailsModel
                                                      .data!.deliveryStatus!
                                                      .any((item) =>
                                                          item.deliveryStatusXid ==
                                                          4)
                                                  ? const DottedLine(
                                                      direction: Axis.vertical,
                                                      lineLength: 50,
                                                      lineThickness: 2.0,
                                                      dashLength: 4.0,
                                                      dashColor:
                                                          Color(0XFF0E5F02),
                                                    )
                                                  : const Dash(
                                                      direction: Axis.vertical,
                                                      length: 25,
                                                      dashLength: 49,
                                                      dashGap: 0,
                                                      dashColor:
                                                          Color(0XFF0E5F02)),
                                              status(),
                                            ],
                                          ),
                                          sizedBoxWidth(18.w),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              sizedBoxHeight(3.h),
                                              Text(
                                                "Delivered",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff141414),
                                                    fontFamily: "Poppins"),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  !orderDetailsModel
                                                          .data!.deliveryStatus!
                                                          .any((item) =>
                                                              item.deliveryStatusXid ==
                                                              7)
                                                      ? Text("Pending",
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff4D4D4D),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins"))
                                                      : Text(
                                                          Utils.convertUtcToCustomFormat(
                                                              orderDetailsModel
                                                                  .data!
                                                                  .deliveryStatus![
                                                                      4]
                                                                  .createdAt!),
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff4D4D4D),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins"),
                                                        ),
                                                ],
                                              ),
                                              sizedBoxHeight(15.h),
                                              Text(
                                                "Out For Delivery",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff141414),
                                                    fontFamily: "Poppins"),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  !orderDetailsModel
                                                          .data!.deliveryStatus!
                                                          .any((item) =>
                                                              item.deliveryStatusXid ==
                                                              5)
                                                      ? Text("Pending",
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff4D4D4D),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins"))
                                                      : Text(
                                                          Utils.convertUtcToCustomFormat(
                                                              orderDetailsModel
                                                                  .data!
                                                                  .deliveryStatus![
                                                                      3]
                                                                  .createdAt!),
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff4D4D4D),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins"),
                                                        ),
                                                ],
                                              ),
                                              sizedBoxHeight(15.h),
                                              Text(
                                                "Packed & Ready",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff141414),
                                                    fontFamily: "Poppins"),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  !orderDetailsModel
                                                          .data!.deliveryStatus!
                                                          .any((item) =>
                                                              item.deliveryStatusXid ==
                                                              4)
                                                      ? Text("Pending",
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff4D4D4D),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins"))
                                                      : Text(
                                                          Utils.convertUtcToCustomFormat(
                                                              orderDetailsModel
                                                                  .data!
                                                                  .deliveryStatus![
                                                                      2]
                                                                  .createdAt!),
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff4D4D4D),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins"),
                                                        ),
                                                ],
                                              ),
                                              sizedBoxHeight(15.h),
                                              Text(
                                                "Ordered",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff141414),
                                                    fontFamily: "Poppins"),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    Utils
                                                        .convertUtcToCustomFormat(
                                                            orderDetailsModel
                                                                .data!
                                                                .orderDetails!
                                                                .orderDate!),
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff4D4D4D),
                                                        fontWeight:
                                                            FontWeight.w400,
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
                              orderDetailsModel.data!.deliveryStatus!.isEmpty
                                  ? const SizedBox()
                                  : sizedBoxHeight(20.h),
                              orderDetailsModel.data!.deliveryStatus!.isEmpty
                                  ? const SizedBox()
                                  : !orderDetailsModel.data!.deliveryStatus!
                                              .any((item) =>
                                                  item.deliveryStatusXid ==
                                                  6) &&
                                          orderDetailsModel
                                              .data!.deliveryStatus!
                                              .any((item) =>
                                                  item.deliveryStatusXid != 7)
                                      ? const SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            width: 358.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.h),
                                                color: AppColors.buttoncolour),
                                            child: Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      'Share this OTP with your delivery agent: ',
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.white,
                                                      fontSize: 18.sp),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: orderDetailsModel
                                                          .data!.deliveryOtp,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 20.sp,
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                              orderDetailsModel.data!.deliveryStatus!.isNotEmpty
                                  ? SizedBox()
                                  : sizedBoxHeight(20.h),
                              orderDetailsModel.data!.deliveryStatus!.isNotEmpty
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: InkWell(
                                        onTap: () {
                                          buildordercalldialog(
                                            context,
                                            orderDetailsModel
                                                .data!.orderDetails!.salesman!,
                                          );
                                        },
                                        child: Container(
                                          height: 50.h,
                                          width: 358.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.h),
                                              color: AppColors.buttoncolour),
                                          child: Center(
                                            child: Text(
                                              "Cancel Order",
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              sizedBoxHeight(26.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  width: 358.w,
                                  // height: 108.h,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: AppColors.white,
                                      border: Border.all(
                                        color: const Color(0XFFC5C5C5),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFF00000029),
                                            blurRadius: 6.0,
                                            spreadRadius: 0)
                                      ]),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.w, top: 5.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 5.h),
                                          child: SvgPicture.asset(
                                            "assets/images/orderquestion.svg",
                                            width: 53.w,
                                            height: 53.h,
                                          ),
                                        ),

                                        sizedBoxWidth(10.w),

                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 9.h),
                                              child: Text(
                                                "Query With This Order?",
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    color:
                                                        const Color(0XFF141414),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                            sizedBoxHeight(3.h),
                                            InkWell(
                                              onTap: () {
                                                buildordercalldialog(
                                                  context,
                                                  orderDetailsModel.data!
                                                      .orderDetails!.salesman!,
                                                );
                                              },
                                              child: Container(
                                                height: 36.h,
                                                width: 213.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.h),
                                                    color: const Color(
                                                        0XFFF1F1F1)),
                                                child: Center(
                                                  child: Text(
                                                    "Contact Customer Service",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .buttoncolour,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
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
                              sizedBoxHeight(18.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  width: 358.w,
                                  // height: 115.h,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color(0XFFF1F1F1),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF00000029),
                                            blurRadius: 6.0,
                                            spreadRadius: 0)
                                      ]),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.w, top: 5.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Order Summary",
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    color:
                                                        const Color(0XFF141414),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins"),
                                              ),
                                              sizedBoxHeight(8.h),
                                              // Text(
                                              //   "Order g: 408-0073624-7437935",
                                              //   style: TextStyle(
                                              //       fontSize: 14.sp,
                                              //       color:
                                              //           const Color(0XFF141414),
                                              //       fontFamily: "Poppins"),
                                              // ),
                                              // sizedBoxHeight(7.h),
                                              Text(
                                                "Ordered: ${Utils.convertDate(orderDetailsModel.data!.orderDetails!.orderDate!)}",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color:
                                                        const Color(0XFF141414),
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
                              orderDetailsModel.data!.orderHistory!.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        "Order History",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: const Color(0XFF141414),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                              orderDetailsModel.data!.orderHistory!.isEmpty
                                  ? const SizedBox()
                                  : sizedBoxHeight(8.h),
                              orderDetailsModel.data!.orderHistory!.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          width: Get.width,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: const Color(0xFFe2e2e2)),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text("ID"),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text("Date"),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text("Price"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Gap(8),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: orderDetailsModel
                                                .data!.orderHistory!.length,
                                            itemBuilder: (ctx, index) {
                                              return AnimatedContainer(
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.fastOutSlowIn,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 5,
                                                ),
                                                width: Get.width,
                                                height: 60.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: const Color(
                                                        0xFFf6f6f6)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 25),
                                                  child: Column(
                                                    children: [
                                                      const Gap(15),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                "${index + 1}"),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                                orderDetailsModel
                                                                    .data!
                                                                    .orderHistory![
                                                                        index]
                                                                    .deliveryDate!),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                "€ ${orderDetailsModel.data!.orderHistory![index].netValue}"),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                              sizedBoxHeight(20.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
