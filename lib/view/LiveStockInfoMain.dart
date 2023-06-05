// import 'dart:html';

import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_dropdown.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LiveStockInfoLive extends StatefulWidget {
  const LiveStockInfoLive({super.key});

  @override
  State<LiveStockInfoLive> createState() => _LiveStockInfoMainState();
}

ScrollController? controller;
ScrollController? _scrollviewcontroller;

class _LiveStockInfoMainState extends State<LiveStockInfoLive> {
  bool setDairy = false;
  bool setBeef = false;
  bool setSheep = false;
  bool setPigs = false;
  bool setPoultry = false;

  @override
  Widget build(BuildContext context) {
    // double baseWidth = 390;
    // double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    // bool setDairy = false;
    // bool setBeef = false;
    // bool setSheep = false;
    // bool setPigs = false;
    // bool setPoultry = false;

    return Scaffold(
      appBar: AppBar(
        title: customAppBar(text: "Livestock Information"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SvgPicture.asset("assets/images/Mask Group 26.svg"),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            addDataDialog(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: setDairy ? 2.5 : 0.5,
                                color: Color(0xFF0E5F02),
                                // color: AppColors.white
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 210.h,
                            width: 170.w,
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, right: 5.h),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      size: 19.w,
                                      color: setDairy
                                          ? AppColors.buttoncolour
                                          : AppColors.transparent,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Color(0xFFF1F1F1),
                                  child: Image.asset("assets/images/dairy.png"),
                                ),
                                Spacer(),
                                Text(
                                  "Dairy",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            addDataDialog(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                // width: 0.5,
                                width: setBeef ? 2.5 : 0.5,

                                color: Color(0xFF0E5F02),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 210.h,
                            width: 170.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, right: 5.h),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      size: 19.w,
                                      color: setBeef
                                          ? AppColors.buttoncolour
                                          : AppColors.transparent,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Color(0xFFF1F1F1),
                                  child: Image.asset("assets/images/beef.png"),
                                ),
                                Spacer(),
                                Text(
                                  "Beef",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            addDataDialog(2);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                // width: 0.5,
                                width: setSheep ? 2.5 : 0.5,

                                color: Color(0xFF0E5F02),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 210.h,
                            width: 170.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, right: 5.h),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      size: 19.w,
                                      color: setSheep
                                          ? AppColors.buttoncolour
                                          : AppColors.transparent,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Color(0xFFF1F1F1),
                                  child: Image.asset("assets/images/sheep.png"),
                                ),
                                Spacer(),
                                Text(
                                  "Sheep",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            addDataDialog(3);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                // width: 0.5,
                                width: setPigs ? 2.5 : 0.5,

                                color: Color(0xFF0E5F02),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 210.h,
                            width: 170.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, right: 5.h),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      size: 19.w,
                                      color: setPigs
                                          ? AppColors.buttoncolour
                                          : AppColors.transparent,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Color(0xFFF1F1F1),
                                  child: Image.asset("assets/images/pig.png"),
                                ),
                                Spacer(),
                                Text(
                                  "Pig",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            addDataDialog(3);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                // width: 0.5,
                                width: setPoultry ? 2.5 : 0.5,

                                color: Color(0xFF0E5F02),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 210.h,
                            width: 170.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, right: 5.h),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      size: 19.w,
                                      color: setPoultry
                                          ? AppColors.buttoncolour
                                          : AppColors.transparent,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Color(0xFFF1F1F1),
                                  child: Image.asset("assets/images/hen.png"),
                                ),
                                Spacer(),
                                Text(
                                  "Poultry",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                        text: "Update",
                        onTap: () {
                          isSetLiveStockInfo = true;
                          Get.back(result: true);
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),

              // Expanded(
              //         child: GridView.builder(
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2,

              //           ),
              //           itemBuilder: (BuildContext context, int index){
              //             return InkWell(
              //               onTap: () {
              //                 addDataDialog(0);
              //               },
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     width: setDairy ? 2.5 : 0.5,
              //                     color: Color(0xFF0E5F02),
              //                     // color: AppColors.white
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 height: 210.h,
              //                 width: 170.w,
              //                 child: Column(
              //                   // mainAxisSize: MainAxisSize.max,
              //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                   children: [
              //                     Spacer(),
              //                     Align(
              //                       alignment: Alignment.centerRight,
              //                       child: Padding(
              //                         padding: EdgeInsets.only(top: 5.h,right: 5.h),
              //                         child: Icon(Icons.check_circle_outline,
              //                           size: 19.w,
              //                           color: setDairy ? AppColors.buttoncolour : AppColors.transparent,
              //                         ),
              //                       ),
              //                     ),
              //                     CircleAvatar(
              //                       radius: 55,
              //                       backgroundColor: Color(0xFFF1F1F1),
              //                       child: Image.asset("assets/images/dairy.png"),
              //                     ),
              //                     Spacer(),
              //                     Text(
              //                       "Dairy",
              //                       style: TextStyle(
              //                           fontSize: 20,
              //                           fontWeight: FontWeight.w500),
              //                     ),
              //                     Spacer(),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           }
              //         ),
              //       ),
            ],
          ),
        ),
      )),
    );
  }

  // Widget addDailog(){
  //   return
  // }

  Future<T?> addDataDialog<T>(int index) {
    return Get.defaultDialog(
        contentPadding: EdgeInsets.only(
          left: 22,
          right: 22,
          top: 25,
          bottom: 70,
        ),
        title: "",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textBlack25W600Mon("Dairy"),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.greyF1F1F1,
                    radius: 20,
                    child: Center(
                      child: Text(
                        "x",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color(0XFF0E5F02)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age"),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 315,
                  child: DropdownBtn(
                    hint: "Please Select Age",
                    items: [
                      "<2 Yrs",
                      "> & <5 yrs",
                      ">5 Yrs",
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Breed"),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 315,
                  child: DropdownBtn(
                    hint: "Please Select Age",
                    items: [
                      "Irish Angus",
                      "Irish Dexter",
                      "irish Holstein-Friesian",
                      "irish Holstein-Friesian1",
                      "irish Holstein-Friesian2",
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Number"),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 315,
                  child: CustomTextFormField(
                      hintText: "hintText", validatorText: "validatorText"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              text: "Save",
              onTap: () {
                Get.back();
                setLiveStockFor(index);
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.white, fontSize: 0),
        middleTextStyle: TextStyle(color: Colors.white),
        radius: 20);
  }

  setLiveStockFor(int index) {
    print(index);
    switch (index) {
      case 0:
        {
          setState(() {
            setDairy = true;
          });
        }
        break;

      case 1:
        {
          setState(() {
            setBeef = true;
          });
        }
        break;

      case 2:
        {
          setState(() {
            setSheep = true;
          });
        }
        break;

      case 3:
        {
          setState(() {
            setPigs = true;
          });
        }
        break;

      case 4:
        {
          setState(() {
            setPigs = true;
          });
        }
        break;

      default:
        {}
    }
    // Switch(value: value, onChanged: onChanged)
  }
}
