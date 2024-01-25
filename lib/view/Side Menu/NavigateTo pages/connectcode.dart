import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Connectcode extends StatefulWidget {
  const Connectcode({super.key});

  @override
  State<Connectcode> createState() => _ConnectcodeState();
}

class _ConnectcodeState extends State<Connectcode> {
  DashboardController dashboardController = Get.put(DashboardController());

  buildconnectdialog2(context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor:
                    Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
                contentPadding: EdgeInsets.fromLTRB(57.w, 46.h, 57.w, 21.h),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Get.isDarkMode
                          ? Colors.grey
                          : const Color(0XFFFFFFFF)),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //sizedBoxHeight(46.h),

                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/images/profilrcheck.svg",
                        width: 67.w,
                        height: 67.h,
                      ),
                    ),
                    sizedBoxHeight(21.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Connection Request Approved",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    sizedBoxHeight(28.h)
                  ],
                ),
              ),
            ],
          );
        });
  }

  buildconnectiondialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxHeight(32.h),
                // Align(
                //   alignment: Alignment.center,
                //   child: Image.asset(
                //     "assets/images/bin@2x.png",
                //     width: 35.w,
                //     height: 34.h,
                //   ),
                // ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Approve the connection request",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        buildconnectdialog2(context);
                      },
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
                            border: Border.all(color: const Color(0XFF0E5F02)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                      backgroundColor: const Color(0XFFF1F1F1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.h,
                            color: const Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(15.w),
                  Text(
                    "Connection Code",
                    style: TextStyle(
                      color: const Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(52.h),
            Text(
              "Connect to a Sales Rep by providing them with your Connection Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xff141414),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
            sizedBoxHeight(86.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Code !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xff141414),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            sizedBoxHeight(10.h),
            Container(
                height: 50.h,
                width: 358.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    color: const Color(0xffF1F1F1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedBoxWidth(122.w),
                    Text(
                      dashboardController.connectionCodeValue,
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontFamily: "Poppins",
                        color: const Color(0xff000000),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          //  buildconnectiondialog(context);
                          Clipboard.setData(ClipboardData(
                            text: dashboardController.connectionCodeValue,
                          )).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Content copied to clipboard")));
                          });
                        },
                        child: SvgPicture.asset(
                          "assets/images/copy.svg",
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
