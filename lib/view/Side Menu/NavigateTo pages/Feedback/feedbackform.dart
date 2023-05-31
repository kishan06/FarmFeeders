import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Feedbackform extends StatefulWidget {
  const Feedbackform({super.key});

  @override
  State<Feedbackform> createState() => _FeedbackformState();
}

class _FeedbackformState extends State<Feedbackform> {
  // bool _isChecked1 = false;
  // bool _isChecked2 = false;
  // bool _isChecked3 = false;
  // bool _isChecked4 = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? feedBackData;

  buildAdvisorypopup(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: FittedBox(
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  )),
            ),
          ),
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            contentPadding: EdgeInsets.fromLTRB(24, 30, 24, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Colors.white),
            ),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            //   title: ,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 45),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Booking Successful",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedBackData = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // Color(0xffF1F1F1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                  ),
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
                        "Feedback",
                        style: TextStyle(
                          color: Color(0XFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.more_vert,
                        color: AppColors.black,
                        size: 35.h,
                      )
                    ],
                  ),
                ),
                sizedBoxHeight(44.h),
                Center(
                  child: Text(
                    feedBackData!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Color(0xff141414),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
                sizedBoxHeight(2.h),
                Center(
                  child: Text(
                    "what was it? \nshare with us your experience!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff4D4D4D),
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                sizedBoxHeight(61.h),
                TextFormField(
                  style: TextStyle(fontSize: 16.sp),
                  cursorColor: const Color(0xFF3B3F43),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 16.sp),
                    contentPadding: EdgeInsets.all(17.h),
                    filled: true,
                    fillColor: Color(0xFFF1F1F1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: Color(0xFF707070).withOpacity(0), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: Color(0xFF707070).withOpacity(0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: Color(0xFF707070).withOpacity(0), width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    hintStyle: TextStyle(
                        color: const Color(0xFF4D4D4D), fontSize: 16.sp),
                    hintText: "  Write a feedback",
                  ),
                  minLines: 5,
                  maxLines: null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Message is required';
                    }
                    return null;
                  },
                ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       _isChecked1 = !_isChecked1;
                //     });
                //   },
                //   child: Container(
                //     width: 358.w,
                //     height: 50.h,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: Color(0xFFF1F1F1),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16.w),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "It Was Excellent",
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Color(0xff4D4D4D),
                //               fontFamily: "Poppins",
                //             ),
                //           ),
                //           Spacer(),
                //           GestureDetector(
                //             onTap: () {
                //               // setState(() {
                //               //   _isChecked1 = !_isChecked1;
                //               // });
                //             },
                //             child: SvgPicture.asset(
                //               _isChecked1
                //                   ? "assets/images/Greentick.svg"
                //                   : "assets/images/Whitetick.svg",
                //               width: 21.w,
                //               height: 21.h,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // sizedBoxHeight(14.h),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       _isChecked2 = !_isChecked2;
                //     });
                //   },
                //   child: Container(
                //     width: 358.w,
                //     height: 50.h,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: Color(0xFFF1F1F1),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16.w),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "It Was Good",
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Color(0xff4D4D4D),
                //               fontFamily: "Poppins",
                //             ),
                //           ),
                //           Spacer(),
                //           GestureDetector(
                //             onTap: () {
                //               // setState(() {
                //               //   _isChecked2 = !_isChecked2;
                //               // });
                //             },
                //             child: SvgPicture.asset(
                //               _isChecked2
                //                   ? "assets/images/Greentick.svg"
                //                   : "assets/images/Whitetick.svg",
                //               width: 21.w,
                //               height: 21.h,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // sizedBoxHeight(14.h),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       _isChecked3 = !_isChecked3;
                //     });
                //   },
                //   child: Container(
                //     width: 358.w,
                //     height: 50.h,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: Color(0xFFF1F1F1),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16.w),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "It Was Neutral",
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Color(0xff4D4D4D),
                //               fontFamily: "Poppins",
                //             ),
                //           ),
                //           Spacer(),
                //           GestureDetector(
                //             onTap: () {
                //               // setState(() {
                //               //   _isChecked3 = !_isChecked3;
                //               // });
                //             },
                //             child: SvgPicture.asset(
                //               _isChecked3
                //                   ? "assets/images/Greentick.svg"
                //                   : "assets/images/Whitetick.svg",
                //               width: 21.w,
                //               height: 21.h,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // sizedBoxHeight(14.h),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       _isChecked4 = !_isChecked4;
                //     });
                //   },
                //   child: Container(
                //     width: 358.w,
                //     height: 50.h,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: Color(0xFFF1F1F1),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16.w),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "It Was Very Poor",
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Color(0xff4D4D4D),
                //               fontFamily: "Poppins",
                //             ),
                //           ),
                //           Spacer(),
                //           GestureDetector(
                //             onTap: () {
                //               // setState(() {
                //               //   _isChecked4 = !_isChecked4;
                //               // });
                //             },
                //             child: SvgPicture.asset(
                //               _isChecked4
                //                   ? "assets/images/Greentick.svg"
                //                   : "assets/images/Whitetick.svg",
                //               width: 21.w,
                //               height: 21.h,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                sizedBoxHeight(223.h),
                customButtonCurve(
                    text: "Send Now",
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        print("error");
                        buildAdvisorypopup(context);
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
