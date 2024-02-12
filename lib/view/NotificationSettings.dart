import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/models/video_detail_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/sub_user_controller.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool state = false;
  bool fingerstate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Notification Settings",
                      style: TextStyle(
                          color: const Color(0xFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Container(
                      height: 42.h,
                      width: 42.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.h),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 1.h,
                              spreadRadius: 1.h,
                              offset: const Offset(0, 3),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed("/notification");
                            },
                            child: SvgPicture.asset(
                              "assets/images/Notificationicon.svg",
                              width: 23.w,
                              height: 24.h,
                            ),
                          ),
                        ],
                      ),
                    )

                    // ElevatedButton(
                    //   onPressed: () {
                    //     Get.toNamed("/notification");
                    //   },
                    //   child: SvgPicture.asset(
                    //     "assets/images/Notificationicon.svg",
                    //     width: 20.w,
                    //     height: 24.h,
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     shape: CircleBorder(),
                    //     // padding: EdgeInsets.all(10),
                    //     elevation: 2,
                    //     backgroundColor: AppColors.white,
                    //     shadowColor: Color(0xFF444444), // <-- Splash color
                    //   ),
                    // )
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
                      "Set Up Alert Notification",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 39.h,
              ),
              CustomListTile(
                title: "Pending Profile Reminder",
                statecontroller: state,
                //sizefactor: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "Order Details And Alerts",
                statecontroller: fingerstate,
                // sizefactor: MediaQuery.of(context).size.width * 0.39,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "Stock Alerts",
                statecontroller: fingerstate,
                //sizefactor: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "News & Article Alerts",
                statecontroller: fingerstate,
                //  sizefactor: MediaQuery.of(context).size.width * 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  CustomListTile({
    Key? key,
    required this.title,
    required this.statecontroller,
    this.addVideoPage = false,
    this.id = 0,
    this.isUpdate = false,

    //required this.sizefactor
  }) : super(key: key);

  final String? title;
  bool statecontroller;
  bool addVideoPage;
  int id;
  bool isUpdate;
  //double sizefactor;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  SubUserController subUserController = Get.put(SubUserController());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate) {
      if (dashboardController.videoData.videoAccess!
          .any((access) => access.iamPrincipalXid == widget.id)) {
        setState(() {
          widget.statecontroller = true;
        });
        subUserController.selectedIds.add(widget.id);
      }
    }
    return SizedBox(
      height: 60.h,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.addVideoPage ? 0 : 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: 20.sp,
                // color: Color(0XFF4D4D4D),
              ),
            ),
            const Spacer(),
            FlutterSwitch(
              switchBorder: Border.all(
                strokeAlign: BorderSide.strokeAlignCenter,
                style: BorderStyle.solid,
                width: 1,
                color: const Color(0xffCCCCCC),
              ),
              width: 50.0,
              height: 25.0,
              toggleColor: const Color(0xFF0E5F02),
              activeColor: AppColors.white,
              inactiveColor: Colors.white,
              inactiveToggleColor: const Color(0xff686868),
              value: widget.statecontroller,
              onToggle: (val) {
                setState(() {
                  if (subUserController.selectedIds.contains(widget.id)) {
                    subUserController.selectedIds.remove(widget.id);
                    if (widget.isUpdate) {
                      dashboardController.videoData.videoAccess!.removeWhere(
                          (element) => element.iamPrincipalXid == widget.id);
                    }
                  } else {
                    subUserController.selectedIds.add(widget.id);
                    if (widget.isUpdate) {
                      dashboardController.videoData.videoAccess!
                          .add(VideoAccess(iamPrincipalXid: widget.id));
                    }
                  }
                  widget.statecontroller = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
