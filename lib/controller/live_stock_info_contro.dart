import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

import '../models/live_stock_model.dart';

class LiveStockInfoContro extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _selectedAge;
  String? get selectedAge => _selectedAge;

  String? _selectedBreed;
  String? get selectedBreed => _selectedBreed;

  LiveStockModel? _liveStockData;
  LiveStockModel? get liveStockData => _liveStockData;

  updateSelectedAge(String selectedtext) {
    _selectedAge = selectedtext;
    update();
  }

  updateSelectedBreed(String selectedText) {
    _selectedBreed = selectedText;
    update();
  }

  Future<String?> getApiForLiveStockData({required String selectedNum}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      print(bearerToken);
      _isLoading = true;
      _liveStockData = null;
      _selectedAge = null;
      _selectedBreed = null;
      update();
      var headers = {
        'Authorization': "Bearer $token"
        // 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWE1ZTNlYmI0YzM1YjUzNzdlMjA0MDgwNzI0MGQyZTM0Y2QyZTA4ZDY5ZDQ0NzFiZDQ4MGJlODdjODFhNzE3YWE1MzE4ZmNkMzdmNmFlYzkiLCJpYXQiOjE2OTY1MDM0ODIuNjA5NDI1MDY3OTAxNjExMzI4MTI1LCJuYmYiOjE2OTY1MDM0ODIuNjA5NDI2OTc1MjUwMjQ0MTQwNjI1LCJleHAiOjE3MjgxMjU4ODIuNjA2NTg5MDc4OTAzMTk4MjQyMTg3NSwic3ViIjoiODAiLCJzY29wZXMiOlsiKiJdfQ.NiUl7xO3z2-9jc7LaQbakYGYwDNXs6vzpF6gDN5anX21d7GlMTu-CIDGX5CqAiQ-5AT-B1egdfnFbXGXmeddnUqUAZGnWB9sCVnxnNA0grMNLVG5dKCE20Tc-_dMDanyV13cNelbwiI13W_Vur-8RXnCwi1cF1jl_-QSWoTl6R3QOm49Iv10kp_8KmMILRAgeEkRFUiCZpB4FdurVB5qALSY-mDeiBPPeZLQkvYF3p1xu4K0mQdtX1kxo4HG-JxoB3jSwasizlqkJHvURY8ZUhmjJKjnt5ml2w2-mCZxzVYSBYznAZNw9knRnEGbSfUhRACN86ItbfPnrK0jU7BbDu7il9nhZOt_4r6OJQu5BbPAK7mBcGBg_V0Fb7DcqfYj5G7qyrN5Bs9Z7EFRvWrUKp7UpItlGKtjgxK9TKeG3DszZRrQPL1NLQcgaxqU46PIfsvWw5jOL0i7LisWsY7q6nh7t40D2neR-ImqVsIvyGTUlY_KpyMDr5Di5OCc0ds0qO-Ha7vau3KO7bnp7ZVF6fhPqoXdCndVv5xz8NsHVC1FEbfEwH5pVIkiBZk7v4gACksunoqXffnaBsTA1bP7NARf2brKL7-1WxzAKseYyt5YTVvgdo1E0K1c9QRvmwzLlPWtRdp82uag3TTBC8eC4KvfNiVHuP3dvtnqisy__l8'
      };
      var dio = Dio();
      print("dio");
      print(ApiUrls.liveStockGet + selectedNum);
      var response = await dio.request(
        ApiUrls.liveStockGet + selectedNum,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        print("if");
        if (responseData["status"] == 403) {
          return responseData["message"];
        }
        print(json.encode(response.data));
        // var resp = json.encode(response.data);
        // var jsonResp = jsonDecode(resp);
        _liveStockData = LiveStockModel.fromJson(response.data);
        _isLoading = false;
        update();
        return "success";
      } else {
        print("else");
        print(response.statusMessage);
        _isLoading = false;
        update();
      }
    } catch (e) {
      print("catch");
      print(e);
      _isLoading = false;
      update();
    }
  }

  Future<String?> setApiLiveStockData(
      {required String liveStockType,
      required String liveStockAge,
      required String liveStockBreed,
      required String count}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      print({
        'livestock_type': liveStockType,
        'livestock_age': liveStockAge,
        'livestock_breed': liveStockBreed,
        'count': count
      });
      var headers = {'Authorization': "Bearer $token"};
      var data = FormData.fromMap({
        'livestock_type': liveStockType,
        'livestock_age': liveStockAge,
        'livestock_breed': liveStockBreed,
        'count': count
      });

      var dio = Dio();
      var response = await dio.request(
        ApiUrls.liveStockSet,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        print(json.encode(response.data));
        if (responseData["status"] == 403) {
          return responseData["message"];
        }
        return "success";
      } else {
        print(response.statusMessage);
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
