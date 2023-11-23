class SubUserModel {
  int? status;
  bool? success;
  List<SubUserData>? data;
  String? message;

  SubUserModel({this.status, this.success, this.data, this.message});

  SubUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <SubUserData>[];
      json['data'].forEach((v) {
        data!.add(SubUserData.fromJson(v));
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

class SubUserData {
  int? id;
  String? name;
  String? dob;
  String? phoneNumber;
  String? email;
  String? address;
  List<int>? permissions;

  SubUserData(
      {this.id,
      this.name,
      this.dob,
      this.phoneNumber,
      this.email,
      this.address,
      this.permissions});

  SubUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    address = json['address'];
    permissions = json['permissions'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dob'] = dob;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['permissions'] = permissions;
    return data;
  }
}
