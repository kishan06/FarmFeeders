import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';

class ResetPasswordAPI {
  ResetPasswordAPI(
    this.data,
  );
  var data;

  Future<ResponseData<dynamic>> resetpasswordApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      "https://farmflow.betadelivery.com/api/reset-password",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("token is $response");
        print("otp is $responseData");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
