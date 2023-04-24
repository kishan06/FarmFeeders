abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(var data, String url);
}
