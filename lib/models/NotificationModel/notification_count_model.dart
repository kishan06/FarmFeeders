class NotificationCountModel {
  int? status;
  bool? success;
  int? data;
  String? message;

  NotificationCountModel({this.status, this.success, this.data, this.message});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
