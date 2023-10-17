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
  
  LiveStockModel.fromJson(Map<String, dynamic> json){
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
  });
  late final List<BreedList> breedList;
  late final List<AgeList> ageList;
  
  Data.fromJson(Map<String, dynamic> json){
    breedList = List.from(json['breed_list']).map((e)=>BreedList.fromJson(e)).toList();
    ageList = List.from(json['age_list']).map((e)=>AgeList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['breed_list'] = breedList.map((e)=>e.toJson()).toList();
    _data['age_list'] = ageList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class BreedList {
  BreedList({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  BreedList.fromJson(Map<String, dynamic> json){
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
  
  AgeList.fromJson(Map<String, dynamic> json){
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