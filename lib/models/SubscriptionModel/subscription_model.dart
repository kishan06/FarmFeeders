class SubscriptionPlanModel {
  int? status;
  bool? success;
  List<SubscriptionData>? data;
  String? message;

  SubscriptionPlanModel({this.status, this.success, this.data, this.message});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <SubscriptionData>[];
      json['data'].forEach((v) {
        data!.add(SubscriptionData.fromJson(v));
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

class SubscriptionData {
  int? id;
  String? title;
  String? description;
  String? monthlyFee;
  String? stripeProductId;
  String? stripePriceId;
  int? validDays;
  int? active;
  bool? plan;
  String? stripeSubscriptionId;
  String? nextPaymentDate;
  String? customerId;

  SubscriptionData({
    this.id,
    this.title,
    this.description,
    this.monthlyFee,
    this.stripeProductId,
    this.stripePriceId,
    this.validDays,
    this.active,
    this.plan,
    this.stripeSubscriptionId,
    this.nextPaymentDate,
    this.customerId,
  });

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    monthlyFee = json['monthly_fee'];
    stripeProductId = json['stripe_product_id'];
    stripePriceId = json['stripe_price_id'];
    validDays = json['valid_days'];
    active = json['active'];
    plan = json['plan'];
    nextPaymentDate = json['next_payment_date'];
    stripeSubscriptionId = json['stripe_subscription_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['monthly_fee'] = monthlyFee;
    data['stripe_product_id'] = stripeProductId;
    data['stripe_price_id'] = stripePriceId;
    data['valid_days'] = validDays;
    data['active'] = active;
    data['plan'] = plan;
    data['stripe_subscription_id'] = stripeSubscriptionId;
    data['next_payment_date'] = nextPaymentDate;
    data['customer_id'] = customerId;
    return data;
  }
}
