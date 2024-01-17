import 'dart:convert';
import 'dart:developer';

import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../Utils/colors.dart';
import '../../view/ErrorScreen/error_screen.dart';
import '../../view/Side Menu/NavigateTo pages/subscription_plan.dart';

class NetworkApiServices extends BaseApiServices {
  Dio dio = Dio();
  DashboardController dashboardController = Get.put(DashboardController());

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
          Map<String, dynamic> responseData =
              Map<String, dynamic>.from(e.response!.data);
          if (responseData["message"] == "Subscription Inactive") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // print("token " + jsonResp["data"]["accessToken"]);

            await prefs.setString('loginStatus', "Subscription Inactive");
            await prefs.setString(
                'id', e.response!.data["data"]["user_id"].toString());
            await prefs.setString(
                'customerId', e.response!.data["data"]["customer_id"]);

            Get.offAll(SubscriptionPlan(
              fromScreen: "SubscriptionInActive",
            ));
          } else if (responseData["message"] ==
              "Subscription Inactive and Orders Pending") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // print("token " + jsonResp["data"]["accessToken"]);
            await prefs.setString(
                'loginStatus', "Subscription Inactive and Orders Pending");
            await prefs.setString(
                'accessToken', e.response!.data["data"]["access_token"]);
            await prefs.setString(
                'token', e.response!.data["data"]["access_token"]);

            token = e.response!.data["data"]["access_token"];
            Get.offAndToNamed('/sideMenu');
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', "");
            Get.offAndToNamed("/loginScreen");
          }
        } else if (e.response!.statusCode == 500) {
          Get.to(const ErrorScreen());
        }
      }
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loginStatus', "");
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
  Future<ResponseData> getApiBasicToken(String url) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;

    try {
      response = await dio.get(url,
          options: Options(headers: {
            "authorization": basicAuth,

            // "device-id": deviceId
          }));
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 403) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', "");
          Get.offAndToNamed("/loginScreen");
        } else if (e.response!.statusCode == 500) {
          Get.to(const ErrorScreen());
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
          Map<String, dynamic> responseData =
              Map<String, dynamic>.from(e.response!.data);
          if (responseData["message"] == "Subscription Inactive") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // print("token " + jsonResp["data"]["accessToken"]);
            await prefs.setString(
                'accessToken', e.response!.data["data"]["access_token"]);
            await prefs.setString('loginStatus', "Subscription Inactive");
            await prefs.setString(
                'token', e.response!.data["data"]["access_token"]);
            token = e.response!.data["data"]["access_token"];
            Get.offAll(SubscriptionPlan(
              fromScreen: "SubscriptionInActives",
            ));
          } else if (responseData["message"] ==
              "Subscription Inactive and Orders Pending") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // print("token " + jsonResp["data"]["accessToken"]);
            await prefs.setString(
                'loginStatus', "Subscription Inactive and Orders Pending");
            await prefs.setString(
                'accessToken', e.response!.data["data"]["access_token"]);
            await prefs.setString(
                'token', e.response!.data["data"]["access_token"]);

            token = e.response!.data["data"]["access_token"];
            Get.offAndToNamed('/sideMenu');
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', "");
            Get.offAndToNamed("/loginScreen");
          }
        } else if (e.response!.statusCode == 500) {
          Get.to(const ErrorScreen());
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
  Future<ResponseData> deleteApi(String url, data) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    log(token);
    try {
      response = await dio.delete(url,
          data: data,
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
    } else if (response.statusCode == 203) {
      utils.showToast(response.data["message"]);
      return ResponseData<dynamic>("validation", ResponseStatus.PRIVATE,
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
}
