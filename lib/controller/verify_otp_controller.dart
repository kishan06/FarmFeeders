import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/models/feed_Info_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;


// lib/common/limit_range.dart
// import 'package:http/http.dart' as http;

class VerifyOtpController extends GetxController {
  resendOtpApi(String id) async {
    try {
      print(id);
      var headers = {
        // 'Authorization': bearerToken!

        'Authorization': 'Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU='
      };
      var request = http.MultipartRequest('POST', Uri.parse(
        // 'https://farmflow.betadelivery.com/api/resend-otp'
        ApiUrls.resendOtpApi,


      ));
      request.fields.addAll({
        'id': id
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var resp = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        Fluttertoast.showToast(msg: "OTP resent successfully");
        print(resp);

      } else if(response.statusCode == 429){
        print(resp);
        Fluttertoast.showToast(msg: "You can resend OTP only after a 2-minute interval");

        // var resp = await response.stream.bytesToString();
        // print(await response.stream.bytesToString());
        
      }
      else {
        print(response.reasonPhrase);
        Fluttertoast.showToast(msg: "Something went wrong");

      }

      // var headers = {
      //   'Authorization': bearerToken
      //   // 'Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU='
      // };
      // var data = FormData.fromMap({
      //   'id': id
      // });

      // var dio = Dio();
      // var response = await dio.request(
      //   // 'https://farmflow.betadelivery.com/api/resend-otp',
      //   ApiUrls.resendOtpApi,
      //   options: Options(
      //     method: 'POST',
      //     headers: headers,
      //   ),
      //   data: data,
      // );

      // if (response.statusCode == 200) {
      //   print(json.encode(response.data));
      //   // utils.showToast("OTP resent successfully");
      //   Fluttertoast.showToast(msg: "OTP resent successfully");
      //   // Get.snackbar("Success", "message")





      // }
      // else {
      //   print(response.statusMessage);
      //   // utils.showToast("Something went wrong");
      //   Fluttertoast.showToast(msg: "Something went wrong");


      // }
    } catch (e) {
      print(e);
      // utils.showToast("Something went wrong");
      Fluttertoast.showToast(msg: "Something went wrong");


    }
  }

  // class utils {
  //   static showToast(String? msg) {
  //     if (msg != null && msg != "null" && msg.isNotEmpty) {
  //       Fluttertoast.showToast(msg: msg);
  //     }
  //   }
  // }
}


// class utils {
//   static showToast(String? msg) {
//     if (msg != null && msg != "null" && msg.isNotEmpty) {
//       Fluttertoast.showToast(msg: msg);
//     }
//   }
// }