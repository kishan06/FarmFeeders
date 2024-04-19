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
  OrderDetails? orderDetails;
  List<DeliveryStatus>? deliveryStatus;
  String? deliveryOtp;

  Data({
    this.orderDetails,
    this.deliveryStatus,
    this.deliveryOtp,
  });

  Data.fromJson(Map<String, dynamic> json) {
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
    deliveryOtp = json['delivery_otp'] ?? "";
    if (json['delivery_status'] != null) {
      deliveryStatus = <DeliveryStatus>[];
      json['delivery_status'].forEach((v) {
        deliveryStatus!.add(DeliveryStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.toJson();
    }
    data['delivery_otp'] = deliveryOtp;
    if (deliveryStatus != null) {
      data['delivery_status'] = deliveryStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
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
  int? orderType;
  OrderFrequency? orderFrequency;
  OrderFrequency? orderStatus;
  String? salesman;
  DeliveryAgent? deliveryAgent;
  Farmer? farmer;
  List<NewOrderDetails>? orderDetails;

  OrderDetails(
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
      this.deliveryAgent,
      this.farmer,
      this.orderType,
      this.orderDetails});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    farmerXid = json['farmer_xid'];
    orderTitle = json['order_title'];
    billingAddress = json['billing_address'];
    shippingAddress = json['shipping_address'];
    shippingLatitude = json['shipping_latitude'];
    shippingLongitude = json['shipping_longitude'];
    orderFrequencyXid = json['order_frequency_xid'];
    orderSalesRepXid = json['order_sales_rep_xid'];
    orderDeliveryAgentXid = json['order_delivery_agent_xid'];
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
    deliveryAgent = json['delivery_agent'] != null
        ? DeliveryAgent.fromJson(json['delivery_agent'])
        : null;
    orderType = json["order_type"];
    farmer = json['farmer'] != null ? Farmer.fromJson(json['farmer']) : null;
    if (json['order_details'] != null) {
      orderDetails = <NewOrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(NewOrderDetails.fromJson(v));
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
    data['order_type'] = orderType;
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
    if (deliveryAgent != null) {
      data['delivery_agent'] = deliveryAgent!.toJson();
    }
    if (farmer != null) {
      data['farmer'] = farmer!.toJson();
    }
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

class DeliveryAgent {
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? addressLine1;
  String? profilePhoto;
  bool? pin;
  // List<Null>? feedDetails;

  DeliveryAgent({
    this.id,
    this.principalTypeXid,
    this.principalSourceXid,
    this.userName,
    this.dateOfBirth,
    this.phoneNumber,
    this.emailAddress,
    this.addressLine1,
    this.profilePhoto,
    this.pin,
    // this.feedDetails
  });

  DeliveryAgent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalTypeXid = json['principal_type_xid'];
    principalSourceXid = json['principal_source_xid'];
    userName = json['user_name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    addressLine1 = json['address_line1'] ?? "";
    profilePhoto = json['profile_photo'];
    pin = json['pin'];
    // if (json['feed_details'] != null) {
    //   feedDetails = <Null>[];
    //   json['feed_details'].forEach((v) {
    //     feedDetails!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['principal_type_xid'] = principalTypeXid;
    data['principal_source_xid'] = principalSourceXid;
    data['user_name'] = userName;
    data['date_of_birth'] = dateOfBirth;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['address_line1'] = addressLine1;
    data['profile_photo'] = profilePhoto;
    data['pin'] = pin;
    // if (feedDetails != null) {
    //   data['feed_details'] = feedDetails!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Farmer {
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? addressLine1;
  String? profilePhoto;
  bool? pin;
  List<FeedDetails>? feedDetails;

  Farmer(
      {this.id,
      this.principalTypeXid,
      this.principalSourceXid,
      this.userName,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAddress,
      this.addressLine1,
      this.profilePhoto,
      this.pin,
      this.feedDetails});

  Farmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalTypeXid = json['principal_type_xid'];
    principalSourceXid = json['principal_source_xid'];
    userName = json['user_name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    addressLine1 = json['address_line1'] ?? "";
    profilePhoto = json['profile_photo'];
    pin = json['pin'];
    if (json['feed_details'] != null) {
      feedDetails = <FeedDetails>[];
      json['feed_details'].forEach((v) {
        feedDetails!.add(FeedDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['principal_type_xid'] = principalTypeXid;
    data['principal_source_xid'] = principalSourceXid;
    data['user_name'] = userName;
    data['date_of_birth'] = dateOfBirth;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['address_line1'] = addressLine1;
    data['profile_photo'] = profilePhoto;
    data['pin'] = pin;
    if (feedDetails != null) {
      data['feed_details'] = feedDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedDetails {
  int? id;
  int? farmerXid;
  int? livestockTypeXid;
  int? currentFeedAvailable;
  int? feedTypeXid;
  int? feedFrequencyXid;
  int? qtyPerSeed;
  int? minBinCapacity;
  int? maxBinCapacity;
  String? reorderingDate;
  bool? feedLow;
  int? feedLowPer;
  String? livestockName;
  String? livestockUri;
  String? container;

  FeedDetails(
      {this.id,
      this.farmerXid,
      this.livestockTypeXid,
      this.currentFeedAvailable,
      this.feedTypeXid,
      this.feedFrequencyXid,
      this.qtyPerSeed,
      this.minBinCapacity,
      this.maxBinCapacity,
      this.reorderingDate,
      this.feedLow,
      this.feedLowPer,
      this.livestockName,
      this.livestockUri,
      this.container});

  FeedDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerXid = json['farmer_xid'];
    livestockTypeXid = json['livestock_type_xid'];
    currentFeedAvailable = json['current_feed_available'];
    feedTypeXid = json['feed_type_xid'];
    feedFrequencyXid = json['feed_frequency_xid'];
    qtyPerSeed = json['qty_per_seed'];
    minBinCapacity = json['min_bin_capacity'];
    maxBinCapacity = json['max_bin_capacity'];
    reorderingDate = json['reordering_date'];
    feedLow = json['feed_low'];
    feedLowPer = json['feed_low_per'];
    livestockName = json['livestock_name'];
    livestockUri = json['livestock_uri'];
    container = json['container'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_xid'] = farmerXid;
    data['livestock_type_xid'] = livestockTypeXid;
    data['current_feed_available'] = currentFeedAvailable;
    data['feed_type_xid'] = feedTypeXid;
    data['feed_frequency_xid'] = feedFrequencyXid;
    data['qty_per_seed'] = qtyPerSeed;
    data['min_bin_capacity'] = minBinCapacity;
    data['max_bin_capacity'] = maxBinCapacity;
    data['reordering_date'] = reorderingDate;
    data['feed_low'] = feedLow;
    data['feed_low_per'] = feedLowPer;
    data['livestock_name'] = livestockName;
    data['livestock_uri'] = livestockUri;
    data['container'] = container;
    return data;
  }
}

class NewOrderDetails {
  int? orderHeaderXid;
  int? inventoryXid;
  int? quantity;
  String? lot;
  String? itemUnitValue;
  String? totalUnitValue;
  String? inventoryTitle;
  String? inventoryImage;

  NewOrderDetails(
      {this.orderHeaderXid,
      this.inventoryXid,
      this.quantity,
      this.lot,
      this.itemUnitValue,
      this.totalUnitValue,
      this.inventoryTitle,
      this.inventoryImage});

  NewOrderDetails.fromJson(Map<String, dynamic> json) {
    orderHeaderXid = json['order_header_xid'];
    lot = json['lot'];
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
    data['lot'] = lot;
    data['item_unit_value'] = itemUnitValue;
    data['total_unit_value'] = totalUnitValue;
    data['inventory_title'] = inventoryTitle;
    data['inventory_image'] = inventoryImage;
    return data;
  }
}

class DeliveryStatus {
  int? deliveryStatusXid;
  String? createdAt;

  DeliveryStatus({this.deliveryStatusXid, this.createdAt});

  DeliveryStatus.fromJson(Map<String, dynamic> json) {
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
