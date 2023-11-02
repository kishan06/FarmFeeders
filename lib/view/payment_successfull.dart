import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentSuccessfull extends StatelessWidget {
  const PaymentSuccessfull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            sizedBoxHeight(80.h),
            SvgPicture.asset("assets/images/subscriptiondone.svg"),
            sizedBoxHeight(53.h),
            textBlack131313_28MediumCenter('Your payment is successful'),
            sizedBoxHeight(20.h),
            textBlack2C2C2C_20Center(
                'This screen will be auto redirected to your Farm Dashboard.')
          ],
        ),
      ),
    );
  }
}
