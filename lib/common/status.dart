import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Utils/colors.dart';

Widget status() {
  return Column(
    children: [
      CircularPercentIndicator(
        center: CircleAvatar(
          child: SizedBox(),
          radius: 5.h,
          backgroundColor: AppColors.buttoncolour,
        ),
        radius: 10.h,
        lineWidth: 1,
        backgroundColor: Color(0XFFACC8A8),
        // progressColor: Color(0XFFACC8A8),
        //fillColor: Color(0XFFACC8A8),
      )
    ],
  );
}


