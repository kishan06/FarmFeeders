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
  String? orderDate;
  OngoingOrder? ongoingOrder;
  List<OrderStatus>? orderStatus;
  List<RecurringOrders>? recurringOrders;
  List<PastOrders>? pastOrders;
  List<CancelledOrders>? cancelledOrders;

  Data({
    this.orderHeaderId,
    this.orderDate,
    this.ongoingOrder,
    this.orderStatus,
    this.recurringOrders,
    this.pastOrders,
    this.cancelledOrders,
  });

  Data.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['orderHeaderId'];
    orderDate = json['order_date'];
    ongoingOrder = json['ongoing_order'] != null
        ? OngoingOrder.fromJson(json['ongoing_order'])
        : null;
    if (json['order_status'] != null) {
      orderStatus = <OrderStatus>[];
      json['order_status'].forEach((v) {
        orderStatus!.add(OrderStatus.fromJson(v));
      });
    }
    if (json['recurring_orders'] != null) {
      recurringOrders = <RecurringOrders>[];
      json['recurring_orders'].forEach((v) {
        recurringOrders!.add(RecurringOrders.fromJson(v));
      });
    }
    if (json['past_orders'] != null) {
      pastOrders = <PastOrders>[];
      json['past_orders'].forEach((v) {
        pastOrders!.add(PastOrders.fromJson(v));
      });
    }
    if (json['cancelled_orders'] != null) {
      cancelledOrders = <CancelledOrders>[];
      json['cancelled_orders'].forEach((v) {
        cancelledOrders!.add(CancelledOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderHeaderId'] = orderHeaderId;
    data['order_date'] = orderDate;
    if (ongoingOrder != null) {
      data['ongoing_order'] = ongoingOrder!.toJson();
    }
    if (orderStatus != null) {
      data['order_status'] = orderStatus!.map((v) => v.toJson()).toList();
    }
    if (recurringOrders != null) {
      data['recurring_orders'] =
          recurringOrders!.map((v) => v.toJson()).toList();
    }
    if (pastOrders != null) {
      data['past_orders'] = pastOrders!.map((v) => v.toJson()).toList();
    }
    if (cancelledOrders != null) {
      data['cancelled_orders'] =
          cancelledOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecurringOrders {
  String? title;
  String? smallImageUrl;

  RecurringOrders({this.title, this.smallImageUrl});

  RecurringOrders.fromJson(Map<String, dynamic> json) {
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

class PastOrders {
  int? orderId;
  String? createdAt;
  OngoingOrder? inventory;

  PastOrders({this.orderId, this.createdAt, this.inventory});

  PastOrders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    createdAt = json['created_at'];
    inventory = json['inventory'] != null
        ? OngoingOrder.fromJson(json['inventory'])
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

class CancelledOrders {
  int? orderId;
  String? createdAt;
  OngoingOrder? inventory;

  CancelledOrders({this.orderId, this.createdAt, this.inventory});

  CancelledOrders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    createdAt = json['cancelled_at'];
    inventory = json['inventory'] != null
        ? OngoingOrder.fromJson(json['inventory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['cancelled_at'] = createdAt;
    if (inventory != null) {
      data['inventory'] = inventory!.toJson();
    }
    return data;
  }
}
