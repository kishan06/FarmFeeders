import 'package:farmfeeders/models/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/OrderModel/orders_model.dart';
import '../models/dashboardModel.dart';
import '../models/video_detail_model.dart';
import '../models/weather_model.dart';

class DashboardController extends GetxController {
  RxString tempValue = "00.0".obs;
  RxString humidityValue = "0".obs;
  RxString windValue = "00.0".obs;
  RxString locationText = "Unknown".obs;
  RxBool isLoading = true.obs;
  OrdersModel ordersModel = OrdersModel();
  RxBool isLocationFetching = false.obs;
  RxString weatherCondition = "".obs;
  RxBool isDashboardApiLoading = false.obs;
  late AnimationController animationController;
  RxBool isWeatherLoading = false.obs;
  bool isDashboardFirst = true;
  bool isOrderFirst = true;
  RxBool isWeatherForecastLoading = false.obs;
  String connectionCodeValue = "";
  DashboardModel dashboardModel = DashboardModel();
  FAQModel faqModel = FAQModel();
  String faqText = "";
  double? currentLat = 0, currentLng = 0;
  VideoData videoData = VideoData();
  RxBool isSideMenuClosed = true.obs;
  List<WeatherModel> weatherModel = [];
}
