class FeedDropDownInfo {
  FeedDropDownInfo({
    required this.status,
    required this.success,
    required this.data,
    required this.message,
  });
  late final int status;
  late final bool success;
  late final Data data;
  late final String message;
  
  FeedDropDownInfo.fromJson(Map<String, dynamic> json){
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
    required this.feedType,
    required this.feedFrequency,
  });
  late final List<FeedType> feedType;
  late final List<FeedFrequency> feedFrequency;
  
  Data.fromJson(Map<String, dynamic> json){
    feedType = List.from(json['feedType']).map((e)=>FeedType.fromJson(e)).toList();
    feedFrequency = List.from(json['feedFrequency']).map((e)=>FeedFrequency.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['feedType'] = feedType.map((e)=>e.toJson()).toList();
    _data['feedFrequency'] = feedFrequency.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class FeedType {
  FeedType({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  FeedType.fromJson(Map<String, dynamic> json){
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

class FeedFrequency {
  FeedFrequency({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  FeedFrequency.fromJson(Map<String, dynamic> json){
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