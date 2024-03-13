import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/models/NotesModel.dart';
import 'package:farmfeeders/common/limit_range.dart';

import '../Utils/api_urls.dart';

class DeleteNoteAPI {
  DeleteNoteAPI(this.data);
  var data;
  Future<NotesModel> deleteNoteApi() async {
    final response = await NetworkApiServices()
        .deleteApi("${ApiUrls.base}training_video/note/$data", {});

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        utils.showToast("${responseData['message']}");
        print(responseData);
        NotesModel videolistObj = NotesModel.fromJson(responseData);
        return videolistObj;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
