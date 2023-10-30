class FAQModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  FAQModel({this.status, this.success, this.data, this.message});

  FAQModel.fromJson(Map<String, dynamic> json) {
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
  String? question;
  String? answer;
  int? faqCategoryXid;
  String? faqCategory;

  Data(
      {this.id,
      this.question,
      this.answer,
      this.faqCategoryXid,
      this.faqCategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    faqCategoryXid = json['faq_category_xid'];
    faqCategory = json['faq_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['faq_category_xid'] = faqCategoryXid;
    data['faq_category'] = faqCategory;
    return data;
  }
}
