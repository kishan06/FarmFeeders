import '../Utils/api_urls.dart';
import '../Utils/base_manager.dart';
import '../data/network/network_api_services.dart';

class NotificationAPI {
  Future<ResponseData<dynamic>> notificationSettingsApi(
    int categoryId,
  ) async {
    final response = await NetworkApiServices().postApi(
      {
        "category_id": categoryId,
      },
      ApiUrls.notificationSettingApi,
    );

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

  Future<ResponseData<dynamic>> getNotificationStatus() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.notificationStatusApi,
    );

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

  Future<ResponseData<dynamic>> getNotificationCount() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.notificationCountApi,
    );
    // log(response.data.toString());
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
