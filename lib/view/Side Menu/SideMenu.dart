import 'dart:math';
import 'package:farmfeeders/Utils/colors.dart';

import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';

import 'package:farmfeeders/common/custom_appbar.dart';

import 'package:farmfeeders/view/Home.dart';
import 'package:farmfeeders/view/LoginScreen.dart';
import 'package:farmfeeders/view/order.dart';
import 'package:farmfeeders/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

import 'side_bar.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late bool logedIn;

  var screens = [
    const Order(),
    const Home(),

    const Profile(),
    // const ChatPage(),
    // const MarketTab(),
  ];

  List bottomBarData = [
    {
      "imageUrl":"assets/images/bottom_icon1_i.svg",
      "label":"Order"
    },
    {
      "imageUrl":"assets/images/bottom_icon2.svg",
      "label":"Dashboard"
    },
    // /
    {
      "imageUrl":"assets/images/bottom_icon3.svg",
      "label":"Profile"
    },
  ];

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  left: isSideMenuClosed ? -300.w : 0,
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
                    offset: Offset(animation.value * 300.w, 0),
                    child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(isSideMenuClosed ? 0 : 24)),
                        child: screens[selectedIndex]
                        // const 
                        // Center(child: Home()),
                      ),
                    ),
                  ),
                ),
                selectedIndex == 1 ? AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  top: 5.h,
                  left: 4.w,
                  child: IconButton(
                    onPressed: () {
                      if (isSideMenuClosed) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                      setState(() {
                        isSideMenuClosed = !isSideMenuClosed;
                      });
                    },
                    icon: isSideMenuClosed
                        ? Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade100,
                            ),
                            child: Icon(
                              Icons.menu,
                              color: Colors.black,
                              size: 29.w,
                            ),
                          ) 
                        : Icon(
                            Icons.cancel,
                            size: 29.w,
                            color: Colors.white,
                          ),
                  ),
                ) : SizedBox(),
              ],
            ),
            bottomNavigationBar: isSideMenuClosed
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
                
                      borderRadius: BorderRadius.circular(35.h)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) => 
                          activeIcon("assets/images/bottom_icon1_i.svg",index)
                        )
                      ),
                    ),
                  ),
                )

                : const SizedBox()),
      ),
    );
  }

  Widget activeIcon(String imagePath,int index) {
    return InkWell(
      onTap: (){
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
          color: selectedIndex == index ? AppColors.buttoncolour : AppColors.greyF1F1F1
        ),
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
                color: selectedIndex == index ?AppColors.white : AppColors.buttoncolour,
                fit: BoxFit.fill,
                // color: AppColors.greyD3B3F43,
                // colorFilter: AppColors.greyD3B3F43,
              ),
            ),
    
            selectedIndex == index ? sizedBoxWidth(10.w) : SizedBox(), 
    // /
            selectedIndex == index ? textWhite16(bottomBarData[index]["label"]) : SizedBox()
    
    
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
