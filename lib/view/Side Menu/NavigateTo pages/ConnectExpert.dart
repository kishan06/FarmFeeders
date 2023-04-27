import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Utils/sized_box.dart';

class ConnectExperts extends StatefulWidget {
  const ConnectExperts({super.key});

  @override
  State<ConnectExperts> createState() => _ConnectExpertsState();
}

class _ConnectExpertsState extends State<ConnectExperts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.w),
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
                      "Connect With Experts",
                      style: TextStyle(
                        color: Color(0XFF141414),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxHeight(20.h),
              Expanded(
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      ButtonsTabBar(
                        buttonMargin: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(left: 17, right: 17),
                        radius: 8,
                        backgroundColor: Color(0XFf0E5F02),
                        unselectedBorderColor: Color(0XFf0E5F02),
                        borderWidth: 2,
                        borderColor: Color(0XFf0E5F02),
                        unselectedBackgroundColor: Color(0xFFFFFFFF),
                        unselectedLabelStyle: TextStyle(color: Color(0xFF0F0C0C)),
                        labelStyle: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        tabs: [
                          Tab(
                            text: "Advisor",
                          ),
                          Tab(
                            text: "Vetenarian",
                          ),
                          Tab(
                            text: "Repairmen",
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            FirstTab(),
                            SecondTab(),
                            ThirdTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ThirdTab extends StatelessWidget {
  const ThirdTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
