import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/models/VideosListModel.dart';
import '../Utils/api_urls.dart';

class VideoListAPI {
  VideoListAPI(this.data);
  var data;
  Future<VideosListModel> videolistApi() async {
    final response = await NetworkApiServices().getApi1(
      "${ApiUrls.base}training_video_list/$data",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print(responseData);
        VideosListModel videolistObj = VideosListModel.fromJson(responseData);
        return videolistObj;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
