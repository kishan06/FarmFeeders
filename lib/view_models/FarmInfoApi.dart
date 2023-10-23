import 'dart:convert';

import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/models/FarmInfoModel/FarmInfoModel.dart';

class FarmInfoApi {
  Future<ResponseData<dynamic>> farmInfoAddressApi(
      FarmInfoAddressModel farmInfoAddressModel) async {
    final response = await NetworkApiServices().postApi(
      jsonEncode(farmInfoAddressModel),
      "https://farmflow.betadelivery.com/api/farm-info",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        //     log(responseData.toString());
        utils.showToast("${responseData['message']}");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
