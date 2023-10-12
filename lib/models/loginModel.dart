class loginModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  loginModel({this.status, this.success, this.data, this.message});

  loginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? accessToken;
  int? userId;
  String? name;
  List<int>? permissions;

  Data({this.accessToken, this.userId, this.name, this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userId = json['user_id'];
    name = json['name'];
    permissions = json['permissions'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['permissions'] = this.permissions;
    return data;
  }
}
