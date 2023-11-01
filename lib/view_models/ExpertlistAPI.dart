import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/models/expertlistModel.dart';

class ExpertListAPI {
  ExpertListAPI();
  var data;
  Future<ResponseData<dynamic>> expertlistApi() async {
    final response = await NetworkApiServices().getApi1(
      "https://farmflow.betadelivery.com/api/experts-list",
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
}
