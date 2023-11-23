import 'dart:developer';

import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:get/get.dart';

class SubuserApi {
  Future<ResponseData<dynamic>> getsubUserList() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.subUserApi,
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

  Future<ResponseData<dynamic>> deleteSubUser(String id) async {
    final response = await NetworkApiServices().deleteApi(
      ApiUrls.deleteSubUserApi + id,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        utils.showToast(responseData["message"]);
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> updateSubUserApi(
      Map<String, dynamic> data) async {
    final response = await NetworkApiServices().postApi(
      data,
      ApiUrls.updateSubUserApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        utils.showToast(responseData["message"]);
        Get.back(result: true);
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    } else if (response.status == ResponseStatus.PRIVATE) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      log(response.message);
      if (response.message.trim() == "validation") {
        utils.showToast(responseData["message"]);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> addSubUserApi(Map<String, dynamic> data) async {
    final response = await NetworkApiServices().postApi(
      data,
      ApiUrls.subUserApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        utils.showToast(responseData["message"]);
        Get.back(result: true);
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    } else if (response.status == ResponseStatus.PRIVATE) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      log(response.message);
      if (response.message.trim() == "validation") {
        utils.showToast(responseData["message"]);
      }
    }
    return response;
  }
}
