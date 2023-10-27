class VideosListModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  VideosListModel({this.status, this.success, this.data, this.message});

  VideosListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? smallDescription;
  String? videoUrl;
  String? publishedDatetime;
  bool? bookmarked;

  Data(
      {this.id,
      this.title,
      this.smallDescription,
      this.videoUrl,
      this.publishedDatetime,
      this.bookmarked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    smallDescription = json['small_description'];
    videoUrl = json['video_url'];
    publishedDatetime = json['published_datetime'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['small_description'] = this.smallDescription;
    data['video_url'] = this.videoUrl;
    data['published_datetime'] = this.publishedDatetime;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}
