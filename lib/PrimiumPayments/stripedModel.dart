// To parse this JSON data, do
//
//     final stripedModel = stripedModelFromJson(jsonString);

import 'dart:convert';

StripedModel stripedModelFromJson(String str) => StripedModel.fromJson(json.decode(str));

String stripedModelToJson(StripedModel data) => json.encode(data.toJson());

class StripedModel {
  bool success;
  String message;
  Data data;

  StripedModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StripedModel.fromJson(Map<String, dynamic> json) => StripedModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String userId;
  String txnId;
  String amount;
  String paymentStripeId;
  String planEndDate;
  String paymentReceiptUrl;
  String status;

  Data({
    required this.userId,
    required this.txnId,
    required this.amount,
    required this.paymentStripeId,
    required this.planEndDate,
    required this.paymentReceiptUrl,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    txnId: json["txn_id"],
    amount: json["amount"],
    paymentStripeId: json["payment_stripe_id"],
    planEndDate: json["plan_end_date"],
    paymentReceiptUrl: json["payment_receipt_url"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "txn_id": txnId,
    "amount": amount,
    "payment_stripe_id": paymentStripeId,
    "plan_end_date": planEndDate,
    "payment_receipt_url": paymentReceiptUrl,
    "status": status,
  };
}
