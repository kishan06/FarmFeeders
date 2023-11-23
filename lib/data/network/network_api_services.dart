import 'dart:convert';
import 'dart:developer';

import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class NetworkApiServices extends BaseApiServices {
  Dio dio = Dio();

  getApiResponse() async {
    print("getApiResponse");
    var headers = {
      'Authorization':
          'Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU='
    };
    var data = FormData.fromMap(
        {'email': 'subfarmer@wdimails.com', 'password': 'User@123'});

    var dio = Dio();
    var response = await dio.request(
      'https://farmflow.betadelivery.com/api/login',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  String basicAuth = 'Basic ' +
      base64.encode(utf8.encode(
          '+2\$qPbJR36w&he(jS&WDzfJjtEhJUKUp:t\$Bdq&Jt&sv4yGjcEUq89hEYduRjXH2u'));
  @override
  Future<ResponseData> getApi(String url) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'method': 'POST',
            "authorization": basicAuth,
            'access-token': token

            // "device-id": deviceId
          }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    if (response.statusCode == 200) {
      return ResponseData<dynamic>(
        "success",
        data: response.data,
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Future<ResponseData> getApi1(String url) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    log(token);
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'authorization': "Bearer $token",

            // "device-id": deviceId
          }));
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 403) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', "");
          Get.offAndToNamed("/loginScreen");
        }
      }
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData["message"] == "Access Denied") {
        return ResponseData<dynamic>(
          "access denied",
          data: response.data,
          ResponseStatus.SUCCESS,
        );
      } else {
        return ResponseData<dynamic>(
          "success",
          data: response.data,
          ResponseStatus.SUCCESS,
        );
      }
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Future<ResponseData> postApi(data, String url) async {
    if (kDebugMode) {
      print("data >>> $data");
      print("api url is >>> $url");
    }
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      response = await dio.post(url,
          data: data,
          options: (token == null || token == "")
              ? Options(
                  headers: {
                    "Authorization":
                        "Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU=",
                  },
                )
              : Options(headers: {
                  "Authorization": "Bearer $token",
                  //'access-token': token,
                }));
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 403) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', "");
          Get.offAndToNamed("/loginScreen");
        }
      }
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: response.data);
    } else if (response.statusCode == 203) {
      print(response.data);
      return ResponseData<dynamic>("validation", ResponseStatus.PRIVATE,
          data: response.data);
    } else if (response.statusCode == 202) {
      print(response.data);
      return ResponseData<dynamic>("success", ResponseStatus.PRIVATE,
          data: response.data);
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Future<ResponseData> deleteApi(String url) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    log(token);
    try {
      response = await dio.delete(url,
          options: Options(headers: {
            'authorization': "Bearer $token",

            // "device-id": deviceId
          }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    if (response.statusCode == 200) {
      return ResponseData<dynamic>(
        "success",
        data: response.data,
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }
}
