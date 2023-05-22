import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_appbar_home.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: customAppBarHome(text: "knc"),
        //   backgroundColor: Colors.white,
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   titleSpacing: 0,
        // ),
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(60.w, 10.h, 16.w, 10.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textBlack20W7000Mon("Welcome Back"),
                  textBlack20W7000Mon("Kevin")
                ],
              ),
              Spacer(),
              Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.h),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/notification_bell.svg",
                      height: 28.h,
                      width: 28.h,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
              sizedBoxWidth(10.w),
              Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.h),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(Icons.settings,
                    //   size: 3.h,
                    //   // color: app,
                    // )
                    SvgPicture.asset(
                      "assets/images/Settings.svg",
                      height: 28.h,
                      width: 28.h,
                      color: AppColors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                      color: AppColors.pistaE3FFE9,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Lottie.asset(
                                "assets/lotties/cloud2.json",
                                height: 200.h,
                                width: 200.w,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(36.w, 25.h, 36.w, 12.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/images/locationconnect.svg",
                                                    color: AppColors.black,
                                                    height: 20.h,
                                                    width: 20.h,
                                                  ),

                                                  sizedBoxWidth(5.w),

                                                  // textBlack20W7000("Ireland"),
                                                  textBlack18W5000("Ireland")
                                                ],
                                              ),
                                              textGreen50Bold("22° C"),
                                              textBlack18W5000(
                                                  "Sat, 3 Nov -12.32PM"),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // LottieBuilder.asset(name)
                                      // Lottie.asset("assets/lotties/cloud.json",
                                      //   height: 100.h,
                                      //   width: 200.w
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      
                        Container(
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                            color: AppColors.white,
                            // chil
                          ),

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  textBlack16W5000("jj"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(36.w, 25.h, 36.w, 12.h),
                  //   child: Container(
                  //     // color: Colors.amber,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Stack(
                  //               children: [
                  //                 // Align(
                  //                 //   alignment: Alignment.centerRight,
                  //                 //   child: Container(
                  //                 //     color: Colors.red,
                  //                 //     child: Lottie.asset("assets/lotties/cloud.json",
                  //                 //       height: 300.h,
                  //                 //       width: 250.w
                  //                 //     ),
                  //                 //   ),
                  //                 // ),

                  //                 Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.start,
                  //                       children: [
                  //                         SvgPicture.asset(
                  //                           "assets/images/locationconnect.svg",
                  //                           color: AppColors.black,
                  //                           height: 20.h,
                  //                           width: 20.h,
                  //                         ),

                  //                         sizedBoxWidth(5.w),

                  //                         // textBlack20W7000("Ireland"),
                  //                         textBlack18W5000("Ireland")
                  //                       ],
                  //                     ),
                  //                     textGreen50Bold("22° C"),
                  //                     textBlack18W5000("Sat, 3 Nov -12.32PM"),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),

                  //             // LottieBuilder.asset(name)
                  //             // Lottie.asset("assets/lotties/cloud.json",
                  //             //   height: 100.h,
                  //             //   width: 200.w
                  //             // )
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
