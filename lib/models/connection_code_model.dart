class ConnectionCodeModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  ConnectionCodeModel({this.status, this.success, this.data, this.message});

  ConnectionCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? connectCode;

  Data({this.connectCode});

  Data.fromJson(Map<String, dynamic> json) {
    connectCode = json['connect_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connect_code'] = connectCode;
    return data;
  }
}
