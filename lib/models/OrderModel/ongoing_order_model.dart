class OngoingOrderListModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  OngoingOrderListModel({this.status, this.success, this.data, this.message});

  OngoingOrderListModel.fromJson(Map<String, dynamic> json) {
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
  int? orderHeaderId;
  String? orderDate;
  Product? product;
  List<OrderStatus>? orderStatus;

  Data({this.orderHeaderId, this.orderDate, this.product, this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['orderHeaderId'];
    orderDate = json['order_date'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['order_status'] != null) {
      orderStatus = <OrderStatus>[];
      json['order_status'].forEach((v) {
        orderStatus!.add(OrderStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderHeaderId'] = orderHeaderId;
    data['order_date'] = orderDate;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (orderStatus != null) {
      data['order_status'] = orderStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? title;
  String? smallImageUrl;

  Product({this.title, this.smallImageUrl});

  Product.fromJson(Map<String, dynamic> json) {
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

class OrderStatus {
  int? deliveryStatusXid;
  String? createdAt;

  OrderStatus({this.deliveryStatusXid, this.createdAt});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    deliveryStatusXid = json['delivery_status_xid'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivery_status_xid'] = deliveryStatusXid;
    data['created_at'] = createdAt;
    return data;
  }
}
