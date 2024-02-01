import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/controller/notification_controller.dart';
import 'package:farmfeeders/view_models/ConnectionCodeApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Utils/sized_box.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  // List<Map<String, String>> _data = [];
  NotificationController controllerNotification =
      Get.put(NotificationController());

  @override
  void initState() {
    controllerNotification.getNotificationData();
    // _data = [
    //   {
    //     "image": "assets/images/Notification.svg",
    //     "title": "Your feed is getting low!.",
    //     "subtitle": "Farm Feed Is Down To 8%. \nPlease Refill It Quickly.",
    //     "text": "12.00 PM",
    //   },
    //   {
    //     "image": "assets/images/Notification1.svg",
    //     "title": "Order is arriving soon.",
    //     "subtitle": "Your Order Has Left The \nWarehouse And Is On Its Way!",
    //     "text": "11.00 PM",
    //   },
    // ];
    super.initState();
  }

  buildconnectdialog2(context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor:
                    Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
                contentPadding: EdgeInsets.fromLTRB(57.w, 46.h, 57.w, 21.h),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Get.isDarkMode
                          ? Colors.grey
                          : const Color(0XFFFFFFFF)),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //sizedBoxHeight(46.h),

                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/images/profilrcheck.svg",
                        width: 67.w,
                        height: 67.h,
                      ),
                    ),
                    sizedBoxHeight(21.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    sizedBoxHeight(28.h)
                  ],
                ),
              ),
            ],
          );
        });
  }

  buildconnectiondialog(
    context,
    int id,
    String name,
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
                sizedBoxHeight(32.h),
                // Align(
                //   alignment: Alignment.center,
                //   child: Image.asset(
                //     "assets/images/bin@2x.png",
                //     width: 35.w,
                //     height: 34.h,
                //   ),
                // ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Approve the connection request for ${name}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        ConnectionCodeApi()
                            .approveConnectionCodeApi(id)
                            .then((value) {
                          print(value.data["message"]);
                          Navigator.pop(context);
                          buildconnectdialog2(context, value.data["message"]);
                        });
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
    return WillPopScope(
      onWillPop: () async {
        controllerNotification.notificationCount.value = "0";
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child:
              // CustomScrollView(
              //   slivers: [
              //     SliverToBoxAdapter(
              // child:
              Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 18.w, top: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controllerNotification.notificationCount.value = "0";
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
                                color: const Color(0xFF141414),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(
                          color: const Color(0xFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    // Spacer(),
                    // Container(
                    //   height: 42.h,
                    //   width: 42.h,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(25.h),
                    //       color: AppColors.white,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.shade400,
                    //           blurRadius: 1.h,
                    //           spreadRadius: 1.h,
                    //           offset: Offset(0, 3),
                    //         )
                    //       ]),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           Get.toNamed("/notificationSettings");
                    //         },
                    //         child: SvgPicture.asset(
                    //           "assets/images/setting-svgrepo-com (1).svg",
                    //           width: 23.w,
                    //           height: 24.h,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GetBuilder<NotificationController>(builder: (builder) {
                        return controllerNotification.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: AppColors.buttoncolour,
                              ))
                            : controllerNotification.notificationData == null
                                ? Center(
                                    child: Text(
                                      // _data[index]['title'] ?? "",
                                      "Something went wrong",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : (controllerNotification.notificationData!.data
                                            .today.isEmpty &&
                                        controllerNotification.notificationData!
                                            .data.yesterday.isEmpty &&
                                        controllerNotification.notificationData!
                                            .data.other.isEmpty)
                                    ? Center(
                                        child: Text(
                                          // _data[index]['title'] ?? "",
                                          "No Notifications available",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          //today
                                          controllerNotification
                                                  .notificationData!
                                                  .data
                                                  .today
                                                  .isEmpty
                                              ? const SizedBox()
                                              : Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16.w),
                                                          child: Text(
                                                            "Today",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.w),
                                                      child: ListView.separated(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            controllerNotification
                                                                .notificationData!
                                                                .data
                                                                .today
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final data =
                                                              controllerNotification
                                                                  .notificationData!
                                                                  .data
                                                                  .today[index];
                                                          String originalDate =
                                                              data.readAt;
                                                          DateTime parsedDate =
                                                              DateTime.parse(
                                                                  originalDate);
                                                          String formattedDate =
                                                              DateFormat.jm()
                                                                  .format(
                                                                      parsedDate);
                                                          return InkWell(
                                                            onTap: () {
                                                              if (data.title ==
                                                                  "Connection Request") {
                                                                var dataV =
                                                                    jsonDecode(
                                                                        data.data);

                                                                buildconnectiondialog(
                                                                    context,
                                                                    dataV[
                                                                        "salesman_xid"],
                                                                    dataV[
                                                                        "salesman_name"]);
                                                              }
                                                            },
                                                            child:
                                                                NotificationCard(
                                                              imageUrl:
                                                                  data.image,
                                                              title: data.title,
                                                              msg: data.message,
                                                              dateTime:
                                                                  formattedDate,
                                                            ),
                                                          );
                                                          // );
                                                        },
                                                        separatorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Divider(
                                                            height: 40.h,
                                                            thickness: 1,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                  ],
                                                ),

                                          //yesterday
                                          controllerNotification
                                                  .notificationData!
                                                  .data
                                                  .yesterday
                                                  .isEmpty
                                              ? const SizedBox()
                                              : Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16.w),
                                                          child: Text(
                                                            "Yesterday",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.w),
                                                      child: ListView.separated(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            controllerNotification
                                                                .notificationData!
                                                                .data
                                                                .yesterday
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final data =
                                                              controllerNotification
                                                                  .notificationData!
                                                                  .data
                                                                  .yesterday[index];
                                                          String originalDate =
                                                              data.readAt;
                                                          DateTime parsedDate =
                                                              DateTime.parse(
                                                                  originalDate);
                                                          String formattedDate =
                                                              DateFormat.jm()
                                                                  .format(
                                                                      parsedDate);
                                                          return InkWell(
                                                            onTap: () {
                                                              if (data.title ==
                                                                  "Connection Request") {
                                                                var dataV =
                                                                    jsonDecode(
                                                                        data.data);

                                                                buildconnectiondialog(
                                                                    context,
                                                                    dataV[
                                                                        "salesman_xid"],
                                                                    dataV[
                                                                        "salesman_name"]);
                                                              }
                                                            },
                                                            child:
                                                                NotificationCard(
                                                              imageUrl:
                                                                  data.image,
                                                              title: data.title,
                                                              msg: data.message,
                                                              dateTime:
                                                                  formattedDate,
                                                            ),
                                                          );
                                                          // );
                                                        },
                                                        separatorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Divider(
                                                            height: 40.h,
                                                            thickness: 1,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                  ],
                                                ),

                                          //earlier
                                          controllerNotification
                                                  .notificationData!
                                                  .data
                                                  .other
                                                  .isEmpty
                                              ? const SizedBox()
                                              : Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16.w),
                                                          child: Text(
                                                            "Earlier",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.w),
                                                      child: ListView.separated(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            controllerNotification
                                                                .notificationData!
                                                                .data
                                                                .other
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final data =
                                                              controllerNotification
                                                                  .notificationData!
                                                                  .data
                                                                  .other[index];
                                                          String originalDate =
                                                              data.readAt;
                                                          DateTime parsedDate =
                                                              DateTime.parse(
                                                                  originalDate);
                                                          String formattedDate =
                                                              DateFormat(
                                                                      'd MMM y')
                                                                  .format(
                                                                      parsedDate);
                                                          return InkWell(
                                                            onTap: () {
                                                              if (data.title ==
                                                                  "Connection Request") {
                                                                var dataV =
                                                                    jsonDecode(
                                                                        data.data);

                                                                buildconnectiondialog(
                                                                    context,
                                                                    dataV[
                                                                        "salesman_xid"],
                                                                    dataV[
                                                                        "salesman_name"]);
                                                              }
                                                            },
                                                            child:
                                                                NotificationCard(
                                                              imageUrl:
                                                                  data.image,
                                                              title: data.title,
                                                              msg: data.message,
                                                              dateTime:
                                                                  formattedDate,
                                                            ),
                                                          );
                                                          // );
                                                        },
                                                        separatorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Divider(
                                                            height: 40.h,
                                                            thickness: 1,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      );
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
          // ),
          //],
          //),
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  String imageUrl;
  String title;
  String msg;
  String dateTime;
  NotificationCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.msg,
    required this.dateTime,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SvgPicture.asset(
              //   // _data[index]['image']!,
              //   "assets/images/Notification.svg",
              //   width: 42,
              //   height: 42,
              //   fit: BoxFit.cover,
              // ),
              // NetworkImage("url"),
              CachedNetworkImage(
                imageUrl: ApiUrls.baseImageUrl + widget.imageUrl,
                width: 42.w,
                height: 42.w,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 13.h,
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // _data[index]['title'] ?? "",
                        // "Your feed is getting low!.",
                        widget.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        // _data[index]['subtitle']!
                        // data.message,
                        widget.msg,
                        style: TextStyle(
                          color: const Color(0xFF444444),
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: Text(
                    // _data[index]['text']!,
                    // formattedDate,
                    widget.dateTime,
                    style: TextStyle(
                      color: const Color(0xFF707070),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
