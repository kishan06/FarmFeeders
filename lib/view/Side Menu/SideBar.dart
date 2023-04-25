import 'package:farmfeeders/Utils/SizedBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    // required this.press, required this.currentIndex
  });

  @override
  State<SideBar> createState() => _SideBarState();

  // final VoidCallback press;
  // final int currentIndex;
}

class _SideBarState extends State<SideBar> {
  // final ProfileImageController editProfileImage =
  //     Get.put(ProfileImageController());

  List sideBarData = [
    {"imagePath": "assets/1.png", "text": "Manage User"},
    {"imagePath": "assets/1.png", "text": "Connect With Experts"},
    {"imagePath": "assets/1.png", "text": "Training"},
    {"imagePath": "assets/1.png", "text": "News & Articles"},
    {"imagePath": "assets/1.png", "text": "FAQ"},
    {"imagePath": "assets/1.png", "text": "Feedback"},
    {"imagePath": "assets/1.png", "text": "Contact Us"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 300.w,
          height: double.infinity,
          decoration: const BoxDecoration(color: Color(0xff0E5F02)),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 45.w, 10.h),
              child: Column(
                children: [
                  sizedBoxHeight(80.h),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                height: 26.h,
                                width: 26.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 65.w,
                              width: 65.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/1.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5.h,
                              right: 5,
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: const Color(0xff0E5F02),
                                size: 15.h,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxWidth(15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kevin Mounsey',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            sizedBoxHeight(4.h),
                            Text(
                              "0248765121",
                              style: TextStyle(fontSize: 16.sp),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBoxHeight(60.h),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: sideBarData.length,
                    itemBuilder: (_, index) {
                      return SideBarTile(
                        image: sideBarData[index]["imagePath"],
                        text: sideBarData[index]["text"],
                        onTap: () {
                          navigateTo(index, context);
                        },
                      );
                    },
                  ),
                  sizedBoxHeight(80.h),
                  GestureDetector(
                    onTap: () {
                      logoutDailog(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: Image.asset(
                            'assets/1.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 22.w,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void navigateTo(int index, BuildContext context) {
  switch (index) {
    case 0:
      {
        null;
      }
      break;

    default:
      {
        null;
      }
  }
}

Future<dynamic> logoutDailog(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) {
      return Container(
        color: Colors.blue,
        margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Text(
                'Are you sure want to log out?',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 17.sp, color: const Color(0xFF444444)),
              ),
            ),
            SizedBox(
              height: 37.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: const Text('Login')),
            ),
            SizedBox(
              height: 27.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              child: GestureDetector(
                onTap: () {
                  print("going to homepage");
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xFFffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0, // soften the shadow
                        spreadRadius: 0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 5  horizontally
                          2.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class SideBarTile extends StatelessWidget {
  String image;
  String text;
  void Function()? onTap;

  SideBarTile({
    required this.image,
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                SizedBox(
                  height: 30.h,
                  width: 30.h,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 22.w,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
