import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/models/feed_Info_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class FeedInfoContro extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List<ExpansionTileController> expansionController = [];

  FeedDropDownInfo? _feedDropdownData;
  FeedDropDownInfo? get feedDropdownData => _feedDropdownData;

  RxInt selectedIndex = 0.obs;

  changeUpdated(int index) {
    update();
  }

  getApiFeedDropdownData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var headers = {
        'Authorization': "Bearer $token",
      };
      var dio = Dio();

      var response = await dio.request(
        ApiUrls.getFeedInfoDropdownData + id,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        _feedDropdownData = FeedDropDownInfo.fromJson(response.data);
        _isLoading = false;
        update();
      } else {
        print(response.statusMessage);
        _isLoading = false;
        update();
      }
    } catch (e) {
      print(e);
      _isLoading = false;
      update();
    }
  }

  Future<String?> setApiFarmFeed({required Map<String, dynamic> map}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      print(map);
      var headers = {
        'Authorization': "Bearer ${token!}"
        // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWYyOTU2MzU3N2ViYjI2YTY2YmY1ODA5ZmE2ODk1MTkwNDY4ZmE3ZWNkMGJjN2YxNzJmMjgwODlkMDZjYTMxNDRhOWNhODg2NWMwYjllMTAiLCJpYXQiOjE2OTcwOTcyNzQuMzAzNDg5OTIzNDc3MTcyODUxNTYyNSwibmJmIjoxNjk3MDk3Mjc0LjMwMzQ5MTExNTU3MDA2ODM1OTM3NSwiZXhwIjoxNzI4NzE5Njc0LjMwMDU1NDk5MDc2ODQzMjYxNzE4NzUsInN1YiI6Ijg5Iiwic2NvcGVzIjpbIioiXX0.S3nliV2jHB97526ubyn0zSp01gPa4462wxJAiUsKrQ-ofPM-7dOstij9NrsApxvY7Qp6In_cayOSAJWNrcz8FKCsB9ZwJagNDdd2BVn6TxRTTIkLOQABzveHR2z-uAx2ZPxAfRCn6pQLWniAsAnxa7wpsujSXocvvg4E0OLdnmKmN-4N24b3CccNEuaPVBUAy0FkG4BU5mZyV_JZ099w5Ck2X68xcd-QoHXOuYp-vF9DZw6HcdW2xx84fXY0Lss3BDQBEk8XdqMFrG-s8zyiHYCSrarPxS8PKYJ6Q87AgyX-f2glRYLgc5xOqAMZI8L8EBzAiOlvp33pc2m_4y7y-jZtHTARBJ09LhZUiresn45uYndEfV-Sx5uHp7QIyXFVkZqc4rXUdwXCsVFq44FRQgQ3A6Q-WzUEphC2d5tnUZxOJL-RmNoM7IO9bzeeCbwGlLU200KzMLRqWv0-G7CX7mwPFsaI1iau65cg_eIrbX_U2oRTDaIKX2gIH7h4t7-d3WhmkySxWeVdUWu66LgDK9hyPEensGrZLZW5KJUBYYSRjyD9OCdXIZicJN0Jv1z0aXaMIqz9hbVZYg8Np-5GaulzfQa5YCxQYzW6JwVXVL1SV_WQyqi35240UPIlvjPb0lFarNdfIloJRfs_y5fwK3rS9zCeWuriJ-SfBehZqvA'
      };
      var data = FormData.fromMap(map
          //   {
          //   'livestock_type': '1',
          //   'current_feed': '20',
          //   'feed_type': '1',
          //   'feed_frequency': '1',
          //   'qty_per_seed': '5',
          //   'min_capacity': '50',
          //   'max_capacity': '200'
          // }
          );
      print(ApiUrls.setFeedInfo);
      var dio = Dio();
      var response = await dio.request(
        ApiUrls.setFeedInfo,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        if (responseData["status"] == 403) {
          return responseData["message"];
        }
        print(json.encode(response.data));
        return "success";
      } else {
        print(response.statusMessage);
        // commonFlushBar(context, msg: msg)
        return "failed";
      }
    } catch (e) {
      print(e);
      return "failed";
    }
  }
}
