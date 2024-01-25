import 'package:farmfeeders/models/faq_model.dart';
import 'package:get/get.dart';

import '../models/dashboardModel.dart';
import '../models/video_detail_model.dart';
import '../models/weather_model.dart';

class DashboardController extends GetxController {
  RxString tempValue = "00.0".obs;
  RxString humidityValue = "0".obs;
  RxString windValue = "00.0".obs;
  RxString locationText = "Unknown".obs;
  RxBool isLocationFetching = false.obs;
  RxString weatherCondition = "".obs;
  RxBool isDashboardApiLoading = false.obs;
  RxBool isWeatherLoading = false.obs;
  RxBool isWeatherForecastLoading = false.obs;
  String connectionCodeValue = "";
  DashboardModel dashboardModel = DashboardModel();
  FAQModel faqModel = FAQModel();
  String faqText = "";
  double? currentLat = 0, currentLng = 0;
  VideoData videoData = VideoData();
  List<WeatherModel> weatherModel = [];
}
