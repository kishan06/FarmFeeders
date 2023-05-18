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
          Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.h),
          color: AppColors.white
        ),
        // child: SizedBox(
        //       height: 22.h,
        //       width: 22.h,
        //       child: SvgPicture.asset(
        //         bottomBarData[index]["imageUrl"],
        //         // height: 35.h,
        //         // width: 35.h,
        //         color: selectedIndex == index ?AppColors.white : AppColors.buttoncolour,
        //         fit: BoxFit.fill,
        //         // color: AppColors.greyD3B3F43,
        //         // colorFilter: AppColors.greyD3B3F43,
        //       ),
        //     ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SizedBox(
        //       height: 22.h,
        //       width: 22.h,
        //       child: SvgPicture.asset(
        //         bottomBarData[index]["imageUrl"],
        //         // height: 35.h,
        //         // width: 35.h,
        //         color: selectedIndex == index ?AppColors.white : AppColors.buttoncolour,
        //         fit: BoxFit.fill,
        //         // color: AppColors.greyD3B3F43,
        //         // colorFilter: AppColors.greyD3B3F43,
        //       ),
        //     ),
    
    
        //   ],
        // ),
     
      ),
   
        ],
      )
    );
  }
}
