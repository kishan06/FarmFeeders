import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Utils/sized_box.dart';

backbuttonpressed(
  context,
) {
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
                color: Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //sizedBoxHeight(32.h),
              const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.exit_to_app_outlined,
                    size: 45,
                    color: AppColors.buttoncolour,
                  )),
              SizedBox(
                height: 22.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Are you sure you want to Exit?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    //fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              sizedBoxHeight(21.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      SystemNavigator.pop();
                      Navigator.pop(context);
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
                  sizedBoxWidth(15.w),
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
