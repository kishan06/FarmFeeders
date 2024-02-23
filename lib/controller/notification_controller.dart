import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/models/notification_data_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxString notificationCount = "0".obs;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  NotificationData? _notificationData;
  NotificationData? get notificationData => _notificationData;

  getNotificationData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');
    try {
      print(ApiUrls.getNotificationData);
      var headers = {
        'Authorization': bearerToken
        // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNzJmNDRhMTRlNjMzZjNjNzU0OTMzNzljOGU3MTE3ODczZmY0YTVhN2JjZTkwYjUzZmY1MDNhNDc0ZTU5NzliYTZhMDUwNGI0NjBjZmYyZDQiLCJpYXQiOjE2OTgwNTAxMDguNzEwMjMwMTEyMDc1ODA1NjY0MDYyNSwibmJmIjoxNjk4MDUwMTA4LjcxMDIzMjAxOTQyNDQzODQ3NjU2MjUsImV4cCI6MTcyOTY3MjUwOC43MDY5NzE4ODM3NzM4MDM3MTA5Mzc1LCJzdWIiOiIxMzQiLCJzY29wZXMiOlsiKiJdfQ.W6-McldjlZ-X2jadiLreJQ6ljfk8w5sZ_tgQt4ZfOo-5vF0D6qiQl4OvUfftIcr4H02XjgpRoFAQ4k0_IzrL8UUa2YY5nPXe-vkaSX92OZidVKGYnskuYPBW-qkJ8iOWsDJB6rrdE8EeOBiMcj0Z_nuvt2wI_i1VGxMPR8prrk6Hl6JzY4jcgtG7rHBJERiWmOu3XIZLy4tZbLaBoW7q3hvpcXLQ1vzcJWigRV7AtRnEkiHpsgMoAhF3WtOXvAX6hH1Caqq6khVKh8d9-PMWvUODeLbLdRJTsQYZ0L82U35A0MeF6p8-wnwCCErjGAJVZzMLeSH-DKL_6bS7agyWxClsKcQyq0R0BWV82CMOL8Vas0XCJOcOzZR026nEsSlAR2xUf3SXHg4iifVkmkQSbjMxQSksEDkxaJVkQPz0vEx-sK0JuIsYDIrkk-YppBTjipE1A8N5ynv3pCS_1U6scfwcZMxz2xzDUzgiIoZFCoyB561FXE3VZuPlkcRF4JvtECCgqVUAJxC7PrGu_KWdxOOfFHcqukVPeXCsWOpGC4rWL5-5FFF3uioJTMhCTCfzn-I94C7k3W8TKuD0QEb0BZjgoNs7YChFh2B4oo3znCBRQdqwVPX4LxikOS8j3M62H68RRYDRx-GEmAWsPfuAjoC9lvYsAqoO-CUYfEx4AWs'
      };
      var dio = Dio();
      var response = await dio.request(
        ApiUrls.getNotificationData,
        // 'https://farmflow.betadelivery.com/api/farmer/notifications',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        print("if");
        // print(json.encode(response.data));
        // var resp = json.encode(response.data);
        // var jsonResp = jsonDecode(resp);

        _notificationData = NotificationData.fromJson(response.data);
        // _feedDropdownData = FeedDropDownInfo.fromJson(response.data);
        // _liveStockData = LiveStockModel.fromJson(response.data);
        _isLoading = false;
        update();
      } else {
        print("else");
        print(response.statusMessage);
        _isLoading = false;
        update();
      }
    } catch (e) {
      print("catch");
      print(e);
      _isLoading = false;
      update();
    }
  }
}
