class OrdersModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  OrdersModel({this.status, this.success, this.data, this.message});

  OrdersModel.fromJson(Map<String, dynamic> json) {
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
  int? orderHeaderId;
  OngoingOrder? ongoingOrder;

  Data({this.orderHeaderId, this.ongoingOrder});

  Data.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['orderHeaderId'];
    ongoingOrder = json['ongoing_order'] != null
        ? OngoingOrder.fromJson(json['ongoing_order'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderHeaderId'] = orderHeaderId;
    if (ongoingOrder != null) {
      data['ongoing_order'] = ongoingOrder!.toJson();
    }
    return data;
  }
}

class OngoingOrder {
  String? title;
  String? smallImageUrl;

  OngoingOrder({this.title, this.smallImageUrl});

  OngoingOrder.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['small_image_url'] = smallImageUrl;
    return data;
  }
}
