import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static loader() {
    Get.dialog(
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: WillPopScope(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.blueL_006796,
                ),
              ],
            ),
            onWillPop: () async => false),
      ),
      barrierDismissible: false,
    );
  }
}
