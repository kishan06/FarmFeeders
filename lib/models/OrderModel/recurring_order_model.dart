class RecurringOrderListModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  RecurringOrderListModel({this.status, this.success, this.data, this.message});

  RecurringOrderListModel.fromJson(Map<String, dynamic> json) {
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
  List<RecurringOrders>? recurringOrders;

  Data({this.recurringOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recurring_orders'] != null) {
      recurringOrders = <RecurringOrders>[];
      json['recurring_orders'].forEach((v) {
        recurringOrders!.add(RecurringOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recurringOrders != null) {
      data['recurring_orders'] =
          recurringOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecurringOrders {
  int? id;
  String? title;
  String? smallImageUrl;

  RecurringOrders({this.id, this.title, this.smallImageUrl});

  RecurringOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['small_image_url'] = smallImageUrl;
    return data;
  }
}
