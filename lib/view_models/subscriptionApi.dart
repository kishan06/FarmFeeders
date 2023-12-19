import 'dart:developer';

import '../Utils/api_urls.dart';
import '../Utils/base_manager.dart';
import '../data/network/network_api_services.dart';

class SubscriptionApi {
  Future<ResponseData<dynamic>> getSubscriptionData() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.subscriptionsApi,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> getSubscriptionPlanApi() async {
    final response = await NetworkApiServices().getApiBasicToken(
      ApiUrls.subscriptionPlanApi,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
