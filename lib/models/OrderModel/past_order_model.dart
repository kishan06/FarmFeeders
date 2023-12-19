class PastOrderListModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  PastOrderListModel({this.status, this.success, this.data, this.message});

  PastOrderListModel.fromJson(Map<String, dynamic> json) {
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
  List<PastOrders>? pastOrders;

  Data({this.pastOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['past_orders'] != null) {
      pastOrders = <PastOrders>[];
      json['past_orders'].forEach((v) {
        pastOrders!.add(PastOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pastOrders != null) {
      data['past_orders'] = pastOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PastOrders {
  int? orderId;
  String? createdAt;
  Inventory? inventory;

  PastOrders({this.orderId, this.createdAt, this.inventory});

  PastOrders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    createdAt = json['created_at'];
    inventory = json['inventory'] != null
        ? Inventory.fromJson(json['inventory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['created_at'] = createdAt;
    if (inventory != null) {
      data['inventory'] = inventory!.toJson();
    }
    return data;
  }
}

class Inventory {
  String? title;
  String? smallImageUrl;

  Inventory({this.title, this.smallImageUrl});

  Inventory.fromJson(Map<String, dynamic> json) {
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
