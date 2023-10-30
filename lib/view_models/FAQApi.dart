import 'dart:developer';

import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';

class FAQApi {
  Future<ResponseData<dynamic>> getFAQData(String id) async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.faqApi + id,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
