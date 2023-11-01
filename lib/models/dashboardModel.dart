class DashboardModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  DashboardModel({this.status, this.success, this.data, this.message});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  Order? order;
  String? userName;
  List<PrimaryFarmLocation>? primaryFarmLocation;
  List<CurrentFeed>? currentFeed;
  int? profileCompletionPercentage;
  TrainingVideos? trainingVideos;
  Article? article;

  Data(
      {this.order,
      this.userName,
      this.primaryFarmLocation,
      this.currentFeed,
      this.profileCompletionPercentage,
      this.trainingVideos,
      this.article});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    if (json['primaryFarmLocation'] != null) {
      primaryFarmLocation = <PrimaryFarmLocation>[];
      json['primaryFarmLocation'].forEach((v) {
        primaryFarmLocation!.add(PrimaryFarmLocation.fromJson(v));
      });
    }
    if (json['current_feed'] != null) {
      currentFeed = <CurrentFeed>[];
      json['current_feed'].forEach((v) {
        currentFeed!.add(CurrentFeed.fromJson(v));
      });
    }
    profileCompletionPercentage = json['profileCompletionPercentage'];
    trainingVideos = json['trainingVideos'] != null
        ? json['trainingVideos'].isNotEmpty
            ? TrainingVideos.fromJson(json['trainingVideos'])
            : TrainingVideos(
                bookmarked: false,
                id: 0,
                publishedDatetime: "",
                smallDescription: "",
                title: "",
                videoUrl: "")
        : null;
    article =
        json['article'] != null ? Article.fromJson(json['article']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (primaryFarmLocation != null) {
      data['primaryFarmLocation'] =
          primaryFarmLocation!.map((v) => v.toJson()).toList();
    }
    if (currentFeed != null) {
      data['current_feed'] = currentFeed!.map((v) => v.toJson()).toList();
    }
    data['profileCompletionPercentage'] = profileCompletionPercentage;
    if (trainingVideos != null) {
      data['trainingVideos'] = trainingVideos!.toJson();
    }
    if (article != null) {
      data['article'] = article!.toJson();
    }
    return data;
  }
}

class Order {
  int? totalQuantities;
  int? orderStatus;

  Order({this.totalQuantities, this.orderStatus});

  Order.fromJson(Map<String, dynamic> json) {
    totalQuantities = json['totalQuantities'];
    orderStatus = json['orderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalQuantities'] = totalQuantities;
    data['orderStatus'] = orderStatus;
    return data;
  }
}

class PrimaryFarmLocation {
  String? farmLatitude;
  String? farmLongitude;

  PrimaryFarmLocation({this.farmLatitude, this.farmLongitude});

  PrimaryFarmLocation.fromJson(Map<String, dynamic> json) {
    farmLatitude = json['farm_latitude'];
    farmLongitude = json['farm_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farm_latitude'] = farmLatitude;
    data['farm_longitude'] = farmLongitude;
    return data;
  }
}

class CurrentFeed {
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
  double? feedLowPer;
  String? livestockName;
  String? livestockUri;
  String? container;

  CurrentFeed({
    this.id,
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
    this.container,
  });

  CurrentFeed.fromJson(Map<String, dynamic> json) {
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
    feedLowPer =
        json['feed_low_per'] == null ? 102 : json['feed_low_per'].toDouble();
    livestockName = json['livestock_name'];
    livestockUri = json['livestock_uri'];
    container = json["container"];
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

class TrainingVideos {
  int? id;
  String? title;
  String? smallDescription;
  String? videoUrl;
  String? publishedDatetime;
  bool? bookmarked;

  TrainingVideos(
      {this.id,
      this.title,
      this.smallDescription,
      this.videoUrl,
      this.publishedDatetime,
      this.bookmarked});

  TrainingVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    smallDescription = json['small_description'];
    videoUrl = json['video_url'];
    publishedDatetime = json['published_datetime'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['small_description'] = smallDescription;
    data['video_url'] = videoUrl;
    data['published_datetime'] = publishedDatetime;
    data['bookmarked'] = bookmarked;
    return data;
  }
}

class Article {
  int? id;
  int? articleCategoryXid;
  String? title;
  String? smallDescription;
  String? smallImageUrl;
  String? publishedDatetime;
  String? artCategory;
  bool? bookmarked;

  Article(
      {this.id,
      this.articleCategoryXid,
      this.title,
      this.smallDescription,
      this.smallImageUrl,
      this.publishedDatetime,
      this.artCategory,
      this.bookmarked});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    articleCategoryXid = json['article_category_xid'];
    title = json['title'];
    smallDescription = json['small_description'];
    smallImageUrl = json['small_image_url'];
    publishedDatetime = json['published_datetime'];
    artCategory = json['art_category'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['article_category_xid'] = articleCategoryXid;
    data['title'] = title;
    data['small_description'] = smallDescription;
    data['small_image_url'] = smallImageUrl;
    data['published_datetime'] = publishedDatetime;
    data['art_category'] = artCategory;
    data['bookmarked'] = bookmarked;
    return data;
  }
}
