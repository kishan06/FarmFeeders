import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';

class VerifyIdentityAPI {
  VerifyIdentityAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> verifyidentityApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      "https://farmflow.betadelivery.com/api/verify-otp",
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
