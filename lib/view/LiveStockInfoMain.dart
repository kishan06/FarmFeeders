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
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: customAppBar(text: "Livestock Info"),
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
                            Get.defaultDialog(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        textBlack25W600Mon("Dairy"),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.greyF1F1F1,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Number"),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          width: 315,
                                          child: CustomTextFormField(
                                              hintText: "hintText",
                                              validatorText: "validatorText"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CustomButton(
                                      text: "Save",
                                      onTap: () {
                                        // Get.back();
                                        isSetLiveStockInfo = true;
                                        // Get.to(LetsSetUpYourFarm())
                                        Get.toNamed("/letsSetUpYourFarm");
                                      },
                                    )
                                  ],
                                ),
                                backgroundColor: Colors.white,
                                titleStyle:
                                    TextStyle(color: Colors.white, fontSize: 0),
                                middleTextStyle: TextStyle(color: Colors.white),
                                radius: 20);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Color(0xFF0E5F02),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 180.h,
                            width: 170.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(),
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xFF0E5F02),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 180.h,
                          width: 170.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Color(0xFFF1F1F1),
                                child: Image.asset("assets/images/beef.png"),
                              ),
                              Spacer(),
                              Text(
                                "Beef",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                            ],
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xFF0E5F02),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 180.h,
                          width: 170.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Color(0xFFF1F1F1),
                                child: Image.asset("assets/images/sheep.png"),
                              ),
                              Spacer(),
                              Text(
                                "Sheep",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xFF0E5F02),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 180.h,
                          width: 170.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Color(0xFFF1F1F1),
                                child: Image.asset("assets/images/pig.png"),
                              ),
                              Spacer(),
                              Text(
                                "Pig",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                            ],
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xFF0E5F02),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 180.h,
                          width: 170.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Color(0xFFF1F1F1),
                                child: Image.asset("assets/images/hen.png"),
                              ),
                              Spacer(),
                              Text(
                                "Hen",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(text: "Update"),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
