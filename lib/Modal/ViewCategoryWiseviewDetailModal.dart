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
  String? authorId;
  String? postCategory;
  int? id;
  String? title;
  String? content;
  String? latitude;
  String? latitudeDms;
  String? longitude;
  String? longitudeDms;
  String? thumbnail;
  List<String>? thumbnails;
  MetaFields? metaFields;

  Data(
      {this.authorId,
        this.postCategory,
        this.id,
        this.title,
        this.content,
        this.latitude,
        this.latitudeDms,
        this.longitude,
        this.longitudeDms,
        this.thumbnail,
        this.thumbnails,
        this.metaFields});

  Data.fromJson(Map<String, dynamic> json) {
    authorId = json['author_id'];
    postCategory = json['post_category'];
    id = json['id'];
    title = json['title'];
    content = json['content'];
    latitude = json['latitude'];
    latitudeDms = json['latitude_dms'];
    longitude = json['longitude'];
    longitudeDms = json['longitude_dms'];
    thumbnail = json['thumbnail'];
    thumbnails = json['thumbnails'].cast<String>();
    metaFields = json['meta_fields'] != null
        ? new MetaFields.fromJson(json['meta_fields'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_id'] = this.authorId;
    data['post_category'] = this.postCategory;
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['latitude'] = this.latitude;
    data['latitude_dms'] = this.latitudeDms;
    data['longitude'] = this.longitude;
    data['longitude_dms'] = this.longitudeDms;
    data['thumbnail'] = this.thumbnail;
    data['thumbnails'] = this.thumbnails;
    if (this.metaFields != null) {
      data['meta_fields'] = this.metaFields!.toJson();
    }
    return data;
  }
}

class MetaFields {
  bool? originalAuthor;
  String? originalAuthorIcon;
  bool? n1;
  String? n1Icon;
  bool? n2;
  String? n2Icon;
  bool? n3;
  String? n3Icon;
  bool? ne1;
  String? ne1Icon;
  bool? ne2;
  String? ne2Icon;
  bool? ne3;
  String? ne3Icon;
  bool? e1;
  String? e1Icon;
  bool? e2;
  String? e2Icon;
  bool? e3;
  String? e3Icon;
  bool? se1;
  String? se1Icon;
  bool? se2;
  String? se2Icon;
  bool? se3;
  String? se3Icon;
  bool? s1;
  String? s1Icon;
  bool? s2;
  String? s2Icon;
  bool? s3;
  String? s3Icon;
  bool? sw1;
  String? sw1Icon;
  bool? sw2;
  String? sw2Icon;
  bool? sw3;
  String? sw3Icon;
  bool? w1;
  String? w1Icon;
  bool? w2;
  String? w2Icon;
  bool? w3;
  String? w3Icon;
  bool? nw1;
  String? nw1Icon;
  bool? nw2;
  String? nw2Icon;
  bool? nw3;
  String? nw3Icon;
  bool? ownAnchor;
  String? ownAnchorIcon;
  bool? buoys;
  String? buoysIcon;
  bool? mountainWedges;
  String? mountainWedgesIcon;
  bool? ownLines;
  String? ownLinesIcon;
  bool? sand;
  String? sandIcon;
  bool? mud;
  String? mudIcon;
  bool? clay;
  String? clayIcon;
  bool? coral;
  String? coralIcon;
  bool? rocks;
  String? rocksIcon;
  bool? groceries;
  String? groceriesIcon;
  bool? pharmacy;
  String? pharmacyIcon;
  bool? water;
  String? waterIcon;
  bool? restaurant;
  String? restaurantIcon;
  bool? alcohol;
  String? alcoholIcon;
  bool? beach;
  String? beachIcon;
  bool? pontoon;
  String? pontoonIcon;
  bool? shop;
  String? shopIcon;
  bool? propertyAddress;
  String? propertyAddressIcon;
  Null? propertyCity;
  String? propertyCityIcon;
  Null? propertyArea;
  String? propertyAreaIcon;
  Null? propertyZip;
  String? propertyZipIcon;
  Null? propertyCountry;
  String? propertyCountryIcon;
  bool? propertyLatitude;
  String? propertyLatitudeIcon;
  bool? propertyLongitude;
  String? propertyLongitudeIcon;
  Null? textSlips;
  String? textSlipsIcon;
  Null? textMinimumapproachdepth;
  String? textMinimumapproachdepthIcon;
  Null? textMeanlowwaterdockdepth;
  String? textMeanlowwaterdockdepthIcon;
  Null? textMinimumchanneldepth;
  String? textMinimumchanneldepthIcon;
  Null? textMeanhighwaterclearance;
  String? textMeanhighwaterclearanceIcon;
  String? textFueldock;
  String? textFueldockIcon;
  String? textGas;
  String? textGasIcon;
  String? textTransientstorage;
  String? textTransientstorageIcon;
  bool? textLongtermstorage;
  String? textLongtermstorageIcon;
  String? textMaxvesselloa;
  String? textMaxvesselloaIcon;
  Null? textMaxsliplength;
  String? textMaxsliplengthIcon;
  Null? textMaxslipwidth;
  String? textMaxslipwidthIcon;
  bool? bThumbnailId;
  String? sThumbnailIdIcon;
  bool? wpestateTotalViews;
  String? wpestateTotalViewsIcon;
  bool? wpestateDetailedViews;
  String? wpestateDetailedViewsIcon;
  bool? kind;
  String? kindIcon;
  bool? navPropertyLatitude;
  String? navPropertyLatitudeIcon;
  bool? navPropertyLongitude;
  String? navPropertyLongitudeIcon;
  bool? timezone;
  String? timezoneIcon;
  bool? rating;
  String? ratingIcon;
  bool? hasBeach;
  String? hasBeachIcon;
  bool? hasShop;
  String? hasShopIcon;
  bool? likes;
  String? likesIcon;
  bool? comments;
  String? commentsIcon;
  bool? navlyUrl;
  String? navlyUrlIcon;
  bool? bEditLast;
  String? sEditLastIcon;
  bool? bWpOldDate;
  String? sWpOldDateIcon;
  bool? rsPageBgColor;
  String? rsPageBgColorIcon;
  bool? bEditLock;
  String? sEditLockIcon;
  bool? plan;
  String? planIcon;
  bool? hasPontoon;
  String? hasPontoonIcon;
  bool? maxDraft;
  String? maxDraftIcon;
  bool? multihullFriendly;
  String? multihullFriendlyIcon;
  bool? equipmentAvailability;
  String? equipmentAvailabilityIcon;
  bool? mooringTypes;
  String? mooringTypesIcon;
  bool? propertyPrice;
  String? propertyPriceIcon;
  bool? propertyLabel;
  String? propertyLabelIcon;
  bool? propertyLabelBefore;
  String? propertyLabelBeforeIcon;
  bool? propertySize;
  String? propertySizeIcon;
  bool? propertyLotSize;
  String? propertyLotSizeIcon;
  bool? propertyRooms;
  String? propertyRoomsIcon;
  bool? propertyBedrooms;
  String? propertyBedroomsIcon;
  bool? propertyBathrooms;
  String? propertyBathroomsIcon;
  bool? ownerNotes;
  String? ownerNotesIcon;
  bool? propertyStatus;
  String? propertyStatusIcon;
  bool? propFeatured;
  String? propFeaturedIcon;
  bool? propertyThemeSlider;
  String? propertyThemeSliderIcon;
  bool? imageToAttach;
  String? imageToAttachIcon;
  bool? embedVideoType;
  String? embedVideoTypeIcon;
  bool? embedVideoId;
  String? embedVideoIdIcon;
  bool? embedVirtualTour;
  String? embedVirtualTourIcon;
  bool? mls;
  String? mlsIcon;
  bool? pageCustomZoom;
  String? pageCustomZoomIcon;
  bool? propertyGoogleView;
  String? propertyGoogleViewIcon;
  bool? googleCameraAngle;
  String? googleCameraAngleIcon;
  bool? attic;
  String? atticIcon;
  bool? gasHeat;
  String? gasHeatIcon;
  bool? oceanView;
  String? oceanViewIcon;
  bool? wineCellar;
  String? wineCellarIcon;
  bool? basketballCourt;
  String? basketballCourtIcon;
  bool? gym;
  String? gymIcon;
  bool? pound;
  String? poundIcon;
  bool? fireplace;
  String? fireplaceIcon;
  bool? lakeView;
  String? lakeViewIcon;
  bool? pool;
  String? poolIcon;
  bool? backYard;
  String? backYardIcon;
  bool? frontYard;
  String? frontYardIcon;
  bool? fencedYard;
  String? fencedYardIcon;
  bool? sprinklers;
  String? sprinklersIcon;
  bool? washerAndDryer;
  String? washerAndDryerIcon;
  bool? deck;
  String? deckIcon;
  bool? balcony;
  String? balconyIcon;
  bool? laundry;
  String? laundryIcon;
  bool? concierge;
  String? conciergeIcon;
  bool? doorman;
  String? doormanIcon;
  bool? privateSpace;
  String? privateSpaceIcon;
  bool? storage;
  String? storageIcon;
  bool? recreation;
  String? recreationIcon;
  bool? roofDeck;
  String? roofDeckIcon;
  bool? propertyAgent;
  String? propertyAgentIcon;
  bool? propertyUser;
  String? propertyUserIcon;
  bool? useFloorPlans;
  String? useFloorPlansIcon;
  bool? propertyHasSubunits;
  String? propertyHasSubunitsIcon;
  bool? propertySubunitsListManual;
  String? propertySubunitsListManualIcon;
  bool? postShowTitle;
  String? postShowTitleIcon;
  bool? headerType;
  String? headerTypeIcon;
  bool? headerTransparent;
  String? headerTransparentIcon;
  bool? useFloatSearchFormLocalSet;
  String? useFloatSearchFormLocalSetIcon;
  bool? useFloatSearchFormLocal;
  String? useFloatSearchFormLocalIcon;
  bool? minHeight;
  String? minHeightIcon;
  bool? pageCustomImage;
  String? pageCustomImageIcon;
  bool? revSlider;
  String? revSliderIcon;
  bool? localPgprSliderType;
  String? localPgprSliderTypeIcon;
  bool? localPgprContentType;
  String? localPgprContentTypeIcon;
  bool? sidebarOption;
  String? sidebarOptionIcon;
  bool? sidebarSelect;
  String? sidebarSelectIcon;
  bool? planTitle;
  String? planTitleIcon;
  bool? planDescription;
  String? planDescriptionIcon;
  bool? planImageAttach;
  String? planImageAttachIcon;
  bool? planImage;
  String? planImageIcon;
  bool? planSize;
  String? planSizeIcon;
  bool? planRooms;
  String? planRoomsIcon;
  bool? planBath;
  String? planBathIcon;
  bool? planPrice;
  String? planPriceIcon;
  bool? advFilterSearchAction;
  String? advFilterSearchActionIcon;
  bool? advFilterSearchCategory;
  String? advFilterSearchCategoryIcon;
  bool? currentAdvFilterCity;
  String? currentAdvFilterCityIcon;
  bool? currentAdvFilterArea;
  String? currentAdvFilterAreaIcon;
  bool? hiddenAddress;
  String? hiddenAddressIcon;
  bool? hasHawser;
  String? hasHawserIcon;
  bool? bWpOldSlug;
  String? sWpOldSlugIcon;
  bool? propertyCounty;
  String? propertyCountyIcon;
  bool? propertySubunitsList;
  String? propertySubunitsListIcon;

  MetaFields(
      {this.originalAuthor,
        this.originalAuthorIcon,
        this.n1,
        this.n1Icon,
        this.n2,
        this.n2Icon,
        this.n3,
        this.n3Icon,
        this.ne1,
        this.ne1Icon,
        this.ne2,
        this.ne2Icon,
        this.ne3,
        this.ne3Icon,
        this.e1,
        this.e1Icon,
        this.e2,
        this.e2Icon,
        this.e3,
        this.e3Icon,
        this.se1,
        this.se1Icon,
        this.se2,
        this.se2Icon,
        this.se3,
        this.se3Icon,
        this.s1,
        this.s1Icon,
        this.s2,
        this.s2Icon,
        this.s3,
        this.s3Icon,
        this.sw1,
        this.sw1Icon,
        this.sw2,
        this.sw2Icon,
        this.sw3,
        this.sw3Icon,
        this.w1,
        this.w1Icon,
        this.w2,
        this.w2Icon,
        this.w3,
        this.w3Icon,
        this.nw1,
        this.nw1Icon,
        this.nw2,
        this.nw2Icon,
        this.nw3,
        this.nw3Icon,
        this.ownAnchor,
        this.ownAnchorIcon,
        this.buoys,
        this.buoysIcon,
        this.mountainWedges,
        this.mountainWedgesIcon,
        this.ownLines,
        this.ownLinesIcon,
        this.sand,
        this.sandIcon,
        this.mud,
        this.mudIcon,
        this.clay,
        this.clayIcon,
        this.coral,
        this.coralIcon,
        this.rocks,
        this.rocksIcon,
        this.groceries,
        this.groceriesIcon,
        this.pharmacy,
        this.pharmacyIcon,
        this.water,
        this.waterIcon,
        this.restaurant,
        this.restaurantIcon,
        this.alcohol,
        this.alcoholIcon,
        this.beach,
        this.beachIcon,
        this.pontoon,
        this.pontoonIcon,
        this.shop,
        this.shopIcon,
        this.propertyAddress,
        this.propertyAddressIcon,
        this.propertyCity,
        this.propertyCityIcon,
        this.propertyArea,
        this.propertyAreaIcon,
        this.propertyZip,
        this.propertyZipIcon,
        this.propertyCountry,
        this.propertyCountryIcon,
        this.propertyLatitude,
        this.propertyLatitudeIcon,
        this.propertyLongitude,
        this.propertyLongitudeIcon,
        this.textSlips,
        this.textSlipsIcon,
        this.textMinimumapproachdepth,
        this.textMinimumapproachdepthIcon,
        this.textMeanlowwaterdockdepth,
        this.textMeanlowwaterdockdepthIcon,
        this.textMinimumchanneldepth,
        this.textMinimumchanneldepthIcon,
        this.textMeanhighwaterclearance,
        this.textMeanhighwaterclearanceIcon,
        this.textFueldock,
        this.textFueldockIcon,
        this.textGas,
        this.textGasIcon,
        this.textTransientstorage,
        this.textTransientstorageIcon,
        this.textLongtermstorage,
        this.textLongtermstorageIcon,
        this.textMaxvesselloa,
        this.textMaxvesselloaIcon,
        this.textMaxsliplength,
        this.textMaxsliplengthIcon,
        this.textMaxslipwidth,
        this.textMaxslipwidthIcon,
        this.bThumbnailId,
        this.sThumbnailIdIcon,
        this.wpestateTotalViews,
        this.wpestateTotalViewsIcon,
        this.wpestateDetailedViews,
        this.wpestateDetailedViewsIcon,
        this.kind,
        this.kindIcon,
        this.navPropertyLatitude,
        this.navPropertyLatitudeIcon,
        this.navPropertyLongitude,
        this.navPropertyLongitudeIcon,
        this.timezone,
        this.timezoneIcon,
        this.rating,
        this.ratingIcon,
        this.hasBeach,
        this.hasBeachIcon,
        this.hasShop,
        this.hasShopIcon,
        this.likes,
        this.likesIcon,
        this.comments,
        this.commentsIcon,
        this.navlyUrl,
        this.navlyUrlIcon,
        this.bEditLast,
        this.sEditLastIcon,
        this.bWpOldDate,
        this.sWpOldDateIcon,
        this.rsPageBgColor,
        this.rsPageBgColorIcon,
        this.bEditLock,
        this.sEditLockIcon,
        this.plan,
        this.planIcon,
        this.hasPontoon,
        this.hasPontoonIcon,
        this.maxDraft,
        this.maxDraftIcon,
        this.multihullFriendly,
        this.multihullFriendlyIcon,
        this.equipmentAvailability,
        this.equipmentAvailabilityIcon,
        this.mooringTypes,
        this.mooringTypesIcon,
        this.propertyPrice,
        this.propertyPriceIcon,
        this.propertyLabel,
        this.propertyLabelIcon,
        this.propertyLabelBefore,
        this.propertyLabelBeforeIcon,
        this.propertySize,
        this.propertySizeIcon,
        this.propertyLotSize,
        this.propertyLotSizeIcon,
        this.propertyRooms,
        this.propertyRoomsIcon,
        this.propertyBedrooms,
        this.propertyBedroomsIcon,
        this.propertyBathrooms,
        this.propertyBathroomsIcon,
        this.ownerNotes,
        this.ownerNotesIcon,
        this.propertyStatus,
        this.propertyStatusIcon,
        this.propFeatured,
        this.propFeaturedIcon,
        this.propertyThemeSlider,
        this.propertyThemeSliderIcon,
        this.imageToAttach,
        this.imageToAttachIcon,
        this.embedVideoType,
        this.embedVideoTypeIcon,
        this.embedVideoId,
        this.embedVideoIdIcon,
        this.embedVirtualTour,
        this.embedVirtualTourIcon,
        this.mls,
        this.mlsIcon,
        this.pageCustomZoom,
        this.pageCustomZoomIcon,
        this.propertyGoogleView,
        this.propertyGoogleViewIcon,
        this.googleCameraAngle,
        this.googleCameraAngleIcon,
        this.attic,
        this.atticIcon,
        this.gasHeat,
        this.gasHeatIcon,
        this.oceanView,
        this.oceanViewIcon,
        this.wineCellar,
        this.wineCellarIcon,
        this.basketballCourt,
        this.basketballCourtIcon,
        this.gym,
        this.gymIcon,
        this.pound,
        this.poundIcon,
        this.fireplace,
        this.fireplaceIcon,
        this.lakeView,
        this.lakeViewIcon,
        this.pool,
        this.poolIcon,
        this.backYard,
        this.backYardIcon,
        this.frontYard,
        this.frontYardIcon,
        this.fencedYard,
        this.fencedYardIcon,
        this.sprinklers,
        this.sprinklersIcon,
        this.washerAndDryer,
        this.washerAndDryerIcon,
        this.deck,
        this.deckIcon,
        this.balcony,
        this.balconyIcon,
        this.laundry,
        this.laundryIcon,
        this.concierge,
        this.conciergeIcon,
        this.doorman,
        this.doormanIcon,
        this.privateSpace,
        this.privateSpaceIcon,
        this.storage,
        this.storageIcon,
        this.recreation,
        this.recreationIcon,
        this.roofDeck,
        this.roofDeckIcon,
        this.propertyAgent,
        this.propertyAgentIcon,
        this.propertyUser,
        this.propertyUserIcon,
        this.useFloorPlans,
        this.useFloorPlansIcon,
        this.propertyHasSubunits,
        this.propertyHasSubunitsIcon,
        this.propertySubunitsListManual,
        this.propertySubunitsListManualIcon,
        this.postShowTitle,
        this.postShowTitleIcon,
        this.headerType,
        this.headerTypeIcon,
        this.headerTransparent,
        this.headerTransparentIcon,
        this.useFloatSearchFormLocalSet,
        this.useFloatSearchFormLocalSetIcon,
        this.useFloatSearchFormLocal,
        this.useFloatSearchFormLocalIcon,
        this.minHeight,
        this.minHeightIcon,
        this.pageCustomImage,
        this.pageCustomImageIcon,
        this.revSlider,
        this.revSliderIcon,
        this.localPgprSliderType,
        this.localPgprSliderTypeIcon,
        this.localPgprContentType,
        this.localPgprContentTypeIcon,
        this.sidebarOption,
        this.sidebarOptionIcon,
        this.sidebarSelect,
        this.sidebarSelectIcon,
        this.planTitle,
        this.planTitleIcon,
        this.planDescription,
        this.planDescriptionIcon,
        this.planImageAttach,
        this.planImageAttachIcon,
        this.planImage,
        this.planImageIcon,
        this.planSize,
        this.planSizeIcon,
        this.planRooms,
        this.planRoomsIcon,
        this.planBath,
        this.planBathIcon,
        this.planPrice,
        this.planPriceIcon,
        this.advFilterSearchAction,
        this.advFilterSearchActionIcon,
        this.advFilterSearchCategory,
        this.advFilterSearchCategoryIcon,
        this.currentAdvFilterCity,
        this.currentAdvFilterCityIcon,
        this.currentAdvFilterArea,
        this.currentAdvFilterAreaIcon,
        this.hiddenAddress,
        this.hiddenAddressIcon,
        this.hasHawser,
        this.hasHawserIcon,
        this.bWpOldSlug,
        this.sWpOldSlugIcon,
        this.propertyCounty,
        this.propertyCountyIcon,
        this.propertySubunitsList,
        this.propertySubunitsListIcon});

  MetaFields.fromJson(Map<String, dynamic> json) {
    originalAuthor = json['original_author'];
    originalAuthorIcon = json['original_author_icon'];
    n1 = json['n1'];
    n1Icon = json['n1_icon'];
    n2 = json['n2'];
    n2Icon = json['n2_icon'];
    n3 = json['n3'];
    n3Icon = json['n3_icon'];
    ne1 = json['ne1'];
    ne1Icon = json['ne1_icon'];
    ne2 = json['ne2'];
    ne2Icon = json['ne2_icon'];
    ne3 = json['ne3'];
    ne3Icon = json['ne3_icon'];
    e1 = json['e1'];
    e1Icon = json['e1_icon'];
    e2 = json['e2'];
    e2Icon = json['e2_icon'];
    e3 = json['e3'];
    e3Icon = json['e3_icon'];
    se1 = json['se1'];
    se1Icon = json['se1_icon'];
    se2 = json['se2'];
    se2Icon = json['se2_icon'];
    se3 = json['se3'];
    se3Icon = json['se3_icon'];
    s1 = json['s1'];
    s1Icon = json['s1_icon'];
    s2 = json['s2'];
    s2Icon = json['s2_icon'];
    s3 = json['s3'];
    s3Icon = json['s3_icon'];
    sw1 = json['sw1'];
    sw1Icon = json['sw1_icon'];
    sw2 = json['sw2'];
    sw2Icon = json['sw2_icon'];
    sw3 = json['sw3'];
    sw3Icon = json['sw3_icon'];
    w1 = json['w1'];
    w1Icon = json['w1_icon'];
    w2 = json['w2'];
    w2Icon = json['w2_icon'];
    w3 = json['w3'];
    w3Icon = json['w3_icon'];
    nw1 = json['nw1'];
    nw1Icon = json['nw1_icon'];
    nw2 = json['nw2'];
    nw2Icon = json['nw2_icon'];
    nw3 = json['nw3'];
    nw3Icon = json['nw3_icon'];
    ownAnchor = json['own_anchor'];
    ownAnchorIcon = json['own_anchor_icon'];
    buoys = json['buoys'];
    buoysIcon = json['buoys_icon'];
    mountainWedges = json['mountain_wedges'];
    mountainWedgesIcon = json['mountain_wedges_icon'];
    ownLines = json['own_lines'];
    ownLinesIcon = json['own_lines_icon'];
    sand = json['sand'];
    sandIcon = json['sand_icon'];
    mud = json['mud'];
    mudIcon = json['mud_icon'];
    clay = json['clay'];
    clayIcon = json['clay_icon'];
    coral = json['coral'];
    coralIcon = json['coral_icon'];
    rocks = json['rocks'];
    rocksIcon = json['rocks_icon'];
    groceries = json['groceries'];
    groceriesIcon = json['groceries_icon'];
    pharmacy = json['pharmacy'];
    pharmacyIcon = json['pharmacy_icon'];
    water = json['water'];
    waterIcon = json['water_icon'];
    restaurant = json['restaurant'];
    restaurantIcon = json['restaurant_icon'];
    alcohol = json['alcohol'];
    alcoholIcon = json['alcohol_icon'];
    beach = json['beach'];
    beachIcon = json['beach_icon'];
    pontoon = json['pontoon'];
    pontoonIcon = json['pontoon_icon'];
    shop = json['shop'];
    shopIcon = json['shop_icon'];
    propertyAddress = json['property_address'];
    propertyAddressIcon = json['property_address_icon'];
    propertyCity = json['property_city'];
    propertyCityIcon = json['property_city_icon'];
    propertyArea = json['property_area'];
    propertyAreaIcon = json['property_area_icon'];
    propertyZip = json['property_zip'];
    propertyZipIcon = json['property_zip_icon'];
    propertyCountry = json['property_country'];
    propertyCountryIcon = json['property_country_icon'];
    propertyLatitude = json['property_latitude'];
    propertyLatitudeIcon = json['property_latitude_icon'];
    propertyLongitude = json['property_longitude'];
    propertyLongitudeIcon = json['property_longitude_icon'];
    textSlips = json['text_slips'];
    textSlipsIcon = json['text_slips_icon'];
    textMinimumapproachdepth = json['text_minimumapproachdepth'];
    textMinimumapproachdepthIcon = json['text_minimumapproachdepth_icon'];
    textMeanlowwaterdockdepth = json['text_meanlowwaterdockdepth'];
    textMeanlowwaterdockdepthIcon = json['text_meanlowwaterdockdepth_icon'];
    textMinimumchanneldepth = json['text_minimumchanneldepth'];
    textMinimumchanneldepthIcon = json['text_minimumchanneldepth_icon'];
    textMeanhighwaterclearance = json['text_meanhighwaterclearance'];
    textMeanhighwaterclearanceIcon = json['text_meanhighwaterclearance_icon'];
    textFueldock = json['text_fueldock'];
    textFueldockIcon = json['text_fueldock_icon'];
    textGas = json['text_gas'];
    textGasIcon = json['text_gas_icon'];
    textTransientstorage = json['text_transientstorage'];
    textTransientstorageIcon = json['text_transientstorage_icon'];
    textLongtermstorage = json['text_longtermstorage'];
    textLongtermstorageIcon = json['text_longtermstorage_icon'];
    textMaxvesselloa = json['text_maxvesselloa'];
    textMaxvesselloaIcon = json['text_maxvesselloa_icon'];
    textMaxsliplength = json['text_maxsliplength'];
    textMaxsliplengthIcon = json['text_maxsliplength_icon'];
    textMaxslipwidth = json['text_maxslipwidth'];
    textMaxslipwidthIcon = json['text_maxslipwidth_icon'];
    bThumbnailId = json['_thumbnail_id'];
    sThumbnailIdIcon = json['_thumbnail_id_icon'];
    wpestateTotalViews = json['wpestate_total_views'];
    wpestateTotalViewsIcon = json['wpestate_total_views_icon'];
    wpestateDetailedViews = json['wpestate_detailed_views'];
    wpestateDetailedViewsIcon = json['wpestate_detailed_views_icon'];
    kind = json['kind'];
    kindIcon = json['kind_icon'];
    navPropertyLatitude = json['nav_property_latitude'];
    navPropertyLatitudeIcon = json['nav_property_latitude_icon'];
    navPropertyLongitude = json['nav_property_longitude'];
    navPropertyLongitudeIcon = json['nav_property_longitude_icon'];
    timezone = json['timezone'];
    timezoneIcon = json['timezone_icon'];
    rating = json['rating'];
    ratingIcon = json['rating_icon'];
    hasBeach = json['hasBeach'];
    hasBeachIcon = json['hasBeach_icon'];
    hasShop = json['hasShop'];
    hasShopIcon = json['hasShop_icon'];
    likes = json['likes'];
    likesIcon = json['likes_icon'];
    comments = json['comments'];
    commentsIcon = json['comments_icon'];
    navlyUrl = json['navly_url'];
    navlyUrlIcon = json['navly_url_icon'];
    bEditLast = json['_edit_last'];
    sEditLastIcon = json['_edit_last_icon'];
    bWpOldDate = json['_wp_old_date'];
    sWpOldDateIcon = json['_wp_old_date_icon'];
    rsPageBgColor = json['rs_page_bg_color'];
    rsPageBgColorIcon = json['rs_page_bg_color_icon'];
    bEditLock = json['_edit_lock'];
    sEditLockIcon = json['_edit_lock_icon'];
    plan = json['plan'];
    planIcon = json['plan_icon'];
    hasPontoon = json['hasPontoon'];
    hasPontoonIcon = json['hasPontoon_icon'];
    maxDraft = json['maxDraft'];
    maxDraftIcon = json['maxDraft_icon'];
    multihullFriendly = json['multihullFriendly'];
    multihullFriendlyIcon = json['multihullFriendly_icon'];
    equipmentAvailability = json['equipmentAvailability'];
    equipmentAvailabilityIcon = json['equipmentAvailability_icon'];
    mooringTypes = json['mooringTypes'];
    mooringTypesIcon = json['mooringTypes_icon'];
    propertyPrice = json['property_price'];
    propertyPriceIcon = json['property_price_icon'];
    propertyLabel = json['property_label'];
    propertyLabelIcon = json['property_label_icon'];
    propertyLabelBefore = json['property_label_before'];
    propertyLabelBeforeIcon = json['property_label_before_icon'];
    propertySize = json['property_size'];
    propertySizeIcon = json['property_size_icon'];
    propertyLotSize = json['property_lot_size'];
    propertyLotSizeIcon = json['property_lot_size_icon'];
    propertyRooms = json['property_rooms'];
    propertyRoomsIcon = json['property_rooms_icon'];
    propertyBedrooms = json['property_bedrooms'];
    propertyBedroomsIcon = json['property_bedrooms_icon'];
    propertyBathrooms = json['property_bathrooms'];
    propertyBathroomsIcon = json['property_bathrooms_icon'];
    ownerNotes = json['owner_notes'];
    ownerNotesIcon = json['owner_notes_icon'];
    propertyStatus = json['property_status'];
    propertyStatusIcon = json['property_status_icon'];
    propFeatured = json['prop_featured'];
    propFeaturedIcon = json['prop_featured_icon'];
    propertyThemeSlider = json['property_theme_slider'];
    propertyThemeSliderIcon = json['property_theme_slider_icon'];
    imageToAttach = json['image_to_attach'];
    imageToAttachIcon = json['image_to_attach_icon'];
    embedVideoType = json['embed_video_type'];
    embedVideoTypeIcon = json['embed_video_type_icon'];
    embedVideoId = json['embed_video_id'];
    embedVideoIdIcon = json['embed_video_id_icon'];
    embedVirtualTour = json['embed_virtual_tour'];
    embedVirtualTourIcon = json['embed_virtual_tour_icon'];
    mls = json['mls'];
    mlsIcon = json['mls_icon'];
    pageCustomZoom = json['page_custom_zoom'];
    pageCustomZoomIcon = json['page_custom_zoom_icon'];
    propertyGoogleView = json['property_google_view'];
    propertyGoogleViewIcon = json['property_google_view_icon'];
    googleCameraAngle = json['google_camera_angle'];
    googleCameraAngleIcon = json['google_camera_angle_icon'];
    attic = json['attic'];
    atticIcon = json['attic_icon'];
    gasHeat = json['gas_heat'];
    gasHeatIcon = json['gas_heat_icon'];
    oceanView = json['ocean_view'];
    oceanViewIcon = json['ocean_view_icon'];
    wineCellar = json['wine_cellar'];
    wineCellarIcon = json['wine_cellar_icon'];
    basketballCourt = json['basketball_court'];
    basketballCourtIcon = json['basketball_court_icon'];
    gym = json['gym'];
    gymIcon = json['gym_icon'];
    pound = json['pound'];
    poundIcon = json['pound_icon'];
    fireplace = json['fireplace'];
    fireplaceIcon = json['fireplace_icon'];
    lakeView = json['lake_view'];
    lakeViewIcon = json['lake_view_icon'];
    pool = json['pool'];
    poolIcon = json['pool_icon'];
    backYard = json['back_yard'];
    backYardIcon = json['back_yard_icon'];
    frontYard = json['front_yard'];
    frontYardIcon = json['front_yard_icon'];
    fencedYard = json['fenced_yard'];
    fencedYardIcon = json['fenced_yard_icon'];
    sprinklers = json['sprinklers'];
    sprinklersIcon = json['sprinklers_icon'];
    washerAndDryer = json['washer_and_dryer'];
    washerAndDryerIcon = json['washer_and_dryer_icon'];
    deck = json['deck'];
    deckIcon = json['deck_icon'];
    balcony = json['balcony'];
    balconyIcon = json['balcony_icon'];
    laundry = json['laundry'];
    laundryIcon = json['laundry_icon'];
    concierge = json['concierge'];
    conciergeIcon = json['concierge_icon'];
    doorman = json['doorman'];
    doormanIcon = json['doorman_icon'];
    privateSpace = json['private_space'];
    privateSpaceIcon = json['private_space_icon'];
    storage = json['storage'];
    storageIcon = json['storage_icon'];
    recreation = json['recreation'];
    recreationIcon = json['recreation_icon'];
    roofDeck = json['roof_deck'];
    roofDeckIcon = json['roof_deck_icon'];
    propertyAgent = json['property_agent'];
    propertyAgentIcon = json['property_agent_icon'];
    propertyUser = json['property_user'];
    propertyUserIcon = json['property_user_icon'];
    useFloorPlans = json['use_floor_plans'];
    useFloorPlansIcon = json['use_floor_plans_icon'];
    propertyHasSubunits = json['property_has_subunits'];
    propertyHasSubunitsIcon = json['property_has_subunits_icon'];
    propertySubunitsListManual = json['property_subunits_list_manual'];
    propertySubunitsListManualIcon = json['property_subunits_list_manual_icon'];
    postShowTitle = json['post_show_title'];
    postShowTitleIcon = json['post_show_title_icon'];
    headerType = json['header_type'];
    headerTypeIcon = json['header_type_icon'];
    headerTransparent = json['header_transparent'];
    headerTransparentIcon = json['header_transparent_icon'];
    useFloatSearchFormLocalSet = json['use_float_search_form_local_set'];
    useFloatSearchFormLocalSetIcon =
    json['use_float_search_form_local_set_icon'];
    useFloatSearchFormLocal = json['use_float_search_form_local'];
    useFloatSearchFormLocalIcon = json['use_float_search_form_local_icon'];
    minHeight = json['min_height'];
    minHeightIcon = json['min_height_icon'];
    pageCustomImage = json['page_custom_image'];
    pageCustomImageIcon = json['page_custom_image_icon'];
    revSlider = json['rev_slider'];
    revSliderIcon = json['rev_slider_icon'];
    localPgprSliderType = json['local_pgpr_slider_type'];
    localPgprSliderTypeIcon = json['local_pgpr_slider_type_icon'];
    localPgprContentType = json['local_pgpr_content_type'];
    localPgprContentTypeIcon = json['local_pgpr_content_type_icon'];
    sidebarOption = json['sidebar_option'];
    sidebarOptionIcon = json['sidebar_option_icon'];
    sidebarSelect = json['sidebar_select'];
    sidebarSelectIcon = json['sidebar_select_icon'];
    planTitle = json['plan_title'];
    planTitleIcon = json['plan_title_icon'];
    planDescription = json['plan_description'];
    planDescriptionIcon = json['plan_description_icon'];
    planImageAttach = json['plan_image_attach'];
    planImageAttachIcon = json['plan_image_attach_icon'];
    planImage = json['plan_image'];
    planImageIcon = json['plan_image_icon'];
    planSize = json['plan_size'];
    planSizeIcon = json['plan_size_icon'];
    planRooms = json['plan_rooms'];
    planRoomsIcon = json['plan_rooms_icon'];
    planBath = json['plan_bath'];
    planBathIcon = json['plan_bath_icon'];
    planPrice = json['plan_price'];
    planPriceIcon = json['plan_price_icon'];
    advFilterSearchAction = json['adv_filter_search_action'];
    advFilterSearchActionIcon = json['adv_filter_search_action_icon'];
    advFilterSearchCategory = json['adv_filter_search_category'];
    advFilterSearchCategoryIcon = json['adv_filter_search_category_icon'];
    currentAdvFilterCity = json['current_adv_filter_city'];
    currentAdvFilterCityIcon = json['current_adv_filter_city_icon'];
    currentAdvFilterArea = json['current_adv_filter_area'];
    currentAdvFilterAreaIcon = json['current_adv_filter_area_icon'];
    hiddenAddress = json['hidden_address'];
    hiddenAddressIcon = json['hidden_address_icon'];
    hasHawser = json['hasHawser'];
    hasHawserIcon = json['hasHawser_icon'];
    bWpOldSlug = json['_wp_old_slug'];
    sWpOldSlugIcon = json['_wp_old_slug_icon'];
    propertyCounty = json['property_county'];
    propertyCountyIcon = json['property_county_icon'];
    propertySubunitsList = json['property_subunits_list'];
    propertySubunitsListIcon = json['property_subunits_list_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_author'] = this.originalAuthor;
    data['original_author_icon'] = this.originalAuthorIcon;
    data['n1'] = this.n1;
    data['n1_icon'] = this.n1Icon;
    data['n2'] = this.n2;
    data['n2_icon'] = this.n2Icon;
    data['n3'] = this.n3;
    data['n3_icon'] = this.n3Icon;
    data['ne1'] = this.ne1;
    data['ne1_icon'] = this.ne1Icon;
    data['ne2'] = this.ne2;
    data['ne2_icon'] = this.ne2Icon;
    data['ne3'] = this.ne3;
    data['ne3_icon'] = this.ne3Icon;
    data['e1'] = this.e1;
    data['e1_icon'] = this.e1Icon;
    data['e2'] = this.e2;
    data['e2_icon'] = this.e2Icon;
    data['e3'] = this.e3;
    data['e3_icon'] = this.e3Icon;
    data['se1'] = this.se1;
    data['se1_icon'] = this.se1Icon;
    data['se2'] = this.se2;
    data['se2_icon'] = this.se2Icon;
    data['se3'] = this.se3;
    data['se3_icon'] = this.se3Icon;
    data['s1'] = this.s1;
    data['s1_icon'] = this.s1Icon;
    data['s2'] = this.s2;
    data['s2_icon'] = this.s2Icon;
    data['s3'] = this.s3;
    data['s3_icon'] = this.s3Icon;
    data['sw1'] = this.sw1;
    data['sw1_icon'] = this.sw1Icon;
    data['sw2'] = this.sw2;
    data['sw2_icon'] = this.sw2Icon;
    data['sw3'] = this.sw3;
    data['sw3_icon'] = this.sw3Icon;
    data['w1'] = this.w1;
    data['w1_icon'] = this.w1Icon;
    data['w2'] = this.w2;
    data['w2_icon'] = this.w2Icon;
    data['w3'] = this.w3;
    data['w3_icon'] = this.w3Icon;
    data['nw1'] = this.nw1;
    data['nw1_icon'] = this.nw1Icon;
    data['nw2'] = this.nw2;
    data['nw2_icon'] = this.nw2Icon;
    data['nw3'] = this.nw3;
    data['nw3_icon'] = this.nw3Icon;
    data['own_anchor'] = this.ownAnchor;
    data['own_anchor_icon'] = this.ownAnchorIcon;
    data['buoys'] = this.buoys;
    data['buoys_icon'] = this.buoysIcon;
    data['mountain_wedges'] = this.mountainWedges;
    data['mountain_wedges_icon'] = this.mountainWedgesIcon;
    data['own_lines'] = this.ownLines;
    data['own_lines_icon'] = this.ownLinesIcon;
    data['sand'] = this.sand;
    data['sand_icon'] = this.sandIcon;
    data['mud'] = this.mud;
    data['mud_icon'] = this.mudIcon;
    data['clay'] = this.clay;
    data['clay_icon'] = this.clayIcon;
    data['coral'] = this.coral;
    data['coral_icon'] = this.coralIcon;
    data['rocks'] = this.rocks;
    data['rocks_icon'] = this.rocksIcon;
    data['groceries'] = this.groceries;
    data['groceries_icon'] = this.groceriesIcon;
    data['pharmacy'] = this.pharmacy;
    data['pharmacy_icon'] = this.pharmacyIcon;
    data['water'] = this.water;
    data['water_icon'] = this.waterIcon;
    data['restaurant'] = this.restaurant;
    data['restaurant_icon'] = this.restaurantIcon;
    data['alcohol'] = this.alcohol;
    data['alcohol_icon'] = this.alcoholIcon;
    data['beach'] = this.beach;
    data['beach_icon'] = this.beachIcon;
    data['pontoon'] = this.pontoon;
    data['pontoon_icon'] = this.pontoonIcon;
    data['shop'] = this.shop;
    data['shop_icon'] = this.shopIcon;
    data['property_address'] = this.propertyAddress;
    data['property_address_icon'] = this.propertyAddressIcon;
    data['property_city'] = this.propertyCity;
    data['property_city_icon'] = this.propertyCityIcon;
    data['property_area'] = this.propertyArea;
    data['property_area_icon'] = this.propertyAreaIcon;
    data['property_zip'] = this.propertyZip;
    data['property_zip_icon'] = this.propertyZipIcon;
    data['property_country'] = this.propertyCountry;
    data['property_country_icon'] = this.propertyCountryIcon;
    data['property_latitude'] = this.propertyLatitude;
    data['property_latitude_icon'] = this.propertyLatitudeIcon;
    data['property_longitude'] = this.propertyLongitude;
    data['property_longitude_icon'] = this.propertyLongitudeIcon;
    data['text_slips'] = this.textSlips;
    data['text_slips_icon'] = this.textSlipsIcon;
    data['text_minimumapproachdepth'] = this.textMinimumapproachdepth;
    data['text_minimumapproachdepth_icon'] = this.textMinimumapproachdepthIcon;
    data['text_meanlowwaterdockdepth'] = this.textMeanlowwaterdockdepth;
    data['text_meanlowwaterdockdepth_icon'] =
        this.textMeanlowwaterdockdepthIcon;
    data['text_minimumchanneldepth'] = this.textMinimumchanneldepth;
    data['text_minimumchanneldepth_icon'] = this.textMinimumchanneldepthIcon;
    data['text_meanhighwaterclearance'] = this.textMeanhighwaterclearance;
    data['text_meanhighwaterclearance_icon'] =
        this.textMeanhighwaterclearanceIcon;
    data['text_fueldock'] = this.textFueldock;
    data['text_fueldock_icon'] = this.textFueldockIcon;
    data['text_gas'] = this.textGas;
    data['text_gas_icon'] = this.textGasIcon;
    data['text_transientstorage'] = this.textTransientstorage;
    data['text_transientstorage_icon'] = this.textTransientstorageIcon;
    data['text_longtermstorage'] = this.textLongtermstorage;
    data['text_longtermstorage_icon'] = this.textLongtermstorageIcon;
    data['text_maxvesselloa'] = this.textMaxvesselloa;
    data['text_maxvesselloa_icon'] = this.textMaxvesselloaIcon;
    data['text_maxsliplength'] = this.textMaxsliplength;
    data['text_maxsliplength_icon'] = this.textMaxsliplengthIcon;
    data['text_maxslipwidth'] = this.textMaxslipwidth;
    data['text_maxslipwidth_icon'] = this.textMaxslipwidthIcon;
    data['_thumbnail_id'] = this.bThumbnailId;
    data['_thumbnail_id_icon'] = this.sThumbnailIdIcon;
    data['wpestate_total_views'] = this.wpestateTotalViews;
    data['wpestate_total_views_icon'] = this.wpestateTotalViewsIcon;
    data['wpestate_detailed_views'] = this.wpestateDetailedViews;
    data['wpestate_detailed_views_icon'] = this.wpestateDetailedViewsIcon;
    data['kind'] = this.kind;
    data['kind_icon'] = this.kindIcon;
    data['nav_property_latitude'] = this.navPropertyLatitude;
    data['nav_property_latitude_icon'] = this.navPropertyLatitudeIcon;
    data['nav_property_longitude'] = this.navPropertyLongitude;
    data['nav_property_longitude_icon'] = this.navPropertyLongitudeIcon;
    data['timezone'] = this.timezone;
    data['timezone_icon'] = this.timezoneIcon;
    data['rating'] = this.rating;
    data['rating_icon'] = this.ratingIcon;
    data['hasBeach'] = this.hasBeach;
    data['hasBeach_icon'] = this.hasBeachIcon;
    data['hasShop'] = this.hasShop;
    data['hasShop_icon'] = this.hasShopIcon;
    data['likes'] = this.likes;
    data['likes_icon'] = this.likesIcon;
    data['comments'] = this.comments;
    data['comments_icon'] = this.commentsIcon;
    data['navly_url'] = this.navlyUrl;
    data['navly_url_icon'] = this.navlyUrlIcon;
    data['_edit_last'] = this.bEditLast;
    data['_edit_last_icon'] = this.sEditLastIcon;
    data['_wp_old_date'] = this.bWpOldDate;
    data['_wp_old_date_icon'] = this.sWpOldDateIcon;
    data['rs_page_bg_color'] = this.rsPageBgColor;
    data['rs_page_bg_color_icon'] = this.rsPageBgColorIcon;
    data['_edit_lock'] = this.bEditLock;
    data['_edit_lock_icon'] = this.sEditLockIcon;
    data['plan'] = this.plan;
    data['plan_icon'] = this.planIcon;
    data['hasPontoon'] = this.hasPontoon;
    data['hasPontoon_icon'] = this.hasPontoonIcon;
    data['maxDraft'] = this.maxDraft;
    data['maxDraft_icon'] = this.maxDraftIcon;
    data['multihullFriendly'] = this.multihullFriendly;
    data['multihullFriendly_icon'] = this.multihullFriendlyIcon;
    data['equipmentAvailability'] = this.equipmentAvailability;
    data['equipmentAvailability_icon'] = this.equipmentAvailabilityIcon;
    data['mooringTypes'] = this.mooringTypes;
    data['mooringTypes_icon'] = this.mooringTypesIcon;
    data['property_price'] = this.propertyPrice;
    data['property_price_icon'] = this.propertyPriceIcon;
    data['property_label'] = this.propertyLabel;
    data['property_label_icon'] = this.propertyLabelIcon;
    data['property_label_before'] = this.propertyLabelBefore;
    data['property_label_before_icon'] = this.propertyLabelBeforeIcon;
    data['property_size'] = this.propertySize;
    data['property_size_icon'] = this.propertySizeIcon;
    data['property_lot_size'] = this.propertyLotSize;
    data['property_lot_size_icon'] = this.propertyLotSizeIcon;
    data['property_rooms'] = this.propertyRooms;
    data['property_rooms_icon'] = this.propertyRoomsIcon;
    data['property_bedrooms'] = this.propertyBedrooms;
    data['property_bedrooms_icon'] = this.propertyBedroomsIcon;
    data['property_bathrooms'] = this.propertyBathrooms;
    data['property_bathrooms_icon'] = this.propertyBathroomsIcon;
    data['owner_notes'] = this.ownerNotes;
    data['owner_notes_icon'] = this.ownerNotesIcon;
    data['property_status'] = this.propertyStatus;
    data['property_status_icon'] = this.propertyStatusIcon;
    data['prop_featured'] = this.propFeatured;
    data['prop_featured_icon'] = this.propFeaturedIcon;
    data['property_theme_slider'] = this.propertyThemeSlider;
    data['property_theme_slider_icon'] = this.propertyThemeSliderIcon;
    data['image_to_attach'] = this.imageToAttach;
    data['image_to_attach_icon'] = this.imageToAttachIcon;
    data['embed_video_type'] = this.embedVideoType;
    data['embed_video_type_icon'] = this.embedVideoTypeIcon;
    data['embed_video_id'] = this.embedVideoId;
    data['embed_video_id_icon'] = this.embedVideoIdIcon;
    data['embed_virtual_tour'] = this.embedVirtualTour;
    data['embed_virtual_tour_icon'] = this.embedVirtualTourIcon;
    data['mls'] = this.mls;
    data['mls_icon'] = this.mlsIcon;
    data['page_custom_zoom'] = this.pageCustomZoom;
    data['page_custom_zoom_icon'] = this.pageCustomZoomIcon;
    data['property_google_view'] = this.propertyGoogleView;
    data['property_google_view_icon'] = this.propertyGoogleViewIcon;
    data['google_camera_angle'] = this.googleCameraAngle;
    data['google_camera_angle_icon'] = this.googleCameraAngleIcon;
    data['attic'] = this.attic;
    data['attic_icon'] = this.atticIcon;
    data['gas_heat'] = this.gasHeat;
    data['gas_heat_icon'] = this.gasHeatIcon;
    data['ocean_view'] = this.oceanView;
    data['ocean_view_icon'] = this.oceanViewIcon;
    data['wine_cellar'] = this.wineCellar;
    data['wine_cellar_icon'] = this.wineCellarIcon;
    data['basketball_court'] = this.basketballCourt;
    data['basketball_court_icon'] = this.basketballCourtIcon;
    data['gym'] = this.gym;
    data['gym_icon'] = this.gymIcon;
    data['pound'] = this.pound;
    data['pound_icon'] = this.poundIcon;
    data['fireplace'] = this.fireplace;
    data['fireplace_icon'] = this.fireplaceIcon;
    data['lake_view'] = this.lakeView;
    data['lake_view_icon'] = this.lakeViewIcon;
    data['pool'] = this.pool;
    data['pool_icon'] = this.poolIcon;
    data['back_yard'] = this.backYard;
    data['back_yard_icon'] = this.backYardIcon;
    data['front_yard'] = this.frontYard;
    data['front_yard_icon'] = this.frontYardIcon;
    data['fenced_yard'] = this.fencedYard;
    data['fenced_yard_icon'] = this.fencedYardIcon;
    data['sprinklers'] = this.sprinklers;
    data['sprinklers_icon'] = this.sprinklersIcon;
    data['washer_and_dryer'] = this.washerAndDryer;
    data['washer_and_dryer_icon'] = this.washerAndDryerIcon;
    data['deck'] = this.deck;
    data['deck_icon'] = this.deckIcon;
    data['balcony'] = this.balcony;
    data['balcony_icon'] = this.balconyIcon;
    data['laundry'] = this.laundry;
    data['laundry_icon'] = this.laundryIcon;
    data['concierge'] = this.concierge;
    data['concierge_icon'] = this.conciergeIcon;
    data['doorman'] = this.doorman;
    data['doorman_icon'] = this.doormanIcon;
    data['private_space'] = this.privateSpace;
    data['private_space_icon'] = this.privateSpaceIcon;
    data['storage'] = this.storage;
    data['storage_icon'] = this.storageIcon;
    data['recreation'] = this.recreation;
    data['recreation_icon'] = this.recreationIcon;
    data['roof_deck'] = this.roofDeck;
    data['roof_deck_icon'] = this.roofDeckIcon;
    data['property_agent'] = this.propertyAgent;
    data['property_agent_icon'] = this.propertyAgentIcon;
    data['property_user'] = this.propertyUser;
    data['property_user_icon'] = this.propertyUserIcon;
    data['use_floor_plans'] = this.useFloorPlans;
    data['use_floor_plans_icon'] = this.useFloorPlansIcon;
    data['property_has_subunits'] = this.propertyHasSubunits;
    data['property_has_subunits_icon'] = this.propertyHasSubunitsIcon;
    data['property_subunits_list_manual'] = this.propertySubunitsListManual;
    data['property_subunits_list_manual_icon'] =
        this.propertySubunitsListManualIcon;
    data['post_show_title'] = this.postShowTitle;
    data['post_show_title_icon'] = this.postShowTitleIcon;
    data['header_type'] = this.headerType;
    data['header_type_icon'] = this.headerTypeIcon;
    data['header_transparent'] = this.headerTransparent;
    data['header_transparent_icon'] = this.headerTransparentIcon;
    data['use_float_search_form_local_set'] = this.useFloatSearchFormLocalSet;
    data['use_float_search_form_local_set_icon'] =
        this.useFloatSearchFormLocalSetIcon;
    data['use_float_search_form_local'] = this.useFloatSearchFormLocal;
    data['use_float_search_form_local_icon'] = this.useFloatSearchFormLocalIcon;
    data['min_height'] = this.minHeight;
    data['min_height_icon'] = this.minHeightIcon;
    data['page_custom_image'] = this.pageCustomImage;
    data['page_custom_image_icon'] = this.pageCustomImageIcon;
    data['rev_slider'] = this.revSlider;
    data['rev_slider_icon'] = this.revSliderIcon;
    data['local_pgpr_slider_type'] = this.localPgprSliderType;
    data['local_pgpr_slider_type_icon'] = this.localPgprSliderTypeIcon;
    data['local_pgpr_content_type'] = this.localPgprContentType;
    data['local_pgpr_content_type_icon'] = this.localPgprContentTypeIcon;
    data['sidebar_option'] = this.sidebarOption;
    data['sidebar_option_icon'] = this.sidebarOptionIcon;
    data['sidebar_select'] = this.sidebarSelect;
    data['sidebar_select_icon'] = this.sidebarSelectIcon;
    data['plan_title'] = this.planTitle;
    data['plan_title_icon'] = this.planTitleIcon;
    data['plan_description'] = this.planDescription;
    data['plan_description_icon'] = this.planDescriptionIcon;
    data['plan_image_attach'] = this.planImageAttach;
    data['plan_image_attach_icon'] = this.planImageAttachIcon;
    data['plan_image'] = this.planImage;
    data['plan_image_icon'] = this.planImageIcon;
    data['plan_size'] = this.planSize;
    data['plan_size_icon'] = this.planSizeIcon;
    data['plan_rooms'] = this.planRooms;
    data['plan_rooms_icon'] = this.planRoomsIcon;
    data['plan_bath'] = this.planBath;
    data['plan_bath_icon'] = this.planBathIcon;
    data['plan_price'] = this.planPrice;
    data['plan_price_icon'] = this.planPriceIcon;
    data['adv_filter_search_action'] = this.advFilterSearchAction;
    data['adv_filter_search_action_icon'] = this.advFilterSearchActionIcon;
    data['adv_filter_search_category'] = this.advFilterSearchCategory;
    data['adv_filter_search_category_icon'] = this.advFilterSearchCategoryIcon;
    data['current_adv_filter_city'] = this.currentAdvFilterCity;
    data['current_adv_filter_city_icon'] = this.currentAdvFilterCityIcon;
    data['current_adv_filter_area'] = this.currentAdvFilterArea;
    data['current_adv_filter_area_icon'] = this.currentAdvFilterAreaIcon;
    data['hidden_address'] = this.hiddenAddress;
    data['hidden_address_icon'] = this.hiddenAddressIcon;
    data['hasHawser'] = this.hasHawser;
    data['hasHawser_icon'] = this.hasHawserIcon;
    data['_wp_old_slug'] = this.bWpOldSlug;
    data['_wp_old_slug_icon'] = this.sWpOldSlugIcon;
    data['property_county'] = this.propertyCounty;
    data['property_county_icon'] = this.propertyCountyIcon;
    data['property_subunits_list'] = this.propertySubunitsList;
    data['property_subunits_list_icon'] = this.propertySubunitsListIcon;
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
