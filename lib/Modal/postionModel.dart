// To parse this JSON data, do
//
//     final postionModel = postionModelFromJson(jsonString);

import 'dart:convert';

PostionModel postionModelFromJson(String str) => PostionModel.fromJson(json.decode(str));

String postionModelToJson(PostionModel data) => json.encode(data.toJson());

class PostionModel {
  List<Position> positions;

  PostionModel({
    required this.positions,
  });

  factory PostionModel.fromJson(Map<String, dynamic> json) => PostionModel(
    positions: List<Position>.from(json["positions"].map((x) => Position.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "positions": List<dynamic>.from(positions.map((x) => x.toJson())),
  };
}

class Position {
  String type;
  Properties properties;
  Geometry geometry;

  Position({
    required this.type,
    required this.properties,
    required this.geometry,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    type: json["type"],
    properties: Properties.fromJson(json["properties"]),
    geometry: Geometry.fromJson(json["geometry"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "properties": properties.toJson(),
    "geometry": geometry.toJson(),
  };
}

class Geometry {
  Type type;
  List<String> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: typeValues.map[json["type"]]!,
    coordinates: List<String>.from(json["coordinates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

enum Type {
  POINT
}

final typeValues = EnumValues({
  "Point": Type.POINT
});

class Properties {
  int postId;
  String? postImage;
  String title;
  String description;
  Icon icon;
  int catId;
  int imageIndex;
  String? imgUrl;
  int onlyAvg;
  TermName termName;
  bool isFavorite;

  Properties({
    required this.postId,
    required this.postImage,
    required this.title,
    required this.description,
    required this.icon,
    required this.catId,
    required this.imageIndex,
    required this.imgUrl,
    required this.onlyAvg,
    required this.termName,
    required this.isFavorite,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    postId: json["post_id"],
    postImage: json["post_image"],
    title: json["title"],
    description: json["description"],
    icon: iconValues.map[json["icon"]]!,
    catId: json["cat_id"],
    imageIndex: json["image_index"],
    imgUrl: json["imgURL"],
    onlyAvg: json["only_avg"],
    termName: termNameValues.map[json["term_name"]]!,
    isFavorite: json["is_favorite"],
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
    "post_image": postImage,
    "title": title,
    "description": description,
    "icon": iconValues.reverse[icon],
    "cat_id": catId,
    "image_index": imageIndex,
    "imgURL": imgUrl,
    "only_avg": onlyAvg,
    "term_name": termNameValues.reverse[termName],
    "is_favorite": isFavorite,
  };
}

enum Icon {
  AIRPORT_15,
  EMPTY,
  TOWN_HALL_15
}

final iconValues = EnumValues({
  "airport-15": Icon.AIRPORT_15,
  "": Icon.EMPTY,
  "town-hall-15": Icon.TOWN_HALL_15
});

enum TermName {
  ANCHORAGES,
  EMPTY,
  HARBORS,
  MARINAS,
  OTHER,
  WARNING
}

final termNameValues = EnumValues({
  "Anchorages": TermName.ANCHORAGES,
  "": TermName.EMPTY,
  "Harbors": TermName.HARBORS,
  "Marinas": TermName.MARINAS,
  "Other": TermName.OTHER,
  "Warning": TermName.WARNING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
