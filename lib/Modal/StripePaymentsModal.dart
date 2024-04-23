class StripePaymentsModal {
  bool? success;
  String? message;
  Data? data;

  StripePaymentsModal({this.success, this.message, this.data});

  StripePaymentsModal.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? txnId;
  String? amount;
  String? paymentStripeId;
  String? planEndDate;
  String? paymentReceiptUrl;
  String? status;

  Data(
      {this.userId,
        this.txnId,
        this.amount,
        this.paymentStripeId,
        this.planEndDate,
        this.paymentReceiptUrl,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    txnId = json['txn_id'];
    amount = json['amount'];
    paymentStripeId = json['payment_stripe_id'];
    planEndDate = json['plan_end_date'];
    paymentReceiptUrl = json['payment_receipt_url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['txn_id'] = this.txnId;
    data['amount'] = this.amount;
    data['payment_stripe_id'] = this.paymentStripeId;
    data['plan_end_date'] = this.planEndDate;
    data['payment_receipt_url'] = this.paymentReceiptUrl;
    data['status'] = this.status;
    return data;
  }
}
