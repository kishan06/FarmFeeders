class CancelledOrderListModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  CancelledOrderListModel({this.status, this.success, this.data, this.message});

  CancelledOrderListModel.fromJson(Map<String, dynamic> json) {
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
  List<CancelledOrders>? cancelledOrders;

  Data({this.cancelledOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cancelled_orders'] != null) {
      cancelledOrders = <CancelledOrders>[];
      json['cancelled_orders'].forEach((v) {
        cancelledOrders!.add(CancelledOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cancelledOrders != null) {
      data['cancelled_orders'] =
          cancelledOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CancelledOrders {
  int? orderId;
  String? cancelledAt;
  Inventory? inventory;

  CancelledOrders({this.orderId, this.cancelledAt, this.inventory});

  CancelledOrders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    cancelledAt = json['cancelled_at'];
    inventory = json['inventory'] != null
        ? Inventory.fromJson(json['inventory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['cancelled_at'] = cancelledAt;
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
