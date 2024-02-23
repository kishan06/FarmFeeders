import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/models/bookmarkedNewsArticleModel.dart';
import 'package:farmfeeders/models/news_articles_model.dart';

import 'package:get/get.dart' hide FormData;

class NewsArticleController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isLoadingBookmarkList = true;
  bool get isLoadingBookmarkList => _isLoadingBookmarkList;

  NewsArticlesModel? _newsArticlesData;
  NewsArticlesModel? get newsArticlesData => _newsArticlesData;

  BookmarkedNewsListModel? _bookmarkedNewsArticle;
  BookmarkedNewsListModel? get bookmarkedNewsArticle => _bookmarkedNewsArticle;

  changeBookmark(int index, {bool isBookmarkedList = false}) {
    if (isBookmarkedList) {
      _bookmarkedNewsArticle!.data[index].bookmarked =
          !_bookmarkedNewsArticle!.data[index].bookmarked;
      update();
    } else {
      _newsArticlesData!.data[index].bookmarked =
          !_newsArticlesData!.data[index].bookmarked;
      update();
    }
  }

  getNewsArticleData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');
    try {
      // print(ApiUrls.getNotificationData);

      var headers = {
        'Authorization': bearerToken
        // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNzJmNDRhMTRlNjMzZjNjNzU0OTMzNzljOGU3MTE3ODczZmY0YTVhN2JjZTkwYjUzZmY1MDNhNDc0ZTU5NzliYTZhMDUwNGI0NjBjZmYyZDQiLCJpYXQiOjE2OTgwNTAxMDguNzEwMjMwMTEyMDc1ODA1NjY0MDYyNSwibmJmIjoxNjk4MDUwMTA4LjcxMDIzMjAxOTQyNDQzODQ3NjU2MjUsImV4cCI6MTcyOTY3MjUwOC43MDY5NzE4ODM3NzM4MDM3MTA5Mzc1LCJzdWIiOiIxMzQiLCJzY29wZXMiOlsiKiJdfQ.W6-McldjlZ-X2jadiLreJQ6ljfk8w5sZ_tgQt4ZfOo-5vF0D6qiQl4OvUfftIcr4H02XjgpRoFAQ4k0_IzrL8UUa2YY5nPXe-vkaSX92OZidVKGYnskuYPBW-qkJ8iOWsDJB6rrdE8EeOBiMcj0Z_nuvt2wI_i1VGxMPR8prrk6Hl6JzY4jcgtG7rHBJERiWmOu3XIZLy4tZbLaBoW7q3hvpcXLQ1vzcJWigRV7AtRnEkiHpsgMoAhF3WtOXvAX6hH1Caqq6khVKh8d9-PMWvUODeLbLdRJTsQYZ0L82U35A0MeF6p8-wnwCCErjGAJVZzMLeSH-DKL_6bS7agyWxClsKcQyq0R0BWV82CMOL8Vas0XCJOcOzZR026nEsSlAR2xUf3SXHg4iifVkmkQSbjMxQSksEDkxaJVkQPz0vEx-sK0JuIsYDIrkk-YppBTjipE1A8N5ynv3pCS_1U6scfwcZMxz2xzDUzgiIoZFCoyB561FXE3VZuPlkcRF4JvtECCgqVUAJxC7PrGu_KWdxOOfFHcqukVPeXCsWOpGC4rWL5-5FFF3uioJTMhCTCfzn-I94C7k3W8TKuD0QEb0BZjgoNs7YChFh2B4oo3znCBRQdqwVPX4LxikOS8j3M62H68RRYDRx-GEmAWsPfuAjoC9lvYsAqoO-CUYfEx4AWs'
      };
      var dio = Dio();
      var response = await dio.request(
        ApiUrls.getNewsArticle,
        // 'https://farmflow.betadelivery.com/api/farmer/notifications',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        print("if");
        print(response.data);
        _newsArticlesData = NewsArticlesModel.fromJson(response.data);
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

  GetBookmarkedList() async {
    try {
      var headers = {
        'Authorization':
            // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMmNkM2Q1ZTk5MjZkNmE3ZWQ4YWQxNDg0ZDhmMDZjN2YyMTU4ZDc2NTgzZmViYzkwMDRhNTI0OTIwYzJjZWRjMTE4N2MwNGU0ODEwOGRkNzMiLCJpYXQiOjE2OTg4NDQ5MjMuMzE0NTEwMTA3MDQwNDA1MjczNDM3NSwibmJmIjoxNjk4ODQ0OTIzLjMxNDUxMTA2MDcxNDcyMTY3OTY4NzUsImV4cCI6MTczMDQ2NzMyMy4zMTMwNjE5NTI1OTA5NDIzODI4MTI1LCJzdWIiOiIxMzQiLCJzY29wZXMiOlsiKiJdfQ.EjvKA_oCsI8YlZa-fg0R4cY7wcX2UDfvmHKWW2J8eFCv10Ev3a1S6EPQ-CnUVq36yMfADMyRtLXFrtzzswCRozVWMcVNSkOK-XUi6HUI3_xHLWiWv4eiRhM9b90vid3OSIPurVwXLE-zKc5KYFfF4E6-Jn_wuIUKEWfK_3PgiWmrtbQ1NIgEfsNys9gRhSNM9q16cKwiMe3dJWjhUxXRo0nOsYr7_p3sxq9BFe8zOnzN28TKoGykZXmBItSUfxwKr7mIa7ycqxAZBu9dFGODQaTGbYx4PYF8Di9_3mj40-Hu7Av5-a6oenMDVftxdIHSfaT7XnRgaaSU2LC8-EeTmTpEI03fK_MGSUAdEgwV5oCDESUZ07NckB32M5CWDaiZyX-EWLWxDmnqu1mGOyGdVDOs0SvxpHisKGUdvvvQBJit-5IyuP417aWzB6Ws2AeH5S6bvOk9dsTI6nkNXHa5HCoPMtR41L1xB8PHhn_EAto972jzzZ8d_pUy1aMzpgnyzTlUx2G-eLd8XIbbSt9-1HbPt2tsjmj8xhvcG0IGEACiVGbuzpwCtbVJA6mN1m_Q9F_q-7sWnPz9Pw54mkw6pi43EQxHY2Uu-Nu5Ir7g9TlJtrpGbiJdpvvW0oFGrVZnCu3RCsHU2VxNRH9U00NiNpNvDqCVnhHk8-LiQp6bgg4'
            bearerToken
        // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMmNkM2Q1ZTk5MjZkNmE3ZWQ4YWQxNDg0ZDhmMDZjN2YyMTU4ZDc2NTgzZmViYzkwMDRhNTI0OTIwYzJjZWRjMTE4N2MwNGU0ODEwOGRkNzMiLCJpYXQiOjE2OTg4NDQ5MjMuMzE0NTEwMTA3MDQwNDA1MjczNDM3NSwibmJmIjoxNjk4ODQ0OTIzLjMxNDUxMTA2MDcxNDcyMTY3OTY4NzUsImV4cCI6MTczMDQ2NzMyMy4zMTMwNjE5NTI1OTA5NDIzODI4MTI1LCJzdWIiOiIxMzQiLCJzY29wZXMiOlsiKiJdfQ.EjvKA_oCsI8YlZa-fg0R4cY7wcX2UDfvmHKWW2J8eFCv10Ev3a1S6EPQ-CnUVq36yMfADMyRtLXFrtzzswCRozVWMcVNSkOK-XUi6HUI3_xHLWiWv4eiRhM9b90vid3OSIPurVwXLE-zKc5KYFfF4E6-Jn_wuIUKEWfK_3PgiWmrtbQ1NIgEfsNys9gRhSNM9q16cKwiMe3dJWjhUxXRo0nOsYr7_p3sxq9BFe8zOnzN28TKoGykZXmBItSUfxwKr7mIa7ycqxAZBu9dFGODQaTGbYx4PYF8Di9_3mj40-Hu7Av5-a6oenMDVftxdIHSfaT7XnRgaaSU2LC8-EeTmTpEI03fK_MGSUAdEgwV5oCDESUZ07NckB32M5CWDaiZyX-EWLWxDmnqu1mGOyGdVDOs0SvxpHisKGUdvvvQBJit-5IyuP417aWzB6Ws2AeH5S6bvOk9dsTI6nkNXHa5HCoPMtR41L1xB8PHhn_EAto972jzzZ8d_pUy1aMzpgnyzTlUx2G-eLd8XIbbSt9-1HbPt2tsjmj8xhvcG0IGEACiVGbuzpwCtbVJA6mN1m_Q9F_q-7sWnPz9Pw54mkw6pi43EQxHY2Uu-Nu5Ir7g9TlJtrpGbiJdpvvW0oFGrVZnCu3RCsHU2VxNRH9U00NiNpNvDqCVnhHk8-LiQp6bgg4'
      };
      var dio = Dio();
      var response = await dio.request(
        // 'https://farmflow.betadelivery.com/api/bookmarked/news-and-articles',
        ApiUrls.getBookmarkedNewsList,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // print("if");
        // print(response.data);
        // _newsArticlesData = NewsArticlesModel.fromJson(response.data);
        _bookmarkedNewsArticle =
            BookmarkedNewsListModel.fromJson(response.data);
        _isLoadingBookmarkList = false;
        update();
      } else {
        print("else");
        // print(response.statusMessage);
        _isLoadingBookmarkList = false;
        update();
      }
    } catch (e) {
      print("catch");
      print(e);
      _isLoadingBookmarkList = false;
      update();
    }
  }

  bookmarkApi(
      {required int index,
      required String id,
      bool isBookmarkList = false}) async {
    try {
      print("$bearerToken");
      var headers = {
        'Authorization': bearerToken
        // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNzJmNDRhMTRlNjMzZjNjNzU0OTMzNzljOGU3MTE3ODczZmY0YTVhN2JjZTkwYjUzZmY1MDNhNDc0ZTU5NzliYTZhMDUwNGI0NjBjZmYyZDQiLCJpYXQiOjE2OTgwNTAxMDguNzEwMjMwMTEyMDc1ODA1NjY0MDYyNSwibmJmIjoxNjk4MDUwMTA4LjcxMDIzMjAxOTQyNDQzODQ3NjU2MjUsImV4cCI6MTcyOTY3MjUwOC43MDY5NzE4ODM3NzM4MDM3MTA5Mzc1LCJzdWIiOiIxMzQiLCJzY29wZXMiOlsiKiJdfQ.W6-McldjlZ-X2jadiLreJQ6ljfk8w5sZ_tgQt4ZfOo-5vF0D6qiQl4OvUfftIcr4H02XjgpRoFAQ4k0_IzrL8UUa2YY5nPXe-vkaSX92OZidVKGYnskuYPBW-qkJ8iOWsDJB6rrdE8EeOBiMcj0Z_nuvt2wI_i1VGxMPR8prrk6Hl6JzY4jcgtG7rHBJERiWmOu3XIZLy4tZbLaBoW7q3hvpcXLQ1vzcJWigRV7AtRnEkiHpsgMoAhF3WtOXvAX6hH1Caqq6khVKh8d9-PMWvUODeLbLdRJTsQYZ0L82U35A0MeF6p8-wnwCCErjGAJVZzMLeSH-DKL_6bS7agyWxClsKcQyq0R0BWV82CMOL8Vas0XCJOcOzZR026nEsSlAR2xUf3SXHg4iifVkmkQSbjMxQSksEDkxaJVkQPz0vEx-sK0JuIsYDIrkk-YppBTjipE1A8N5ynv3pCS_1U6scfwcZMxz2xzDUzgiIoZFCoyB561FXE3VZuPlkcRF4JvtECCgqVUAJxC7PrGu_KWdxOOfFHcqukVPeXCsWOpGC4rWL5-5FFF3uioJTMhCTCfzn-I94C7k3W8TKuD0QEb0BZjgoNs7YChFh2B4oo3znCBRQdqwVPX4LxikOS8j3M62H68RRYDRx-GEmAWsPfuAjoC9lvYsAqoO-CUYfEx4AWs'
      };
      var data = FormData.fromMap({'article_id': id});

      var dio = Dio();
      var response = await dio.request(
        // 'https://farmflow.betadelivery.com/api/bookmark-article',
        ApiUrls.boomarkNewsAndArticles,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        if (isBookmarkList) {
          getNewsArticleData();
        } else {
          GetBookmarkedList();
        }
        // commonFlushBar(context, msg: msg)
        // Get.snackbar("Error", "Oops something went wrong");
      } else {
        print(response.statusMessage);
        Get.snackbar("Error", "Oops something went wrong");
        if (isBookmarkList) {
          changeBookmark(index, isBookmarkedList: true);
        } else {
          changeBookmark(index);
        }

        // Get.snackbar("Error", "Oops something went wrong");

        // Get.snackbar("Error", "Oops something went wrong");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Oops something went wrong");

      // changeBookmark(index);
      if (isBookmarkList) {
        changeBookmark(index, isBookmarkedList: true);
      } else {
        changeBookmark(index);
      }
    }
  }
}
