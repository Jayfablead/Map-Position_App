class UserAlaramModal {
  bool? success;
  List<Alarms>? alarms;

  UserAlaramModal({this.success, this.alarms});

  UserAlaramModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['alarms'] != null) {
      alarms = <Alarms>[];
      json['alarms'].forEach((v) {
        alarms!.add(new Alarms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.alarms != null) {
      data['alarms'] = this.alarms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alarms {
  String? id;
  String? location;
  String? lattiude;
  String? longitude;
  String? radius;
  String? category;
  String? userId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? termId;
  String? name;
  String? slug;
  String? termGroup;

  Alarms(
      {this.id,
        this.location,
        this.lattiude,
        this.longitude,
        this.radius,
        this.category,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.termId,
        this.name,
        this.slug,
        this.termGroup});

  Alarms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    lattiude = json['lattiude'];
    longitude = json['longitude'];
    radius = json['radius'];
    category = json['category'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['lattiude'] = this.lattiude;
    data['longitude'] = this.longitude;
    data['radius'] = this.radius;
    data['category'] = this.category;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    return data;
  }
}
