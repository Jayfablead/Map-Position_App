class MyMarinaViewModal {
  List<Positions>? positions;

  MyMarinaViewModal({this.positions});

  MyMarinaViewModal.fromJson(Map<String, dynamic> json) {
    if (json['positions'] != null) {
      positions = <Positions>[];
      json['positions'].forEach((v) {
        positions!.add(new Positions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.positions != null) {
      data['positions'] = this.positions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Positions {
  String? type;
  Properties? properties;
  Geometry? geometry;

  Positions({this.type, this.properties, this.geometry});

  Positions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    return data;
  }
}

class Properties {
  int? postId;
  String? postImage;
  String? title;
  String? description;
  String? icon;
  int? catId;
  int? imageIndex;
  String? imgURL;
  int? onlyAvg;

  Properties(
      {this.postId,
        this.postImage,
        this.title,
        this.description,
        this.icon,
        this.catId,
        this.imageIndex,
        this.imgURL,
        this.onlyAvg});

  Properties.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postImage = json['post_image'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    catId = json['cat_id'];
    imageIndex = json['image_index'];
    imgURL = json['imgURL'];
    onlyAvg = json['only_avg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['post_image'] = this.postImage;
    data['title'] = this.title;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['cat_id'] = this.catId;
    data['image_index'] = this.imageIndex;
    data['imgURL'] = this.imgURL;
    data['only_avg'] = this.onlyAvg;
    return data;
  }
}

class Geometry {
  String? type;
  List<String>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
