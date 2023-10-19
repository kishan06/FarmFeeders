import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxString tempValue = "00.0".obs;
  RxString locationText = "Unknown".obs;
  RxBool isLocationFetching = false.obs;
}
