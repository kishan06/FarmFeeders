import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {

  // List<Map<String, String>> _data = [];
  NotificationController controllerNotification = Get.put(NotificationController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  color: Color(0xFF141414),
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
                            color: Color(0xFF141414),
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
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GetBuilder<NotificationController>(builder: (builder){
                        return controllerNotification.isLoading 
                        ? Center(child: CircularProgressIndicator())
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
                        : Column(
                          children: [
                            
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Text(
                                    "Today",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: controllerNotification.notificationData!.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = controllerNotification.notificationData!.data[index];
                                  String originalDate = data.createdAt;
                                          DateTime parsedDate =
                                              DateTime.parse(originalDate);
                                          String formattedDate =
                                              DateFormat.Hm().format(parsedDate);
                                  return Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              // _data[index]['image']!,
                                              "assets/images/Notification.svg",
                                              width: 42,
                                              height: 42,
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // _data[index]['title'] ?? "",
                                                      "Your feed is getting low!.",
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      // _data[index]['subtitle']!
                                                      data.message,
                                                      style: TextStyle(
                                                        color: Color(0xFF444444),
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
                                                  formattedDate,
                                                  style: TextStyle(
                                                    color: Color(0xFF707070),
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
                                  // );
                                },
                                separatorBuilder: (BuildContext context, int index) {
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
                        );
                        
                      }),
                    ],
                  ),
                )

                
             ],
            ),
        // ),
        //],
        //),
      ),
    );
  }
}
