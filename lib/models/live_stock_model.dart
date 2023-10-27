class LiveStockModel {
  LiveStockModel({
    required this.status,
    required this.success,
    required this.data,
    required this.message,
  });
  late final int status;
  late final bool success;
  late final Data data;
  late final String message;

  LiveStockModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.breedList,
    required this.ageList,
    required this.livestock,
  });
  late final List<BreedList> breedList;
  late final List<AgeList> ageList;
  late final Livestock? livestock;

  Data.fromJson(Map<String, dynamic> json) {
    breedList = List.from(json['breed_list'])
        .map((e) => BreedList.fromJson(e))
        .toList();
    ageList =
        List.from(json['age_list']).map((e) => AgeList.fromJson(e)).toList();
    livestock = json['livestock'] != null
        ? Livestock.fromJson(json['livestock'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['breed_list'] = breedList.map((e) => e.toJson()).toList();
    _data['age_list'] = ageList.map((e) => e.toJson()).toList();
    if (livestock != null) {
      _data['livestock'] = livestock!.toJson();
    }
    return _data;
  }
}

class Livestock {
  int? id;
  int? farmerXid;
  int? livestockTypeXid;
  int? livestockAgeXid;
  int? livestockBreedXid;
  int? number;

  Livestock(
      {this.id,
      this.farmerXid,
      this.livestockTypeXid,
      this.livestockAgeXid,
      this.livestockBreedXid,
      this.number});

  Livestock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerXid = json['farmer_xid'];
    livestockTypeXid = json['livestock_type_xid'];
    livestockAgeXid = json['livestock_age_xid'];
    livestockBreedXid = json['livestock_breed_xid'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['farmer_xid'] = farmerXid;
    data['livestock_type_xid'] = livestockTypeXid;
    data['livestock_age_xid'] = livestockAgeXid;
    data['livestock_breed_xid'] = livestockBreedXid;
    data['number'] = number;
    return data;
  }
}

class BreedList {
  BreedList({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  BreedList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class AgeList {
  AgeList({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  AgeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
