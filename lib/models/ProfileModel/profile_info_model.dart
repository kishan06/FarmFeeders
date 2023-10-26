class ProfileInfoModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  ProfileInfoModel({this.status, this.success, this.data, this.message});

  ProfileInfoModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? addressLine1;
  String? profilePhoto;

  Data({
    this.id,
    this.principalTypeXid,
    this.principalSourceXid,
    this.userName,
    this.dateOfBirth,
    this.phoneNumber,
    this.emailAddress,
    this.addressLine1,
    this.profilePhoto,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalTypeXid = json['principal_type_xid'];
    principalSourceXid = json['principal_source_xid'];
    userName = json['user_name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    addressLine1 = json['address_line1'] ?? "";
    profilePhoto = json["profile_photo"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['principal_type_xid'] = principalTypeXid;
    data['principal_source_xid'] = principalSourceXid;
    data['user_name'] = userName;
    data['date_of_birth'] = dateOfBirth;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['address_line1'] = addressLine1;
    data['profile_photo'] = profilePhoto;
    return data;
  }
}
