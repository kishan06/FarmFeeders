class LiveStockTypeModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  LiveStockTypeModel({this.status, this.success, this.data, this.message});

  LiveStockTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? smallImageUrl;
  bool? filled;
  List<UserLivestockLink>? userLivestockLink;

  Data(
      {this.id,
      this.name,
      this.smallImageUrl,
      this.filled,
      this.userLivestockLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    smallImageUrl = json['small_image_url'];
    filled = json['filled'];
    if (json['user_livestock_link'] != null) {
      userLivestockLink = <UserLivestockLink>[];
      json['user_livestock_link'].forEach((v) {
        userLivestockLink!.add(UserLivestockLink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['small_image_url'] = smallImageUrl;
    data['filled'] = filled;
    if (userLivestockLink != null) {
      data['user_livestock_link'] =
          userLivestockLink!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserLivestockLink {
  int? id;
  int? farmerXid;
  int? livestockTypeXid;
  int? livestockAgeXid;
  int? livestockBreedXid;
  int? number;
  int? active;

  String? createdAt;
  String? updatedAt;

  UserLivestockLink({
    this.id,
    this.farmerXid,
    this.livestockTypeXid,
    this.livestockAgeXid,
    this.livestockBreedXid,
    this.number,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  UserLivestockLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerXid = json['farmer_xid'];
    livestockTypeXid = json['livestock_type_xid'];
    livestockAgeXid = json['livestock_age_xid'];
    livestockBreedXid = json['livestock_breed_xid'];
    number = json['number'];
    active = json['active'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_xid'] = farmerXid;
    data['livestock_type_xid'] = livestockTypeXid;
    data['livestock_age_xid'] = livestockAgeXid;
    data['livestock_breed_xid'] = livestockBreedXid;
    data['number'] = number;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
