class ExpertList {
  int? status;
  bool? success;
  Data? data;
  String? message;

  ExpertList({this.status, this.success, this.data, this.message});

  ExpertList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Advisors>? advisors;
  List<Veterinarian>? veterinarian;
  List<Repairmen>? repairmen;

  Data({this.advisors, this.veterinarian, this.repairmen});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Advisors'] != null) {
      advisors = <Advisors>[];
      json['Advisors'].forEach((v) {
        advisors!.add(new Advisors.fromJson(v));
      });
    }
    if (json['Veterinarian'] != null) {
      veterinarian = <Veterinarian>[];
      json['Veterinarian'].forEach((v) {
        veterinarian!.add(new Veterinarian.fromJson(v));
      });
    }
    if (json['Repairmen'] != null) {
      repairmen = <Repairmen>[];
      json['Repairmen'].forEach((v) {
        repairmen!.add(new Repairmen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advisors != null) {
      data['Advisors'] = this.advisors!.map((v) => v.toJson()).toList();
    }
    if (this.veterinarian != null) {
      data['Veterinarian'] = this.veterinarian!.map((v) => v.toJson()).toList();
    }
    if (this.repairmen != null) {
      data['Repairmen'] = this.repairmen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Advisors {
  int? id;
  String? name;
  String? contactNumber;
  String? emailAddress;
  String? smallImageUrl;
  int? expertCategoryXid;
  String? location;
  String? category;
  bool? bookmarked;

  Advisors(
      {this.id,
      this.name,
      this.contactNumber,
      this.emailAddress,
      this.smallImageUrl,
      this.expertCategoryXid,
      this.location,
      this.category,
      this.bookmarked});

  Advisors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contact_number'];
    emailAddress = json['email_address'];
    smallImageUrl = json['small_image_url'];
    expertCategoryXid = json['expert_category_xid'];
    location = json['location'];
    category = json['category'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact_number'] = this.contactNumber;
    data['email_address'] = this.emailAddress;
    data['small_image_url'] = this.smallImageUrl;
    data['expert_category_xid'] = this.expertCategoryXid;
    data['location'] = this.location;
    data['category'] = this.category;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}

class Veterinarian {
  int? id;
  String? name;
  String? contactNumber;
  String? emailAddress;
  String? smallImageUrl;
  int? expertCategoryXid;
  String? location;
  String? category;
  bool? bookmarked;

  Veterinarian(
      {this.id,
      this.name,
      this.contactNumber,
      this.emailAddress,
      this.smallImageUrl,
      this.expertCategoryXid,
      this.location,
      this.category,
      this.bookmarked});

  Veterinarian.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contact_number'];
    emailAddress = json['email_address'];
    smallImageUrl = json['small_image_url'];
    expertCategoryXid = json['expert_category_xid'];
    location = json['location'];
    category = json['category'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact_number'] = this.contactNumber;
    data['email_address'] = this.emailAddress;
    data['small_image_url'] = this.smallImageUrl;
    data['expert_category_xid'] = this.expertCategoryXid;
    data['location'] = this.location;
    data['category'] = this.category;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}

class Repairmen {
  int? id;
  String? name;
  String? contactNumber;
  String? emailAddress;
  String? smallImageUrl;
  int? expertCategoryXid;
  String? location;
  String? category;
  bool? bookmarked;

  Repairmen(
      {this.id,
      this.name,
      this.contactNumber,
      this.emailAddress,
      this.smallImageUrl,
      this.expertCategoryXid,
      this.location,
      this.category,
      this.bookmarked});

  Repairmen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contact_number'];
    emailAddress = json['email_address'];
    smallImageUrl = json['small_image_url'];
    expertCategoryXid = json['expert_category_xid'];
    location = json['location'];
    category = json['category'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact_number'] = this.contactNumber;
    data['email_address'] = this.emailAddress;
    data['small_image_url'] = this.smallImageUrl;
    data['expert_category_xid'] = this.expertCategoryXid;
    data['location'] = this.location;
    data['category'] = this.category;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}
