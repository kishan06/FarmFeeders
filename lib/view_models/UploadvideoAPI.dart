import 'dart:developer';

import 'package:farmfeeders/common/limit_range.dart';
import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadvideoAPI {
  UploadvideoAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> uploadvideoApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await NetworkApiServices().postApi(
      data,
      "https://farmflow.betadelivery.com/api/training_video",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("success $response");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> updatevideoApi(dynamic dataV) async {
    final response = await NetworkApiServices().postApi(
      dataV,
      ApiUrls.updatetrainingVideoApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("success $response");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> deleteTrainingVideo(String id) async {
    final response = await NetworkApiServices().deleteApi(
      ApiUrls.deletetrainingVideoApi + id,
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

  Future<ResponseData<dynamic>> trainingVideoBookmarkApi(int id) async {
    final response = await NetworkApiServices().postApi(
      FormData.fromMap({
        "training_video_id": id,
      }),
      ApiUrls.trainingVideoBookmarkApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("success $response");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> trainingVideoDetailApi(int id) async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.trainingVideoDetailApi + id.toString(),
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("success $response");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
