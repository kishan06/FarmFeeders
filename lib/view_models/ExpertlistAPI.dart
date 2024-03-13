import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/models/expertlistModel.dart';

import '../Utils/api_urls.dart';

class ExpertListAPI {
  ExpertListAPI();
  var data;
  Future<ResponseData<dynamic>> expertlistApi() async {
    final response = await NetworkApiServices().getApi1(
      "${ApiUrls.base}experts-list",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("success");
        ExpertList expertlistObj = ExpertList.fromJson(responseData);

        print(expertlistObj);
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> updateMarkExpertApi(
    int id,
  ) async {
    var data = FormData.fromMap({
      "expert_id": id,
    });
    final response = await NetworkApiServices().postApi(
      data,
      "${ApiUrls.base}bookmark-expert",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        utils.showToast(responseData['message']);
        // return ResponseData<dynamic>(response.data, ResponseStatus.FAILED);
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
