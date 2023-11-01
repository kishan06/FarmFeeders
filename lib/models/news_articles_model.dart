class NewsArticlesModel {
  NewsArticlesModel({
    required this.status,
    required this.success,
    required this.data,
    required this.message,
  });
  late final int status;
  late final bool success;
  late final List<Data> data;
  late final String message;
  
  NewsArticlesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.articleCategoryXid,
    required this.title,
    required this.smallDescription,
    required this.smallImageUrl,
    required this.publishedDatetime,
    required this.artCategory,
    required this.bookmarked,
  });
  late final int id;
  late final int articleCategoryXid;
  late final String title;
  late final String smallDescription;
  late final String smallImageUrl;
  late final String publishedDatetime;
  late final String artCategory;
  late bool bookmarked;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    articleCategoryXid = json['article_category_xid'];
    title = json['title'];
    smallDescription = json['small_description'];
    smallImageUrl = json['small_image_url'];
    publishedDatetime = json['published_datetime'];
    artCategory = json['art_category'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['article_category_xid'] = articleCategoryXid;
    _data['title'] = title;
    _data['small_description'] = smallDescription;
    _data['small_image_url'] = smallImageUrl;
    _data['published_datetime'] = publishedDatetime;
    _data['art_category'] = artCategory;
    _data['bookmarked'] = bookmarked;
    return _data;
  }
}