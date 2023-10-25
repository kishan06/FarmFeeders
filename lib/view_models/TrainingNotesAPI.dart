import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';

class TrainingNotesApi {
  Future<ResponseData<dynamic>> addNotesApi(
      {required Map<String, dynamic> map}) async {
    var data = FormData.fromMap(map);
    final response = await NetworkApiServices().postApi(
      data,
      ApiUrls.addTrainingNotesApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        utils.showToast("${responseData['message']}");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
