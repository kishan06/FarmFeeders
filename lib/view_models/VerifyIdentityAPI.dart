import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/api_urls.dart';

class VerifyIdentityAPI {
  VerifyIdentityAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> verifyidentityApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await NetworkApiServices().postApi(
      data,
      "${ApiUrls.base}verify-otp",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        await prefs.setString('token', responseData["data"]["token"]);
        print("token is ${responseData["data"]["token"]}");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
