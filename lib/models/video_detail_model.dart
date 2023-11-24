class VideoDetailModel {
  int? status;
  bool? success;
  VideoData? data;
  String? message;

  VideoDetailModel({this.status, this.success, this.data, this.message});

  VideoDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? VideoData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class VideoData {
  int? id;
  String? title;
  String? smallDescription;
  String? videoUrl;
  String? publishedDatetime;
  bool? bookmarked;
  List<VideoAccess>? videoAccess;

  VideoData(
      {this.id,
      this.title,
      this.smallDescription,
      this.videoUrl,
      this.publishedDatetime,
      this.bookmarked,
      this.videoAccess});

  VideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    smallDescription = json['small_description'];
    videoUrl = json['video_url'];
    publishedDatetime = json['published_datetime'];
    bookmarked = json['bookmarked'];
    if (json['videoAccess'] != null) {
      videoAccess = <VideoAccess>[];
      json['videoAccess'].forEach((v) {
        videoAccess!.add(VideoAccess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['small_description'] = smallDescription;
    data['video_url'] = videoUrl;
    data['published_datetime'] = publishedDatetime;
    data['bookmarked'] = bookmarked;
    if (videoAccess != null) {
      data['videoAccess'] = videoAccess!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoAccess {
  int? id;
  int? iamPrincipalXid;
  int? trainingVideoXid;
  int? active;

  VideoAccess({
    this.id,
    this.iamPrincipalXid,
    this.trainingVideoXid,
    this.active,
  });

  VideoAccess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iamPrincipalXid = json['iam_principal_xid'];
    trainingVideoXid = json['training_video_xid'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iam_principal_xid'] = iamPrincipalXid;
    data['training_video_xid'] = trainingVideoXid;
    data['active'] = active;

    return data;
  }
}
