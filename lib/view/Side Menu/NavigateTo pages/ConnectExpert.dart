import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/view/Side%20Menu/Connectexpertdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Color(0XFf0E5F02), width: 1)),
                      child: ButtonsTabBar(
                        buttonMargin: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(left: 28, right: 28),
                        radius: 8,
                        backgroundColor: Color(0XFf0E5F02),
                        unselectedBorderColor: Colors.white,
                        //borderWidth: 1,
                        //borderColor: Color(0XFf0E5F02),
                        unselectedBackgroundColor: Color(0xFFFFFFFF),
                        unselectedLabelStyle:
                            TextStyle(color: Color(0xFF0F0C0C)),
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
                            text: "Vets",
                          ),
                          Tab(
                            text: "Repairmen",
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          FirstTab(),
                          FirstTab(),
                          FirstTab(),
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
    );
  }
}

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  buildcontentcalldialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Get.isDarkMode ? Colors.black : Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/contentcall.svg",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to call Advisor?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
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
                            border: Border.all(color: Color(0XFF0E5F02)),
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

  buildcontentdialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Get.isDarkMode ? Colors.black : Color(0XFFFFFFFF),
            contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Image.asset(
                  "assets/images/connectperson.png",
                  width: 76.w,
                  height: 76.h,
                ),
                SizedBox(
                  height: 11.h,
                ),
                Text(
                  "Roma dsouza",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/call.svg",
                      width: 19.w,
                      height: 18.h,
                    ),
                    sizedBoxWidth(5.w),
                    Text(
                      "0225845855",
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontSize: 20.sp,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/locationconnect.svg",
                      width: 13.w,
                      height: 18.h,
                    ),
                    sizedBoxWidth(5.w),
                    Text(
                      "Canada",
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontSize: 20.sp,
                      ),
                    )
                  ],
                ),
                sizedBoxHeight(25.h),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    buildcontentcalldialog(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: AppColors.buttoncolour),
                    child: Center(
                      child: Text(
                        "Call",
                        style:
                            TextStyle(color: AppColors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            sizedBoxHeight(32.h),
            // GestureDetector(
            //   onTap: () {
            //     buildcontentdialog(context);
            //   },
            //   child:
            ListView.separated(
              separatorBuilder: (context, index) {
                return sizedBoxHeight(15.h);
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: expertData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    connectcard(
                      expertData[index]["image"],
                      expertData[index]["tittle"],
                      expertData[index]["number"],
                      expertData[index]["location"],
                      index,
                      expertData[index]["isConnect"],
                    )
                  ],
                );
              },
            ),
            sizedBoxHeight(15.h),
          ],
        ),
      ),
    );
  }

  Widget connectcard(dynamic image, dynamic tittle, dynamic number,
      dynamic location, int index, int isConnect) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Color(0XFf0E5F02).withOpacity(1), width: 1),
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 11.h,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 3,
                        color: isConnect == 0 ? Colors.amber : Colors.white),
                    borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                  ),
                  child: Image.asset(
                    image,
                    // "assets/images/connect2.png",
                    width: 66.w,
                    height: 66.w,
                  ),
                ),
              ),
              sizedBoxWidth(8.w),
              SizedBox(
                width: 195.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: tittle,
                        // "Roma dsouza",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/call.svg",
                          width: 13.w,
                          height: 13.w,
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: number,
                            // "0225845855",
                            style: TextStyle(
                              color: Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: SvgPicture.asset(
                            "assets/images/locationconnect.svg",
                            width: 13.w,
                            height: 13.w,
                          ),
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: location,
                            // "Canada",
                            style: TextStyle(
                              color: Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              // sizedBoxWidth(16.w),

              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                  icon: isConnect == 0
                      // _isChecked
                      ? CircleAvatar(
                          radius: 25.h,
                          backgroundColor: Color(0XFFF1F1F1),
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        )
                      : Icon(
                          Icons.star_border,
                          color: Color(0XFF707070),
                        ),
                  onPressed: () {
                    setState(() {
                      expertData[index]["isConnect"] = isConnect == 0 ? 1 : 0;
                      // _isChecked = !_isChecked;
                    });
                  },
                ),
              ]),

              // SvgPicture.asset(
              //   "assets/images/starconnect.svg",
              //   width: 38.w,
              //   height: 38.w,
              // ),

              // CircleAvatar(
              //   radius: 25.h,
              //   backgroundColor: Color(0XFFF1F1F1),
              //   child: Center(
              //     child: Icon(
              //       Icons.star,
              //       size: 35.h,
              //       color: Color.fromARGB(255, 248, 211, 2),
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 11.h,
          )
        ],
      ),
    );
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
