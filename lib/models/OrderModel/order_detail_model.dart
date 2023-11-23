class OrderDetailModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  OrderDetailModel({this.status, this.success, this.data, this.message});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? orderId;
  int? farmerXid;
  String? orderTitle;
  String? billingAddress;
  String? shippingAddress;
  String? shippingLatitude;
  String? shippingLongitude;
  int? orderFrequencyXid;
  int? orderSalesRepXid;
  int? orderDeliveryAgentXid;
  int? orderStatusXid;
  String? recurringStartDate;
  String? recurringEndDate;
  String? discountType;
  String? discountValue;
  String? totalValue;
  String? netValue;
  String? deliveryInstruction;
  String? orderDate;
  OrderFrequency? orderFrequency;
  OrderFrequency? orderStatus;
  String? salesman;
  List<OrderDetails>? orderDetails;

  Data(
      {this.orderId,
      this.farmerXid,
      this.orderTitle,
      this.billingAddress,
      this.shippingAddress,
      this.shippingLatitude,
      this.shippingLongitude,
      this.orderFrequencyXid,
      this.orderSalesRepXid,
      this.orderDeliveryAgentXid,
      this.orderStatusXid,
      this.recurringStartDate,
      this.recurringEndDate,
      this.discountType,
      this.discountValue,
      this.totalValue,
      this.netValue,
      this.deliveryInstruction,
      this.orderDate,
      this.orderFrequency,
      this.orderStatus,
      this.salesman,
      this.orderDetails});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    farmerXid = json['farmer_xid'];
    orderTitle = json['order_title'];
    billingAddress = json['billing_address'];
    shippingAddress = json['shipping_address'];
    shippingLatitude = json['shipping_latitude'];
    shippingLongitude = json['shipping_longitude'];
    orderFrequencyXid = json['order_frequency_xid'];
    orderSalesRepXid = json['order_sales_rep_xid'];
    orderDeliveryAgentXid = json['order_delivery_agent_xid'] ?? 0;
    orderStatusXid = json['order_status_xid'];
    recurringStartDate = json['recurring_start_date'] ?? "";
    recurringEndDate = json['recurring_end_date'] ?? "";
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    totalValue = json['total_value'];
    netValue = json['net_value'];
    deliveryInstruction = json['delivery_instruction'] ?? "";
    orderDate = json['order_date'];
    orderFrequency = json['order_frequency'] != null
        ? OrderFrequency.fromJson(json['order_frequency'])
        : null;
    orderStatus = json['order_status'] != null
        ? OrderFrequency.fromJson(json['order_status'])
        : null;
    salesman = json['salesman'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['farmer_xid'] = farmerXid;
    data['order_title'] = orderTitle;
    data['billing_address'] = billingAddress;
    data['shipping_address'] = shippingAddress;
    data['shipping_latitude'] = shippingLatitude;
    data['shipping_longitude'] = shippingLongitude;
    data['order_frequency_xid'] = orderFrequencyXid;
    data['order_sales_rep_xid'] = orderSalesRepXid;
    data['order_delivery_agent_xid'] = orderDeliveryAgentXid;
    data['order_status_xid'] = orderStatusXid;
    data['recurring_start_date'] = recurringStartDate;
    data['recurring_end_date'] = recurringEndDate;
    data['discount_type'] = discountType;
    data['discount_value'] = discountValue;
    data['total_value'] = totalValue;
    data['net_value'] = netValue;
    data['delivery_instruction'] = deliveryInstruction;
    data['order_date'] = orderDate;
    if (orderFrequency != null) {
      data['order_frequency'] = orderFrequency!.toJson();
    }
    if (orderStatus != null) {
      data['order_status'] = orderStatus!.toJson();
    }
    data['salesman'] = salesman;
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderFrequency {
  int? id;
  String? name;

  OrderFrequency({this.id, this.name});

  OrderFrequency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class OrderDetails {
  int? orderHeaderXid;
  int? inventoryXid;
  int? quantity;
  String? itemUnitValue;
  String? totalUnitValue;
  String? inventoryTitle;
  String? inventoryImage;

  OrderDetails(
      {this.orderHeaderXid,
      this.inventoryXid,
      this.quantity,
      this.itemUnitValue,
      this.totalUnitValue,
      this.inventoryTitle,
      this.inventoryImage});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderHeaderXid = json['order_header_xid'];
    inventoryXid = json['inventory_xid'];
    quantity = json['quantity'];
    itemUnitValue = json['item_unit_value'];
    totalUnitValue = json['total_unit_value'];
    inventoryTitle = json['inventory_title'];
    inventoryImage = json['inventory_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_header_xid'] = orderHeaderXid;
    data['inventory_xid'] = inventoryXid;
    data['quantity'] = quantity;
    data['item_unit_value'] = itemUnitValue;
    data['total_unit_value'] = totalUnitValue;
    data['inventory_title'] = inventoryTitle;
    data['inventory_image'] = inventoryImage;
    return data;
  }
}
