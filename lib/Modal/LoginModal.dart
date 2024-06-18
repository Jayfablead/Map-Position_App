class LoginModal {
  bool? success;
  String? message;
  String? token;
  String? userId;
  String? paymentStatus;
  String? planEndDate;

  LoginModal(
      {this.success,
        this.message,
        this.token,
        this.userId,
        this.paymentStatus,
        this.planEndDate});

  LoginModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    userId = json['user_id'];
    paymentStatus = json['payment_status'];
    planEndDate = json['planEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['payment_status'] = this.paymentStatus;
    data['planEndDate'] = this.planEndDate;
    return data;
  }
}
