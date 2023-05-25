import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                      "Notification Settings",
                      style: TextStyle(
                          color: Color(0xFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/notification");
                      },
                      child: SvgPicture.asset(
                        "assets/images/Notificationicon.svg",
                        width: 20.w,
                        height: 24.h,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        // padding: EdgeInsets.all(10),
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
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "Order Details And Alerts",
                statecontroller: fingerstate,
                // sizefactor: MediaQuery.of(context).size.width * 0.39,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "Stock Alerts",
                statecontroller: fingerstate,
                //sizefactor: MediaQuery.of(context).size.width * 0.4,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
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
    //required this.sizefactor
  }) : super(key: key);

  final String? title;
  bool statecontroller;
  //double sizefactor;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: 18,
                color: Color(0XFF4D4D4D),
              ),
            ),
            Spacer(),
            FlutterSwitch(
              switchBorder: Border.all(
                strokeAlign: BorderSide.strokeAlignCenter,
                style: BorderStyle.solid,
                width: 1,
                color: const Color(0xffCCCCCC),
              ),
              width: 50.0,
              height: 25.0,
              toggleColor: Color(0xFF0E5F02),
              activeColor: AppColors.white,
              inactiveColor: Colors.white,
              inactiveToggleColor: Color(0xff686868),
              value: widget.statecontroller,
              onToggle: (val) {
                setState(() {
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
