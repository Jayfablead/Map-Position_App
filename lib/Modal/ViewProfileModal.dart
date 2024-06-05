class ViewProfileModal {
  bool? success;
  String? message;
  UserDetails? userDetails;

  ViewProfileModal({this.success, this.message, this.userDetails});

  ViewProfileModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  int? iD;
  String? userLogin;
  String? userEmail;
  String? userRegistered;
  String? displayName;
  UserMeta? userMeta;
  String? profileImage;

  UserDetails(
      {this.iD,
        this.userLogin,
        this.userEmail,
        this.userRegistered,
        this.displayName,
        this.userMeta,
        this.profileImage});

  UserDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userLogin = json['user_login'];
    userEmail = json['user_email'];
    userRegistered = json['user_registered'];
    displayName = json['display_name'];
    userMeta = json['user_meta'] != null
        ? new UserMeta.fromJson(json['user_meta'])
        : null;
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_login'] = this.userLogin;
    data['user_email'] = this.userEmail;
    data['user_registered'] = this.userRegistered;
    data['display_name'] = this.displayName;
    if (this.userMeta != null) {
      data['user_meta'] = this.userMeta!.toJson();
    }
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class UserMeta {
  String? firstName;
  String? lastName;
  String? description;
  String? adminColor;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? pinterest;
  String? instagram;
  String? website;
  String? phone;
  String? skype;
  String? title;
  String? myLat;
  String? myLng;
  String? radiusAround;
  String? userboat;
  String? userboatlength;
  String? userboattype;

  UserMeta(
      {this.firstName,
        this.lastName,
        this.description,
        this.adminColor,
        this.facebook,
        this.twitter,
        this.linkedin,
        this.pinterest,
        this.instagram,
        this.website,
        this.phone,
        this.skype,
        this.title,
        this.myLat,
        this.myLng,
        this.radiusAround,
        this.userboat,
        this.userboatlength,
        this.userboattype});

  UserMeta.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    description = json['description'];
    adminColor = json['admin_color'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    pinterest = json['pinterest'];
    instagram = json['instagram'];
    website = json['website'];
    phone = json['phone'];
    skype = json['skype'];
    title = json['title'];
    myLat = json['my_lat'];
    myLng = json['my_lng'];
    radiusAround = json['radius_around'];
    userboat = json['userboat'];
    userboatlength = json['userboatlength'];
    userboattype = json['userboattype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['description'] = this.description;
    data['admin_color'] = this.adminColor;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['pinterest'] = this.pinterest;
    data['instagram'] = this.instagram;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['skype'] = this.skype;
    data['title'] = this.title;
    data['my_lat'] = this.myLat;
    data['my_lng'] = this.myLng;
    data['radius_around'] = this.radiusAround;
    data['userboat'] = this.userboat;
    data['userboatlength'] = this.userboatlength;
    data['userboattype'] = this.userboattype;
    return data;
  }
}
