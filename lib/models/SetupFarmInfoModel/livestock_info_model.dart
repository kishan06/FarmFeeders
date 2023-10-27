class LiveStockInfoModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  LiveStockInfoModel({this.status, this.success, this.data, this.message});

  LiveStockInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? smallImageUrl;

  Data({this.id, this.name, this.smallImageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['small_image_url'] = smallImageUrl;
    return data;
  }
}
