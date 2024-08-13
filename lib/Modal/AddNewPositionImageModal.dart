class AddNewPositionImageModal {
  bool? success;
  String? message;
  Data? data;

  AddNewPositionImageModal({this.success, this.message, this.data});

  AddNewPositionImageModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? postId;
  int? attachmentId;
  String? url;

  Data({this.postId, this.attachmentId, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    attachmentId = json['attachment_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['attachment_id'] = this.attachmentId;
    data['url'] = this.url;
    return data;
  }
}
