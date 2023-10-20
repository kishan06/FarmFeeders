import 'dart:convert';
import 'dart:developer';

import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
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
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'authorization': bearerToken
            // "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWE1ZTNlYmI0YzM1YjUzNzdlMjA0MDgwNzI0MGQyZTM0Y2QyZTA4ZDY5ZDQ0NzFiZDQ4MGJlODdjODFhNzE3YWE1MzE4ZmNkMzdmNmFlYzkiLCJpYXQiOjE2OTY1MDM0ODIuNjA5NDI1MDY3OTAxNjExMzI4MTI1LCJuYmYiOjE2OTY1MDM0ODIuNjA5NDI2OTc1MjUwMjQ0MTQwNjI1LCJleHAiOjE3MjgxMjU4ODIuNjA2NTg5MDc4OTAzMTk4MjQyMTg3NSwic3ViIjoiODAiLCJzY29wZXMiOlsiKiJdfQ.NiUl7xO3z2-9jc7LaQbakYGYwDNXs6vzpF6gDN5anX21d7GlMTu-CIDGX5CqAiQ-5AT-B1egdfnFbXGXmeddnUqUAZGnWB9sCVnxnNA0grMNLVG5dKCE20Tc-_dMDanyV13cNelbwiI13W_Vur-8RXnCwi1cF1jl_-QSWoTl6R3QOm49Iv10kp_8KmMILRAgeEkRFUiCZpB4FdurVB5qALSY-mDeiBPPeZLQkvYF3p1xu4K0mQdtX1kxo4HG-JxoB3jSwasizlqkJHvURY8ZUhmjJKjnt5ml2w2-mCZxzVYSBYznAZNw9knRnEGbSfUhRACN86ItbfPnrK0jU7BbDu7il9nhZOt_4r6OJQu5BbPAK7mBcGBg_V0Fb7DcqfYj5G7qyrN5Bs9Z7EFRvWrUKp7UpItlGKtjgxK9TKeG3DszZRrQPL1NLQcgaxqU46PIfsvWw5jOL0i7LisWsY7q6nh7t40D2neR-ImqVsIvyGTUlY_KpyMDr5Di5OCc0ds0qO-Ha7vau3KO7bnp7ZVF6fhPqoXdCndVv5xz8NsHVC1FEbfEwH5pVIkiBZk7v4gACksunoqXffnaBsTA1bP7NARf2brKL7-1WxzAKseYyt5YTVvgdo1E0K1c9QRvmwzLlPWtRdp82uag3TTBC8eC4KvfNiVHuP3dvtnqisy__l8",

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
  Future<ResponseData> postApi(data, String url) async {
    if (kDebugMode) {
      print("data >>> $data");
      print("api url is >>> $url");
    }
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      response = await dio.post(
        url,
        data: data,
        options: token != null
            ? Options(headers: {
                "authorization": "Bearer $token",
                //'access-token': token,
              })
            : Options(
                headers: {
                  "authorization": basicAuth,
                },
              ),
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: response.data);
    } else if (response.statusCode == 203) {
      log(response.data);
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
}
