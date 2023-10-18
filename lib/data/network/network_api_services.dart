import 'dart:convert';

import 'package:farmfeeders/Utils/base_manager.dart';
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
            "authorization":
                "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWYyOTU2MzU3N2ViYjI2YTY2YmY1ODA5ZmE2ODk1MTkwNDY4ZmE3ZWNkMGJjN2YxNzJmMjgwODlkMDZjYTMxNDRhOWNhODg2NWMwYjllMTAiLCJpYXQiOjE2OTcwOTcyNzQuMzAzNDg5OTIzNDc3MTcyODUxNTYyNSwibmJmIjoxNjk3MDk3Mjc0LjMwMzQ5MTExNTU3MDA2ODM1OTM3NSwiZXhwIjoxNzI4NzE5Njc0LjMwMDU1NDk5MDc2ODQzMjYxNzE4NzUsInN1YiI6Ijg5Iiwic2NvcGVzIjpbIioiXX0.S3nliV2jHB97526ubyn0zSp01gPa4462wxJAiUsKrQ-ofPM-7dOstij9NrsApxvY7Qp6In_cayOSAJWNrcz8FKCsB9ZwJagNDdd2BVn6TxRTTIkLOQABzveHR2z-uAx2ZPxAfRCn6pQLWniAsAnxa7wpsujSXocvvg4E0OLdnmKmN-4N24b3CccNEuaPVBUAy0FkG4BU5mZyV_JZ099w5Ck2X68xcd-QoHXOuYp-vF9DZw6HcdW2xx84fXY0Lss3BDQBEk8XdqMFrG-s8zyiHYCSrarPxS8PKYJ6Q87AgyX-f2glRYLgc5xOqAMZI8L8EBzAiOlvp33pc2m_4y7y-jZtHTARBJ09LhZUiresn45uYndEfV-Sx5uHp7QIyXFVkZqc4rXUdwXCsVFq44FRQgQ3A6Q-WzUEphC2d5tnUZxOJL-RmNoM7IO9bzeeCbwGlLU200KzMLRqWv0-G7CX7mwPFsaI1iau65cg_eIrbX_U2oRTDaIKX2gIH7h4t7-d3WhmkySxWeVdUWu66LgDK9hyPEensGrZLZW5KJUBYYSRjyD9OCdXIZicJN0Jv1z0aXaMIqz9hbVZYg8Np-5GaulzfQa5YCxQYzW6JwVXVL1SV_WQyqi35240UPIlvjPb0lFarNdfIloJRfs_y5fwK3rS9zCeWuriJ-SfBehZqvA",
            // 'access-token':

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
      response = await dio.post(url,
          data: data,
          options: token != null
              ? Options(headers: {
                  "authorization": basicAuth,
                  // 'access-token': token,
                })
              : Options(headers: {
                  "authorization": basicAuth,
                }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: response.data);
    } else if (response.statusCode == 203) {
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
