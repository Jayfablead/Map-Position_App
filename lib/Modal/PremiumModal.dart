class PremiumModal {
  bool? success;
  Plan? plan;

  PremiumModal({this.success, this.plan});

  PremiumModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    return data;
  }
}

class Plan {
  String? id;
  String? subscriptionAmount;

  Plan({this.id, this.subscriptionAmount});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionAmount = json['subscription_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscription_amount'] = this.subscriptionAmount;
    return data;
  }
}
