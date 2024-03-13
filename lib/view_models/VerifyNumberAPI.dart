import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';

import '../Utils/api_urls.dart';

class VerifyNumberAPI {
  VerifyNumberAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> verifynumberApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      "${ApiUrls.base}verify-fp-otp",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("token is $response");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
