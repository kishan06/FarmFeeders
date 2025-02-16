import 'dart:math' hide log;

import 'package:farmfeeders/Utils/colors.dart';

import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/view/Home.dart';
import 'package:farmfeeders/view/profile.dart';
import 'package:farmfeeders/view/renew_subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/dialog/exit_app_dialog.dart';
import '../YourOrder/yourordermain.dart';
import 'side_bar.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late bool logedIn;
  DashboardController dashboardController = Get.put(DashboardController());
  String loginStatus = "";

  var screens = [
    const Yourorder(),
    const Home(),
    const Profile(),
  ];

  List bottomBarData = [
    {"imageUrl": "assets/images/bottom_icon1_i.svg", "label": "Order"},
    {"imageUrl": "assets/images/bottom_icon2.svg", "label": "Dashboard"},
    {"imageUrl": "assets/images/bottom_icon3.svg", "label": "Profile"},
  ];

  @override
  void initState() {
    getData();

    dashboardController.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: dashboardController.animationController,
        curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: dashboardController.animationController,
        curve: Curves.fastOutSlowIn));
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginStatus = prefs.getString("loginStatus")!;

    if (loginStatus == "Subscription Inactive and Orders Pending") {
      screens = [
        const Yourorder(),
        const RenewSubscriptionScreen(),
        const RenewSubscriptionScreen(),
      ];

      setState(() {});
    }
  }

  @override
  void dispose() {
    dashboardController.animationController.dispose();
    super.dispose();
  }

  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => backbuttonpressed(context),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
                backgroundColor: const Color(0xff0E5F02),
                resizeToAvoidBottomInset: false,
                extendBody: true,
                body: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      left: dashboardController.isSideMenuClosed.value
                          ? -300.w
                          : 0,
                      width: 300.w,
                      height: MediaQuery.of(context).size.height,
                      child: const SideBar(),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                            animation.value - 30 * animation.value * pi / 180),
                      child: Transform.translate(
                        offset: Offset(animation.value * 270.w, 0),
                        child: Transform.scale(
                          scale: scaleAnimation.value,
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  dashboardController.isSideMenuClosed.value
                                      ? 0
                                      : 24)),
                              child: screens[selectedIndex]
                              // const
                              // Center(child: Home()),
                              ),
                        ),
                      ),
                    ),
                    loginStatus == "Subscription Inactive and Orders Pending"
                        ? const SizedBox()
                        : selectedIndex == 1
                            ? AnimatedPositioned(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.fastOutSlowIn,
                                top: 5.h,
                                left: 4.w,
                                child: IconButton(
                                  iconSize: 50.h,
                                  onPressed: () {
                                    if (dashboardController
                                        .isSideMenuClosed.value) {
                                      dashboardController.animationController
                                          .forward();
                                    } else {
                                      dashboardController.animationController
                                          .reverse();
                                    }
                                    setState(() {
                                      dashboardController
                                              .isSideMenuClosed.value =
                                          !dashboardController
                                              .isSideMenuClosed.value;
                                    });
                                  },
                                  icon:
                                      dashboardController.isSideMenuClosed.value
                                          ? Container(
                                              height: 42.h,
                                              width: 42.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.h),
                                                color: AppColors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade400,
                                                    blurRadius: 5.h,
                                                    spreadRadius: 2.h,
                                                  )
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/images/menu.svg",
                                                    height: 18.h,
                                                    width: 18.h,
                                                    color: AppColors.black,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Icon(
                                              Icons.cancel,
                                              size: 29.w,
                                              color: Colors.white,
                                            ),
                                ),
                              )
                            : const SizedBox(),
                  ],
                ),
                bottomNavigationBar: dashboardController.isSideMenuClosed.value
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5.h,
                                  spreadRadius: 2.h,
                                )
                              ],
                              borderRadius: BorderRadius.circular(35.h)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    3,
                                    (index) => activeIcon(
                                        "assets/images/bottom_icon1_i.svg",
                                        index))),
                          ),
                        ),
                      )
                    : const SizedBox()),
          ),
        ),
      ),
    );
  }

  Widget activeIcon(String imagePath, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        // selectedIndex = index;
      },
      child: Container(
        height: 50.h,
        width: selectedIndex == index ? 210.w : 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.h),
            color: selectedIndex == index
                ? AppColors.buttoncolour
                : AppColors.greyF1F1F1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 22.h,
              width: 22.h,
              child: SvgPicture.asset(
                bottomBarData[index]["imageUrl"],
                // height: 35.h,
                // width: 35.h,
                color: selectedIndex == index
                    ? AppColors.white
                    : AppColors.buttoncolour,
                fit: BoxFit.fill,
                // color: AppColors.greyD3B3F43,
                // colorFilter: AppColors.greyD3B3F43,
              ),
            ),

            selectedIndex == index ? sizedBoxWidth(10.w) : const SizedBox(),
            // /
            selectedIndex == index
                ? textWhite16(bottomBarData[index]["label"])
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget inactiveIcon(String imagePath) {
    return Column(children: [
      SvgPicture.asset(
        imagePath,
        height: 35.h,
        width: 35.h,
        color: AppColors.buttoncolour,
      ),
    ]);
  }
}
