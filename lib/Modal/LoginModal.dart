class LoginModal {
  bool? success;
  String? message;
  String? token;
  int? userId;

  LoginModal({this.success, this.message, this.token, this.userId});

  LoginModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    return data;
  }
}
