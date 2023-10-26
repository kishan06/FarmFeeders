import 'dart:convert';

import 'package:dio/dio.dart';
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

  // uploadVideoApi() async {
  //   try {
  //     var headers = {
  //       'Authorization':
  //           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWE1ZTNlYmI0YzM1YjUzNzdlMjA0MDgwNzI0MGQyZTM0Y2QyZTA4ZDY5ZDQ0NzFiZDQ4MGJlODdjODFhNzE3YWE1MzE4ZmNkMzdmNmFlYzkiLCJpYXQiOjE2OTY1MDM0ODIuNjA5NDI1MDY3OTAxNjExMzI4MTI1LCJuYmYiOjE2OTY1MDM0ODIuNjA5NDI2OTc1MjUwMjQ0MTQwNjI1LCJleHAiOjE3MjgxMjU4ODIuNjA2NTg5MDc4OTAzMTk4MjQyMTg3NSwic3ViIjoiODAiLCJzY29wZXMiOlsiKiJdfQ.NiUl7xO3z2-9jc7LaQbakYGYwDNXs6vzpF6gDN5anX21d7GlMTu-CIDGX5CqAiQ-5AT-B1egdfnFbXGXmeddnUqUAZGnWB9sCVnxnNA0grMNLVG5dKCE20Tc-_dMDanyV13cNelbwiI13W_Vur-8RXnCwi1cF1jl_-QSWoTl6R3QOm49Iv10kp_8KmMILRAgeEkRFUiCZpB4FdurVB5qALSY-mDeiBPPeZLQkvYF3p1xu4K0mQdtX1kxo4HG-JxoB3jSwasizlqkJHvURY8ZUhmjJKjnt5ml2w2-mCZxzVYSBYznAZNw9knRnEGbSfUhRACN86ItbfPnrK0jU7BbDu7il9nhZOt_4r6OJQu5BbPAK7mBcGBg_V0Fb7DcqfYj5G7qyrN5Bs9Z7EFRvWrUKp7UpItlGKtjgxK9TKeG3DszZRrQPL1NLQcgaxqU46PIfsvWw5jOL0i7LisWsY7q6nh7t40D2neR-ImqVsIvyGTUlY_KpyMDr5Di5OCc0ds0qO-Ha7vau3KO7bnp7ZVF6fhPqoXdCndVv5xz8NsHVC1FEbfEwH5pVIkiBZk7v4gACksunoqXffnaBsTA1bP7NARf2brKL7-1WxzAKseYyt5YTVvgdo1E0K1c9QRvmwzLlPWtRdp82uag3TTBC8eC4KvfNiVHuP3dvtnqisy__l8'
  //     };
  //     var data = FormData.fromMap({
  //       'files': [
  //         await MultipartFile.fromFile(
  //           '/D:/FlutterCodes/FoodSpeciality/foodspeciality/assets/video.mp4',
  //         )
  //       ],
  //       'title': 'Animal Husbandary and Management',
  //       'sub_title': 'test of training video',
  //       'category_id': '2',
  //       'access_ids[0]': '80'
  //     });

  //     var dio = Dio();
  //     var response = await dio.request(
  //       'https://farmflow.betadelivery.com/api/training_video',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );

  //     if (response.statusCode == 200) {
  //       print(json.encode(response.data));
  //     } else {
  //       print(response.statusMessage);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
