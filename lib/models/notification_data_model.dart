class NotificationData {
  NotificationData({
    required this.status,
    required this.success,
    required this.data,
    required this.message,
  });
  late final int status;
  late final bool success;
  late final Data data;
  late final String message;
  
  NotificationData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    success = json['success'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.today,
    required this.yesterday,
    required this.other,
  });
  late final List<Today> today;
  late final List<Yesterday> yesterday;
  late final List<Other> other;
  
  Data.fromJson(Map<String, dynamic> json){
    today = List.from(json['today']).map((e)=>Today.fromJson(e)).toList();
    yesterday = List.from(json['yesterday']).map((e)=>Yesterday.fromJson(e)).toList();
    other = List.from(json['other']).map((e)=>Other.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['today'] = today.map((e)=>e.toJson()).toList();
    _data['yesterday'] = yesterday.map((e)=>e.toJson()).toList();
    _data['other'] = other.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Today {
  Today({
    required this.id,
    required this.iamPrincipalXid,
    required this.notificationCategoryXid,
    required this.message,
     this.data,
    required this.readAt,
    required this.title,
    required this.image,
  });
  late final int id;
  late final int iamPrincipalXid;
  late final int notificationCategoryXid;
  late final String message;
  late final Null data;
  late final String readAt;
  late final String title;
  late final String image;
  
  Today.fromJson(Map<String, dynamic> json){
    id = json['id'];
    iamPrincipalXid = json['iam_principal_xid'];
    notificationCategoryXid = json['notification_category_xid'];
    message = json['message'];
    data = null;
    readAt = json['read_at'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['iam_principal_xid'] = iamPrincipalXid;
    _data['notification_category_xid'] = notificationCategoryXid;
    _data['message'] = message;
    _data['data'] = data;
    _data['read_at'] = readAt;
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}

class Yesterday {
  Yesterday({
    required this.id,
    required this.iamPrincipalXid,
    required this.notificationCategoryXid,
    required this.message,
     this.data,
    required this.readAt,
    required this.title,
    required this.image,
  });
  late final int id;
  late final int iamPrincipalXid;
  late final int notificationCategoryXid;
  late final String message;
  late final Null data;
  late final String readAt;
  late final String title;
  late final String image;
  
  Yesterday.fromJson(Map<String, dynamic> json){
    id = json['id'];
    iamPrincipalXid = json['iam_principal_xid'];
    notificationCategoryXid = json['notification_category_xid'];
    message = json['message'];
    data = null;
    readAt = json['read_at'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['iam_principal_xid'] = iamPrincipalXid;
    _data['notification_category_xid'] = notificationCategoryXid;
    _data['message'] = message;
    _data['data'] = data;
    _data['read_at'] = readAt;
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}

class Other {
  Other({
    required this.id,
    required this.iamPrincipalXid,
    required this.notificationCategoryXid,
    required this.message,
     this.data,
    required this.readAt,
    required this.title,
    required this.image,
  });
  late final int id;
  late final int iamPrincipalXid;
  late final int notificationCategoryXid;
  late final String message;
  late final Null data;
  late final String readAt;
  late final String title;
  late final String image;
  
  Other.fromJson(Map<String, dynamic> json){
    id = json['id'];
    iamPrincipalXid = json['iam_principal_xid'];
    notificationCategoryXid = json['notification_category_xid'];
    message = json['message'];
    data = null;
    readAt = json['read_at'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['iam_principal_xid'] = iamPrincipalXid;
    _data['notification_category_xid'] = notificationCategoryXid;
    _data['message'] = message;
    _data['data'] = data;
    _data['read_at'] = readAt;
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}