class NotificationData {
  NotificationData({
    required this.status,
    required this.success,
    required this.data,
    required this.message,
  });
  late final int status;
  late final bool success;
  late final List<Data> data;
  late final String message;
  
  NotificationData.fromJson(Map<String, dynamic> json){
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
    required this.notificationCategoryXid,
    required this.iamPrincipalXid,
    required this.message,
     this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int notificationCategoryXid;
  late final int iamPrincipalXid;
  late final String message;
  late final Null data;
  late final String readAt;
  late final String createdAt;
  late final String updatedAt;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    notificationCategoryXid = json['notification_category_xid'];
    iamPrincipalXid = json['iam_principal_xid'];
    message = json['message'];
    data = null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['notification_category_xid'] = notificationCategoryXid;
    _data['iam_principal_xid'] = iamPrincipalXid;
    _data['message'] = message;
    _data['data'] = data;
    _data['read_at'] = readAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}