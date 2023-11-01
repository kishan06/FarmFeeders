import 'package:get/get.dart';

import '../models/dashboardModel.dart';

class DashboardController extends GetxController {
  RxString tempValue = "00.0".obs;
  RxString humidityValue = "0".obs;
  RxString windValue = "00.0".obs;
  RxString locationText = "Unknown".obs;
  RxBool isLocationFetching = false.obs;
  RxString weatherCondition = "".obs;
  RxBool isDashboardApiLoading = false.obs;
  String connectionCodeValue = "";
  DashboardModel dashboardModel = DashboardModel();
}
