abstract class BaseApiServices {
  Future<dynamic> getApi1(String url);

  Future<dynamic> getApiBasicToken(String url);

  Future<dynamic> postApi(var data, String url);
  Future<dynamic> deleteApi(String url, var data);
}
