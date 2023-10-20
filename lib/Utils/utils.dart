import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

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

  static String formattedTimeAgo(String dateTime) {
    final dateTimeV = DateTime.parse(dateTime);
    final now = DateTime.now();
    final difference = now.difference(dateTimeV);
    return timeago.format(now.subtract(difference), locale: 'en');
  }

  static String formattedDate(String dateTime) {
    final inputDate = DateTime.parse(dateTime);
    return DateFormat('d MMM y').format(inputDate);
  }

  static String convertISOToFormattedDate(String isoDateString) {
    try {
      DateTime isoDate = DateTime.parse(isoDateString);

      String formattedDate = DateFormat('MM/dd/yyyy').format(isoDate);

      return formattedDate;
    } catch (e) {
      // Handle any errors, e.g., invalid date format
      return 'Invalid Date';
    }
  }
}
