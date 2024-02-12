class SubscriptionPlanModel1 {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  SubscriptionPlanModel1({this.status, this.success, this.data, this.message});

  SubscriptionPlanModel1.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? description;
  String? monthlyFee;

  String? stripeProductId;
  String? stripePriceId;
  int? validDays;
  int? active;

  Data({
    this.id,
    this.title,
    this.description,
    this.monthlyFee,
    this.stripeProductId,
    this.stripePriceId,
    this.validDays,
    this.active,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    monthlyFee = json['monthly_fee'];
    stripeProductId = json['stripe_product_id'];

    stripePriceId = json['stripe_price_id'];
    validDays = json['valid_days'];
    active = json['active'];
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
    return data;
  }
}
