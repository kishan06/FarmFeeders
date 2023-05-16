import 'dart:math';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/view/Home.dart';
import 'package:farmfeeders/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  var selectedIndex = 0;

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
                        child: const Center(child: Home()),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
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
                ),
              ],
            ),
            bottomNavigationBar: isSideMenuClosed
                ? BottomNavigationBar(
                    selectedLabelStyle: TextStyle(fontSize: 12.sp),
                    unselectedLabelStyle: TextStyle(fontSize: 12.sp),
                    iconSize: 20.h,
                    selectedItemColor: const Color(0xff143C6D),
                    unselectedItemColor: Colors.black,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        activeIcon: Icon(Icons.abc),
                        icon: Icon(Icons.ac_unit),
                        label: "1111",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(Icons.abc),
                        icon: Icon(Icons.ac_unit),
                        label: "2222",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(Icons.abc),
                        icon: Icon(Icons.ac_unit),
                        label: "3333",
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (int index) {
                      selectedIndex = index;
                      setState(() {});
                    },
                  )
                : const SizedBox()),
      ),
    );
  }
}
