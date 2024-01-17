// class RecurringOrderDetailsModel {
//   int? status;
//   bool? success;
//   Data? data;
//   String? message;

//   RecurringOrderDetailsModel(
//       {this.status, this.success, this.data, this.message});

//   RecurringOrderDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     success = json['success'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['success'] = success;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = message;
//     return data;
//   }
// }

// class Data {
//   ParentOrder? parentOrder;
//   OrderDetails? orderDetails;
//   List<Null>? deliveryStatus;

//   Data({this.parentOrder, this.orderDetails, this.deliveryStatus});

//   Data.fromJson(Map<String, dynamic> json) {
//     parentOrder = json['parent_order'] != null
//         ? ParentOrder.fromJson(json['parent_order'])
//         : null;
//     orderDetails = json['order_details'] != null
//         ? OrderDetails.fromJson(json['order_details'])
//         : null;
//     if (json['delivery_status'] != null) {
//       deliveryStatus = <Null>[];
//       json['delivery_status'].forEach((v) {
//         deliveryStatus!.add(Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (parentOrder != null) {
//       data['parent_order'] = parentOrder!.toJson();
//     }
//     if (orderDetails != null) {
//       data['order_details'] = orderDetails!.toJson();
//     }
//     if (deliveryStatus != null) {
//       data['delivery_status'] = deliveryStatus!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ParentOrder {
//   int? id;
//   String? netValue;
//   String? deliveryDate;

//   ParentOrder({this.id, this.netValue, this.deliveryDate});

//   ParentOrder.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     netValue = json['net_value'];
//     deliveryDate = json['delivery_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['net_value'] = netValue;
//     data['delivery_date'] = deliveryDate;
//     return data;
//   }
// }

// class OrderDetails {
//   int? orderId;
//   int? orderDeliveryAgentXid;
//   int? orderStatusXid;
//   String? discountType;
//   String? discountValue;
//   double? totalValue;
//   double? netValue;
//   String? orderDate;
//   OrderStatus? orderStatus;
//   List<OtherOrderDetails>? orderDetails;

//   OrderDetails(
//       {this.orderId,
//       this.orderDeliveryAgentXid,
//       this.orderStatusXid,
//       this.discountType,
//       this.discountValue,
//       this.totalValue,
//       this.netValue,
//       this.orderDate,
//       this.orderStatus,
//       this.orderDetails});

//   OrderDetails.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     orderDeliveryAgentXid = json['order_delivery_agent_xid'];
//     orderStatusXid = json['order_status_xid'];
//     discountType = json['discount_type'];
//     discountValue = json['discount_value'];
//     totalValue = json['total_value'];
//     netValue = json['net_value'];
//     orderDate = json['order_date'];
//     orderStatus = json['order_status'] != null
//         ? OrderStatus.fromJson(json['order_status'])
//         : null;
//     if (json['order_details'] != null) {
//       orderDetails = <OtherOrderDetails>[];
//       json['order_details'].forEach((v) {
//         orderDetails!.add(OtherOrderDetails.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['order_id'] = orderId;
//     data['order_delivery_agent_xid'] = orderDeliveryAgentXid;
//     data['order_status_xid'] = orderStatusXid;
//     data['discount_type'] = discountType;
//     data['discount_value'] = discountValue;
//     data['total_value'] = totalValue;
//     data['net_value'] = netValue;
//     data['order_date'] = orderDate;
//     if (orderStatus != null) {
//       data['order_status'] = orderStatus!.toJson();
//     }
//     if (orderDetails != null) {
//       data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class OrderStatus {
//   int? id;
//   String? name;

//   OrderStatus({this.id, this.name});

//   OrderStatus.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }

// class OtherOrderDetails {
//   int? orderHeaderXid;
//   int? inventoryXid;
//   String? lot;
//   int? quantity;
//   String? itemUnitValue;
//   String? totalUnitValue;
//   String? inventoryTitle;
//   String? inventoryImage;

//   OtherOrderDetails(
//       {this.orderHeaderXid,
//       this.inventoryXid,
//       this.lot,
//       this.quantity,
//       this.itemUnitValue,
//       this.totalUnitValue,
//       this.inventoryTitle,
//       this.inventoryImage});

//   OtherOrderDetails.fromJson(Map<String, dynamic> json) {
//     orderHeaderXid = json['order_header_xid'] ?? 0;
//     inventoryXid = json['inventory_xid'];
//     lot = json['lot'];
//     quantity = json['quantity'];
//     itemUnitValue = json['item_unit_value'];
//     totalUnitValue = json['total_unit_value'];
//     inventoryTitle = json['inventory_title'];
//     inventoryImage = json['inventory_image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['order_header_xid'] = orderHeaderXid;
//     data['inventory_xid'] = inventoryXid;
//     data['lot'] = lot;
//     data['quantity'] = quantity;
//     data['item_unit_value'] = itemUnitValue;
//     data['total_unit_value'] = totalUnitValue;
//     data['inventory_title'] = inventoryTitle;
//     data['inventory_image'] = inventoryImage;
//     return data;
//   }
// }
