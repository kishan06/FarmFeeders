import 'dart:developer';

import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/models/loginModel.dart';
import '../Utils/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  LoginAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> loginApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await NetworkApiServices().postApi(
      data,
      "${ApiUrls.base}login",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        log(responseData.toString());
        loginModel loginObj = loginModel.fromJson(responseData);
        await prefs.setString('token', loginObj.data!.accessToken!);
        print("token is ${loginObj.data!.accessToken!}");
        List<String> stringsList =
            loginObj.data!.permissions!.map((i) => i.toString()).toList();
        await prefs.setStringList("permissionList", stringsList);
        await prefs.setString('name', loginObj.data!.name!);
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> logoutApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      ApiUrls.lougoutApi,
    );
    log(response.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['message'] == "Logged out successfully.") {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
