import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Utils/colors.dart';
import '../common/custom_button_curve.dart';
import 'Side Menu/NavigateTo pages/subscription_plan.dart';

class RenewSubscriptionScreen extends StatefulWidget {
  const RenewSubscriptionScreen({super.key});

  @override
  State<RenewSubscriptionScreen> createState() =>
      _RenewSubscriptionScreenState();
}

class _RenewSubscriptionScreenState extends State<RenewSubscriptionScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: LottieBuilder.asset(
              "assets/lotties/lock_animation.json",
              height: 150,
              width: Get.width / 2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Your Subscription has Expired",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                Get.to(() => SubscriptionPlan(
                      fromScreen: "fromHomePage",
                    ));
              },
              child: customButtonCurve(
                  bgColor: AppColors.buttoncolour, text: 'Renew Subscription'),
            ),
          )
        ],
      ),
    );
  }
}
