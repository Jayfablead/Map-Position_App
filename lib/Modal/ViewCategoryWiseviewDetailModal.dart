class ViewCategoryWiseviewDetailModal {
  bool? success;
  String? message;
  Data? data;
  int? averageRating;
  List<NearbyPosts>? nearbyPosts;
  List<Reviews>? reviews;

  ViewCategoryWiseviewDetailModal(
      {this.success,
        this.message,
        this.data,
        this.averageRating,
        this.nearbyPosts,
        this.reviews});

  ViewCategoryWiseviewDetailModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    averageRating = json['average_rating'];
    if (json['nearby_posts'] != null) {
      nearbyPosts = <NearbyPosts>[];
      json['nearby_posts'].forEach((v) {
        nearbyPosts!.add(new NearbyPosts.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['average_rating'] = this.averageRating;
    if (this.nearbyPosts != null) {
      data['nearby_posts'] = this.nearbyPosts!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? postCategory;
  int? id;
  String? title;
  String? content;
  String? latitude;
  String? longitude;
  String? thumbnail;
  MetaFields? metaFields;

  Data(
      {this.postCategory,
        this.id,
        this.title,
        this.content,
        this.latitude,
        this.longitude,
        this.thumbnail,
        this.metaFields});

  Data.fromJson(Map<String, dynamic> json) {
    postCategory = json['post_category'];
    id = json['id'];
    title = json['title'];
    content = json['content'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    thumbnail = json['thumbnail'];

    metaFields = json['meta_fields'] != null
        ? new MetaFields.fromJson(json['meta_fields'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_category'] = this.postCategory;
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['thumbnail'] = this.thumbnail;
    if (this.metaFields != null) {
      data['meta_fields'] = this.metaFields!.toJson();
    }
    return data;
  }
}

class MetaFields {
  List<String>? originalAuthor;
  List<String>? propertyAddress;
  List<String>? propertyCity;
  List<String>? propertyArea;
  List<String>? propertyZip;
  List<String>? propertyCountry;
  List<String>? propertyLatitude;
  List<String>? propertyLongitude;
  List<String>? textSlips;
  List<String>? textMinimumapproachdepth;
  List<String>? textMeanlowwaterdockdepth;
  List<String>? textMinimumchanneldepth;
  List<String>? textMeanhighwaterclearance;
  List<String>? textFueldock;
  List<String>? textGas;
  List<String>? textTransientstorage;
  List<String>? textLongtermstorage;
  List<String>? textMaxvesselloa;
  List<String>? textMaxsliplength;
  List<String>? textMaxslipwidth;
  List<String>? n1;
  List<String>? n2;
  List<String>? n3;
  List<String>? ne1;
  List<String>? ne2;
  List<String>? ne3;
  List<String>? e1;
  List<String>? e2;
  List<String>? e3;
  List<String>? se1;
  List<String>? se2;
  List<String>? se3;
  List<String>? s1;
  List<String>? s2;
  List<String>? s3;
  List<String>? sw1;
  List<String>? sw2;
  List<String>? sw3;
  List<String>? w1;
  List<String>? w2;
  List<String>? w3;
  List<String>? nw1;
  List<String>? nw2;
  List<String>? nw3;
  List<String>? ownAnchor;
  List<String>? buoys;
  List<String>? mountainWedges;
  List<String>? ownLines;
  List<String>? sand;
  List<String>? mud;
  List<String>? clay;
  List<String>? coral;
  List<String>? rocks;
  List<String>? groceries;
  List<String>? pharmacy;
  List<String>? water;
  List<String>? restaurant;
  List<String>? alcohol;
  List<String>? lThumbnailId;
  List<String>? wpestateTotalViews;
  List<String>? wpestateDetailedViews;

  MetaFields(
      {this.originalAuthor,
        this.propertyAddress,
        this.propertyCity,
        this.propertyArea,
        this.propertyZip,
        this.propertyCountry,
        this.propertyLatitude,
        this.propertyLongitude,
        this.textSlips,
        this.textMinimumapproachdepth,
        this.textMeanlowwaterdockdepth,
        this.textMinimumchanneldepth,
        this.textMeanhighwaterclearance,
        this.textFueldock,
        this.textGas,
        this.textTransientstorage,
        this.textLongtermstorage,
        this.textMaxvesselloa,
        this.textMaxsliplength,
        this.textMaxslipwidth,
        this.n1,
        this.n2,
        this.n3,
        this.ne1,
        this.ne2,
        this.ne3,
        this.e1,
        this.e2,
        this.e3,
        this.se1,
        this.se2,
        this.se3,
        this.s1,
        this.s2,
        this.s3,
        this.sw1,
        this.sw2,
        this.sw3,
        this.w1,
        this.w2,
        this.w3,
        this.nw1,
        this.nw2,
        this.nw3,
        this.ownAnchor,
        this.buoys,
        this.mountainWedges,
        this.ownLines,
        this.sand,
        this.mud,
        this.clay,
        this.coral,
        this.rocks,
        this.groceries,
        this.pharmacy,
        this.water,
        this.restaurant,
        this.alcohol,
        this.lThumbnailId,
        this.wpestateTotalViews,
        this.wpestateDetailedViews});

  MetaFields.fromJson(Map<String, dynamic> json) {
    originalAuthor = json['original_author'].cast<String>();
    propertyAddress = json['property_address'].cast<String>();
    propertyCity = json['property_city'].cast<String>();
    propertyArea = json['property_area'].cast<String>();
    propertyZip = json['property_zip'].cast<String>();
    propertyCountry = json['property_country'].cast<String>();
    propertyLatitude = json['property_latitude'].cast<String>();
    propertyLongitude = json['property_longitude'].cast<String>();
    textSlips = json['text_slips'].cast<String>();
    textMinimumapproachdepth = json['text_minimumapproachdepth'].cast<String>();
    textMeanlowwaterdockdepth =
        json['text_meanlowwaterdockdepth'].cast<String>();
    textMinimumchanneldepth = json['text_minimumchanneldepth'].cast<String>();
    textMeanhighwaterclearance =
        json['text_meanhighwaterclearance'].cast<String>();
    textFueldock = json['text_fueldock'].cast<String>();
    textGas = json['text_gas'].cast<String>();
    textTransientstorage = json['text_transientstorage'].cast<String>();
    textLongtermstorage = json['text_longtermstorage'].cast<String>();
    textMaxvesselloa = json['text_maxvesselloa'].cast<String>();
    textMaxsliplength = json['text_maxsliplength'].cast<String>();
    textMaxslipwidth = json['text_maxslipwidth'].cast<String>();
    n1 = json['n1'].cast<String>();
    n2 = json['n2'].cast<String>();
    n3 = json['n3'].cast<String>();
    ne1 = json['ne1'].cast<String>();
    ne2 = json['ne2'].cast<String>();
    ne3 = json['ne3'].cast<String>();
    e1 = json['e1'].cast<String>();
    e2 = json['e2'].cast<String>();
    e3 = json['e3'].cast<String>();
    se1 = json['se1'].cast<String>();
    se2 = json['se2'].cast<String>();
    se3 = json['se3'].cast<String>();
    s1 = json['s1'].cast<String>();
    s2 = json['s2'].cast<String>();
    s3 = json['s3'].cast<String>();
    sw1 = json['sw1'].cast<String>();
    sw2 = json['sw2'].cast<String>();
    sw3 = json['sw3'].cast<String>();
    w1 = json['w1'].cast<String>();
    w2 = json['w2'].cast<String>();
    w3 = json['w3'].cast<String>();
    nw1 = json['nw1'].cast<String>();
    nw2 = json['nw2'].cast<String>();
    nw3 = json['nw3'].cast<String>();
    ownAnchor = json['own_anchor'].cast<String>();
    buoys = json['buoys'].cast<String>();
    mountainWedges = json['mountain_wedges'].cast<String>();
    ownLines = json['own_lines'].cast<String>();
    sand = json['sand'].cast<String>();
    mud = json['mud'].cast<String>();
    clay = json['clay'].cast<String>();
    coral = json['coral'].cast<String>();
    rocks = json['rocks'].cast<String>();
    groceries = json['groceries'].cast<String>();
    pharmacy = json['pharmacy'].cast<String>();
    water = json['water'].cast<String>();
    restaurant = json['restaurant'].cast<String>();
    alcohol = json['alcohol'].cast<String>();
    lThumbnailId = json['_thumbnail_id'].cast<String>();
    wpestateTotalViews = json['wpestate_total_views'].cast<String>();
    wpestateDetailedViews = json['wpestate_detailed_views'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_author'] = this.originalAuthor;
    data['property_address'] = this.propertyAddress;
    data['property_city'] = this.propertyCity;
    data['property_area'] = this.propertyArea;
    data['property_zip'] = this.propertyZip;
    data['property_country'] = this.propertyCountry;
    data['property_latitude'] = this.propertyLatitude;
    data['property_longitude'] = this.propertyLongitude;
    data['text_slips'] = this.textSlips;
    data['text_minimumapproachdepth'] = this.textMinimumapproachdepth;
    data['text_meanlowwaterdockdepth'] = this.textMeanlowwaterdockdepth;
    data['text_minimumchanneldepth'] = this.textMinimumchanneldepth;
    data['text_meanhighwaterclearance'] = this.textMeanhighwaterclearance;
    data['text_fueldock'] = this.textFueldock;
    data['text_gas'] = this.textGas;
    data['text_transientstorage'] = this.textTransientstorage;
    data['text_longtermstorage'] = this.textLongtermstorage;
    data['text_maxvesselloa'] = this.textMaxvesselloa;
    data['text_maxsliplength'] = this.textMaxsliplength;
    data['text_maxslipwidth'] = this.textMaxslipwidth;
    data['n1'] = this.n1;
    data['n2'] = this.n2;
    data['n3'] = this.n3;
    data['ne1'] = this.ne1;
    data['ne2'] = this.ne2;
    data['ne3'] = this.ne3;
    data['e1'] = this.e1;
    data['e2'] = this.e2;
    data['e3'] = this.e3;
    data['se1'] = this.se1;
    data['se2'] = this.se2;
    data['se3'] = this.se3;
    data['s1'] = this.s1;
    data['s2'] = this.s2;
    data['s3'] = this.s3;
    data['sw1'] = this.sw1;
    data['sw2'] = this.sw2;
    data['sw3'] = this.sw3;
    data['w1'] = this.w1;
    data['w2'] = this.w2;
    data['w3'] = this.w3;
    data['nw1'] = this.nw1;
    data['nw2'] = this.nw2;
    data['nw3'] = this.nw3;
    data['own_anchor'] = this.ownAnchor;
    data['buoys'] = this.buoys;
    data['mountain_wedges'] = this.mountainWedges;
    data['own_lines'] = this.ownLines;
    data['sand'] = this.sand;
    data['mud'] = this.mud;
    data['clay'] = this.clay;
    data['coral'] = this.coral;
    data['rocks'] = this.rocks;
    data['groceries'] = this.groceries;
    data['pharmacy'] = this.pharmacy;
    data['water'] = this.water;
    data['restaurant'] = this.restaurant;
    data['alcohol'] = this.alcohol;
    data['_thumbnail_id'] = this.lThumbnailId;
    data['wpestate_total_views'] = this.wpestateTotalViews;
    data['wpestate_detailed_views'] = this.wpestateDetailedViews;
    return data;
  }
}

class NearbyPosts {
  String? postCategory;
  int? id;
  String? title;
  String? latitude;
  String? longitude;
  String? thumbnail;
  bool? isFavorite;

  NearbyPosts(
      {this.postCategory,
        this.id,
        this.title,
        this.latitude,
        this.longitude,
        this.thumbnail,
        this.isFavorite});

  NearbyPosts.fromJson(Map<String, dynamic> json) {
    postCategory = json['post_category'];
    id = json['id'];
    title = json['title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    thumbnail = json['thumbnail'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_category'] = this.postCategory;
    data['id'] = this.id;
    data['title'] = this.title;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['thumbnail'] = this.thumbnail;
    data['is_favorite'] = this.isFavorite;
    return data;
  }
}

class Reviews {
  String? name;
  String? userImg;
  String? reviewerRating;
  ReviewSummary? reviewSummary;

  Reviews({this.name, this.userImg, this.reviewerRating, this.reviewSummary});

  Reviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userImg = json['userImg'];
    reviewerRating = json['reviewer_rating'];
    reviewSummary = json['review_summary'] != null
        ? new ReviewSummary.fromJson(json['review_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userImg'] = this.userImg;
    data['reviewer_rating'] = this.reviewerRating;
    if (this.reviewSummary != null) {
      data['review_summary'] = this.reviewSummary!.toJson();
    }
    return data;
  }
}

class ReviewSummary {
  String? xsReviwerRatting;
  String? xsReviwSummery;
  String? xsPostId;
  String? xsPostType;
  String? xsPostAuthor;
  String? reviewScoreStyle;
  String? reviewScoreLimit;
  String? reviewScoreInput;
  String? xsReviewsIp;

  ReviewSummary(
      {this.xsReviwerRatting,
        this.xsReviwSummery,
        this.xsPostId,
        this.xsPostType,
        this.xsPostAuthor,
        this.reviewScoreStyle,
        this.reviewScoreLimit,
        this.reviewScoreInput,
        this.xsReviewsIp});

  ReviewSummary.fromJson(Map<String, dynamic> json) {
    xsReviwerRatting = json['xs_reviwer_ratting'];
    xsReviwSummery = json['xs_reviw_summery'];
    xsPostId = json['xs_post_id'];
    xsPostType = json['xs_post_type'];
    xsPostAuthor = json['xs_post_author'];
    reviewScoreStyle = json['review_score_style'];
    reviewScoreLimit = json['review_score_limit'];
    reviewScoreInput = json['review_score_input'];
    xsReviewsIp = json['xs_reviews_ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xs_reviwer_ratting'] = this.xsReviwerRatting;
    data['xs_reviw_summery'] = this.xsReviwSummery;
    data['xs_post_id'] = this.xsPostId;
    data['xs_post_type'] = this.xsPostType;
    data['xs_post_author'] = this.xsPostAuthor;
    data['review_score_style'] = this.reviewScoreStyle;
    data['review_score_limit'] = this.reviewScoreLimit;
    data['review_score_input'] = this.reviewScoreInput;
    data['xs_reviews_ip'] = this.xsReviewsIp;
    return data;
  }
}
