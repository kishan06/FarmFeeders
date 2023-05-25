import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  List<Map<String, String>> _data = [];
  @override
  void initState() {
    _data = [
      {
        "image": "assets/images/Notification.svg",
        "title": "Your feed is getting low!.",
        "subtitle": "Lorem Ipsum Is Simply Dummy \nText Of The Printing And",
        "text": "12.00 PM",
      },
      {
        "image": "assets/images/Notification1.svg",
        "title": "Order is arriving soon.",
        "subtitle": "Lorem Ipsum Is Simply Dummy \nText Of The Printing And",
        "text": "11.00 PM",
      },
    ];
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
            SingleChildScrollView(
          child: Column(
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
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/settings");
                      },
                      child: SvgPicture.asset(
                        "assets/images/setting-svgrepo-com (1).svg",
                        width: 23.w,
                        height: 24.h,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        // padding: EdgeInsets.all(1),
                        elevation: 2,
                        backgroundColor: AppColors.white,
                        shadowColor: Color(0xFF444444), // <-- Splash color
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
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
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                _data[index]['image']!,
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
                                        _data[index]['title'] ?? "",
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
                                        _data[index]['subtitle']!,
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
                                    _data[index]['text']!,
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Yesterday",
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
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                _data[index]['image']!,
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
                                        _data[index]['title'] ?? "",
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
                                        _data[index]['subtitle']!,
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
                                    //"fvsv",
                                    _data[index]['text']!,
                                    //_data[index]['text'] ?? "",
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
            ],
          ),
        ),
        // ),
        //],
        //),
      ),
    );
  }
}
