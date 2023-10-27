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

  FeedDropDownInfo.fromJson(Map<String, dynamic> json) {
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
    required this.livestockType,
    required this.feedType,
    required this.feedFrequency,
    required this.feed,
  });
  late final List<LivestockType> livestockType;
  late final List<FeedType> feedType;
  late final List<FeedFrequency> feedFrequency;
  late final Feed? feed;

  Data.fromJson(Map<String, dynamic> json) {
    livestockType = List.from(json['livestockType'])
        .map((e) => LivestockType.fromJson(e))
        .toList();
    feedType =
        List.from(json['feedType']).map((e) => FeedType.fromJson(e)).toList();
    feedFrequency = List.from(json['feedFrequency'])
        .map((e) => FeedFrequency.fromJson(e))
        .toList();
    feed = json['feed'] != null ? Feed.fromJson(json['feed']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['livestockType'] = livestockType.map((e) => e.toJson()).toList();
    _data['feedType'] = feedType.map((e) => e.toJson()).toList();
    _data['feedFrequency'] = feedFrequency.map((e) => e.toJson()).toList();
    if (this.feed != null) {
      _data['feed'] = feed!.toJson();
    }
    return _data;
  }
}

class LivestockType {
  LivestockType({
    required this.id,
    required this.name,
    required this.smallImageUrl,
  });
  late final int id;
  late final String name;
  late final String smallImageUrl;
  bool updated = false;

  LivestockType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['small_image_url'] = smallImageUrl;
    return _data;
  }
}

class Feed {
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
  String? livestockName;
  String? livestockUri;

  Feed(
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
      this.livestockName,
      this.livestockUri});

  Feed.fromJson(Map<String, dynamic> json) {
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
    livestockName = json['livestock_name'];
    livestockUri = json['livestock_uri'];
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
    data['livestock_name'] = livestockName;
    data['livestock_uri'] = livestockUri;
    return data;
  }
}

class FeedType {
  FeedType({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  FeedType.fromJson(Map<String, dynamic> json) {
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

  FeedFrequency.fromJson(Map<String, dynamic> json) {
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
