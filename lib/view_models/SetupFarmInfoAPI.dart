import 'dart:developer';

import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';

class SetupFarmInfoApi {
  Future<ResponseData<dynamic>> getFarmInfoApi() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.farmInfoApi,
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

  Future<ResponseData<dynamic>> getLivestockTypeApi() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.livestockTypeApi,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData["message"] == "Access Denied") {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      } else {
        if (responseData['success']) {
          return response;
        } else {
          return ResponseData<dynamic>(
              responseData['message'], ResponseStatus.FAILED);
        }
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> getFeedLivestockApi() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.feedLivestockApi,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData["message"] == "Access Denied") {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      } else {
        if (responseData['success']) {
          return response;
        } else {
          return ResponseData<dynamic>(
              responseData['message'], ResponseStatus.FAILED);
        }
      }
    }
    return response;
  }
}
