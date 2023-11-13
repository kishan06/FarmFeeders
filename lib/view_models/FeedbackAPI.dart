import 'package:farmfeeders/common/limit_range.dart'; 

import '../Utils/api_urls.dart';
import '../Utils/base_manager.dart';
import '../data/network/network_api_services.dart';

class FeedbackAPI {
  Future<ResponseData<dynamic>> feedbackApi(dynamic data) async {
    final response = await NetworkApiServices().postApi(
      data,
      ApiUrls.feedbackApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        utils.showToast(responseData['message']);
        print("success $response");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
