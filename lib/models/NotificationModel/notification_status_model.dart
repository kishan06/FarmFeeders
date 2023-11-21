class NotificationStatusModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  NotificationStatusModel({this.status, this.success, this.data, this.message});

  NotificationStatusModel.fromJson(Map<String, dynamic> json) {
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
  int? iamPrincipalXid;
  int? notificationCategoryXid;
  int? disbale;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.iamPrincipalXid,
      this.notificationCategoryXid,
      this.disbale,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iamPrincipalXid = json['iam_principal_xid'];
    notificationCategoryXid = json['notification_category_xid'];
    disbale = json['disbale'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iam_principal_xid'] = iamPrincipalXid;
    data['notification_category_xid'] = notificationCategoryXid;
    data['disbale'] = disbale;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
