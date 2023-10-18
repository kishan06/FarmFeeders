class FarmInfoAddressModel {
  int? farmCount;
  List<Farms>? farms;

  FarmInfoAddressModel({this.farmCount, this.farms});

  FarmInfoAddressModel.fromJson(Map<String, dynamic> json) {
    farmCount = json['farm_count'];
    if (json['farms'] != null) {
      farms = <Farms>[];
      json['farms'].forEach((v) {
        farms!.add(Farms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farm_count'] = farmCount;
    if (farms != null) {
      data['farms'] = farms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Farms {
  String? farmAddress;
  double? farmLatitude;
  double? farmLongitude;
  String? street;
  String? city;
  String? province;
  String? country;
  String? postalCode;

  Farms(
      {this.farmAddress,
      this.farmLatitude,
      this.farmLongitude,
      this.street,
      this.city,
      this.province,
      this.country,
      this.postalCode});

  Farms.fromJson(Map<String, dynamic> json) {
    farmAddress = json['farm_address'];
    farmLatitude = json['farm_latitude'];
    farmLongitude = json['farm_longitude'];
    street = json['street'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farm_address'] = farmAddress;
    data['farm_latitude'] = farmLatitude;
    data['farm_longitude'] = farmLongitude;
    data['street'] = street;
    data['city'] = city;
    data['province'] = province;
    data['country'] = country;
    data['postal_code'] = postalCode;
    return data;
  }
}
