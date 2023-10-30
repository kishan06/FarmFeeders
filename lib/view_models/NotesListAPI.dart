import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/models/NotesModel.dart';

class NotesListAPI {
  NotesListAPI(this.data);
  var data;
  Future<NotesModel> noteslistApi() async {
    final response = await NetworkApiServices().getApi1(
      "https://farmflow.betadelivery.com/api/training_video/notes/$data",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
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
