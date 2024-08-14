class AddNewPositionImageModal {
  bool? success;
  String? message;
  List<Data>? data;

  AddNewPositionImageModal({this.success, this.message, this.data});

  AddNewPositionImageModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? attachmentId;
  String? url;

  Data({this.attachmentId, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    attachmentId = json['attachment_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachment_id'] = this.attachmentId;
    data['url'] = this.url;
    return data;
  }
}
