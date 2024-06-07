class CastomPositionMarinaModal {
  bool? success;
  String? message;
  Data? data;
  int? averageRating;
  List<NearbyPosts>? nearbyPosts;
  List<Reviews>? reviews;

  CastomPositionMarinaModal(
      {this.success,
        this.message,
        this.data,
        this.averageRating,
        this.nearbyPosts,
        this.reviews});

  CastomPositionMarinaModal.fromJson(Map<String, dynamic> json) {
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
  String? originalAuthor;
  String? sThumbnailId;
  String? propertyAddress;
  String? propertyCity;
  String? propertyArea;
  String? propertyZip;
  String? propertyCountry;
  String? propertyLatitude;
  String? propertyLongitude;
  String? textSlips;
  String? textMinimumapproachdepth;
  String? textMeanlowwaterdockdepth;
  String? textMinimumchanneldepth;
  String? textMeanhighwaterclearance;
  String? textFueldock;
  String? textGas;
  String? textTransientstorage;
  String? textLongtermstorage;
  String? textMaxvesselloa;
  String? textMaxsliplength;
  String? textMaxslipwidth;
  String? n1;
  String? n2;
  String? n3;
  String? ne1;
  String? ne2;
  String? ne3;
  String? e1;
  String? e2;
  String? e3;
  String? se1;
  String? se2;
  String? se3;
  String? s1;
  String? s2;
  String? s3;
  String? sw1;
  String? sw2;
  String? sw3;
  String? w1;
  String? w2;
  String? w3;
  String? nw1;
  String? nw2;
  String? nw3;
  String? ownAnchor;
  String? buoys;
  String? mountainWedges;
  String? ownLines;
  String? sand;
  String? mud;
  String? clay;
  String? coral;
  String? rocks;
  String? groceries;
  String? pharmacy;
  String? water;
  String? restaurant;
  String? alcohol;
  String? wpestateTotalViews;
  String? wpestateDetailedViews;
  String? beach;
  String? pontoon;
  String? shop;
  String? kind;
  String? navPropertyLatitude;
  String? navPropertyLongitude;
  String? mooringTypes;
  String? timezone;
  String? plan;
  String? rating;
  String? maxDraft;
  String? multihullFriendly;
  String? equipmentAvailability;
  String? likes;
  String? comments;
  String? navlyUrl;
  String? hasDock;
  String? hasPontoon;
  String? hasBeach;
  String? hasShop;
  String? hasHawser;
  String? sEditLock;
  String? sWpTrashMetaStatus;
  String? sWpTrashMetaTime;
  String? sWpOldSlug;
  String? sEditLast;
  String? rsPageBgColor;
  String? propertyPrice;
  String? propertyLabel;
  String? propertyLabelBefore;
  String? localPgprSliderType;
  String? localPgprContentType;
  String? propFeatured;
  String? propertyCounty;
  String? propertySize;
  String? ownerNotes;
  String? propertyLotSize;
  String? propertyRooms;
  String? propertyHasSubunits;
  String? propertySubunitsList;
  String? propertyBedrooms;
  String? propertyBathrooms;
  String? propertyStatus;
  String? embedVideoType;
  String? embedVideoId;
  String? virtualTour;
  String? propertyGoogleView;
  String? googleCameraAngle;
  String? payStatus;
  String? pageCustomZoom;
  String? hiddenAddress;
  String? propertyThemeSlider;
  String? imageToAttach;
  String? embedVirtualTour;
  String? mls;
  String? attic;
  String? gasHeat;
  String? oceanView;
  String? wineCellar;
  String? basketballCourt;
  String? gym;
  String? pound;
  String? fireplace;
  String? lakeView;
  String? pool;
  String? backYard;
  String? frontYard;
  String? fencedYard;
  String? sprinklers;
  String? washerAndDryer;
  String? deck;
  String? balcony;
  String? laundry;
  String? concierge;
  String? doorman;
  String? privateSpace;
  String? storage;
  String? recreation;
  String? roofDeck;
  String? propertyAgent;
  String? propertyUser;
  String? useFloorPlans;
  String? propertySubunitsListManual;
  String? postShowTitle;
  String? headerType;
  String? headerTransparent;
  String? useFloatSearchFormLocalSet;
  String? useFloatSearchFormLocal;
  String? minHeight;
  String? pageCustomImage;
  String? revSlider;
  String? sidebarOption;
  String? sidebarSelect;
  String? planTitle;
  String? planDescription;
  String? planImageAttach;
  String? planImage;
  String? planSize;
  String? planRooms;
  String? planBath;
  String? planPrice;
  String? advFilterSearchAction;
  String? advFilterSearchCategory;
  String? currentAdvFilterCity;
  String? currentAdvFilterArea;
  String? address;
  String? placeId;
  String? compoundCode;
  String? globalCode;
  String? checkboxValues;
  String? north;
  String? northeast;
  String? east;
  String? southeast;
  String? south;
  String? southwest;
  String? west;
  String? northwest;
  String? badMood;
  String? okayMood;
  String? goodMood;
  String? greatMood;
  String? excellencMood;

  MetaFields(
      {this.originalAuthor,
        this.sThumbnailId,
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
        this.wpestateTotalViews,
        this.wpestateDetailedViews,
        this.beach,
        this.pontoon,
        this.shop,
        this.kind,
        this.navPropertyLatitude,
        this.navPropertyLongitude,
        this.mooringTypes,
        this.timezone,
        this.plan,
        this.rating,
        this.maxDraft,
        this.multihullFriendly,
        this.equipmentAvailability,
        this.likes,
        this.comments,
        this.navlyUrl,
        this.hasDock,
        this.hasPontoon,
        this.hasBeach,
        this.hasShop,
        this.hasHawser,
        this.sEditLock,
        this.sWpTrashMetaStatus,
        this.sWpTrashMetaTime,
        this.sWpOldSlug,
        this.sEditLast,
        this.rsPageBgColor,
        this.propertyPrice,
        this.propertyLabel,
        this.propertyLabelBefore,
        this.localPgprSliderType,
        this.localPgprContentType,
        this.propFeatured,
        this.propertyCounty,
        this.propertySize,
        this.ownerNotes,
        this.propertyLotSize,
        this.propertyRooms,
        this.propertyHasSubunits,
        this.propertySubunitsList,
        this.propertyBedrooms,
        this.propertyBathrooms,
        this.propertyStatus,
        this.embedVideoType,
        this.embedVideoId,
        this.virtualTour,
        this.propertyGoogleView,
        this.googleCameraAngle,
        this.payStatus,
        this.pageCustomZoom,
        this.hiddenAddress,
        this.propertyThemeSlider,
        this.imageToAttach,
        this.embedVirtualTour,
        this.mls,
        this.attic,
        this.gasHeat,
        this.oceanView,
        this.wineCellar,
        this.basketballCourt,
        this.gym,
        this.pound,
        this.fireplace,
        this.lakeView,
        this.pool,
        this.backYard,
        this.frontYard,
        this.fencedYard,
        this.sprinklers,
        this.washerAndDryer,
        this.deck,
        this.balcony,
        this.laundry,
        this.concierge,
        this.doorman,
        this.privateSpace,
        this.storage,
        this.recreation,
        this.roofDeck,
        this.propertyAgent,
        this.propertyUser,
        this.useFloorPlans,
        this.propertySubunitsListManual,
        this.postShowTitle,
        this.headerType,
        this.headerTransparent,
        this.useFloatSearchFormLocalSet,
        this.useFloatSearchFormLocal,
        this.minHeight,
        this.pageCustomImage,
        this.revSlider,
        this.sidebarOption,
        this.sidebarSelect,
        this.planTitle,
        this.planDescription,
        this.planImageAttach,
        this.planImage,
        this.planSize,
        this.planRooms,
        this.planBath,
        this.planPrice,
        this.advFilterSearchAction,
        this.advFilterSearchCategory,
        this.currentAdvFilterCity,
        this.currentAdvFilterArea,
        this.address,
        this.placeId,
        this.compoundCode,
        this.globalCode,
        this.checkboxValues,
        this.north,
        this.northeast,
        this.east,
        this.southeast,
        this.south,
        this.southwest,
        this.west,
        this.northwest,
        this.badMood,
        this.okayMood,
        this.goodMood,
        this.greatMood,
        this.excellencMood});

  MetaFields.fromJson(Map<String, dynamic> json) {
    originalAuthor = json['original_author'];
    sThumbnailId = json['_thumbnail_id'];
    propertyAddress = json['property_address'];
    propertyCity = json['property_city'];
    propertyArea = json['property_area'];
    propertyZip = json['property_zip'];
    propertyCountry = json['property_country'];
    propertyLatitude = json['property_latitude'];
    propertyLongitude = json['property_longitude'];
    textSlips = json['text_slips'];
    textMinimumapproachdepth = json['text_minimumapproachdepth'];
    textMeanlowwaterdockdepth = json['text_meanlowwaterdockdepth'];
    textMinimumchanneldepth = json['text_minimumchanneldepth'];
    textMeanhighwaterclearance = json['text_meanhighwaterclearance'];
    textFueldock = json['text_fueldock'];
    textGas = json['text_gas'];
    textTransientstorage = json['text_transientstorage'];
    textLongtermstorage = json['text_longtermstorage'];
    textMaxvesselloa = json['text_maxvesselloa'];
    textMaxsliplength = json['text_maxsliplength'];
    textMaxslipwidth = json['text_maxslipwidth'];
    n1 = json['n1'];
    n2 = json['n2'];
    n3 = json['n3'];
    ne1 = json['ne1'];
    ne2 = json['ne2'];
    ne3 = json['ne3'];
    e1 = json['e1'];
    e2 = json['e2'];
    e3 = json['e3'];
    se1 = json['se1'];
    se2 = json['se2'];
    se3 = json['se3'];
    s1 = json['s1'];
    s2 = json['s2'];
    s3 = json['s3'];
    sw1 = json['sw1'];
    sw2 = json['sw2'];
    sw3 = json['sw3'];
    w1 = json['w1'];
    w2 = json['w2'];
    w3 = json['w3'];
    nw1 = json['nw1'];
    nw2 = json['nw2'];
    nw3 = json['nw3'];
    ownAnchor = json['own_anchor'];
    buoys = json['buoys'];
    mountainWedges = json['mountain_wedges'];
    ownLines = json['own_lines'];
    sand = json['sand'];
    mud = json['mud'];
    clay = json['clay'];
    coral = json['coral'];
    rocks = json['rocks'];
    groceries = json['groceries'];
    pharmacy = json['pharmacy'];
    water = json['water'];
    restaurant = json['restaurant'];
    alcohol = json['alcohol'];
    wpestateTotalViews = json['wpestate_total_views'];
    wpestateDetailedViews = json['wpestate_detailed_views'];
    beach = json['beach'];
    pontoon = json['pontoon'];
    shop = json['shop'];
    kind = json['kind'];
    navPropertyLatitude = json['nav_property_latitude'];
    navPropertyLongitude = json['nav_property_longitude'];
    mooringTypes = json['mooringTypes'];
    timezone = json['timezone'];
    plan = json['plan'];
    rating = json['rating'];
    maxDraft = json['maxDraft'];
    multihullFriendly = json['multihullFriendly'];
    equipmentAvailability = json['equipmentAvailability'];
    likes = json['likes'];
    comments = json['comments'];
    navlyUrl = json['navly_url'];
    hasDock = json['hasDock'];
    hasPontoon = json['hasPontoon'];
    hasBeach = json['hasBeach'];
    hasShop = json['hasShop'];
    hasHawser = json['hasHawser'];
    sEditLock = json['_edit_lock'];
    sWpTrashMetaStatus = json['_wp_trash_meta_status'];
    sWpTrashMetaTime = json['_wp_trash_meta_time'];
    sWpOldSlug = json['_wp_old_slug'];
    sEditLast = json['_edit_last'];
    rsPageBgColor = json['rs_page_bg_color'];
    propertyPrice = json['property_price'];
    propertyLabel = json['property_label'];
    propertyLabelBefore = json['property_label_before'];
    localPgprSliderType = json['local_pgpr_slider_type'];
    localPgprContentType = json['local_pgpr_content_type'];
    propFeatured = json['prop_featured'];
    propertyCounty = json['property_county'];
    propertySize = json['property_size'];
    ownerNotes = json['owner_notes'];
    propertyLotSize = json['property_lot_size'];
    propertyRooms = json['property_rooms'];
    propertyHasSubunits = json['property_has_subunits'];
    propertySubunitsList = json['property_subunits_list'];
    propertyBedrooms = json['property_bedrooms'];
    propertyBathrooms = json['property_bathrooms'];
    propertyStatus = json['property_status'];
    embedVideoType = json['embed_video_type'];
    embedVideoId = json['embed_video_id'];
    virtualTour = json['virtual_tour'];
    propertyGoogleView = json['property_google_view'];
    googleCameraAngle = json['google_camera_angle'];
    payStatus = json['pay_status'];
    pageCustomZoom = json['page_custom_zoom'];
    hiddenAddress = json['hidden_address'];
    propertyThemeSlider = json['property_theme_slider'];
    imageToAttach = json['image_to_attach'];
    embedVirtualTour = json['embed_virtual_tour'];
    mls = json['mls'];
    attic = json['attic'];
    gasHeat = json['gas_heat'];
    oceanView = json['ocean_view'];
    wineCellar = json['wine_cellar'];
    basketballCourt = json['basketball_court'];
    gym = json['gym'];
    pound = json['pound'];
    fireplace = json['fireplace'];
    lakeView = json['lake_view'];
    pool = json['pool'];
    backYard = json['back_yard'];
    frontYard = json['front_yard'];
    fencedYard = json['fenced_yard'];
    sprinklers = json['sprinklers'];
    washerAndDryer = json['washer_and_dryer'];
    deck = json['deck'];
    balcony = json['balcony'];
    laundry = json['laundry'];
    concierge = json['concierge'];
    doorman = json['doorman'];
    privateSpace = json['private_space'];
    storage = json['storage'];
    recreation = json['recreation'];
    roofDeck = json['roof_deck'];
    propertyAgent = json['property_agent'];
    propertyUser = json['property_user'];
    useFloorPlans = json['use_floor_plans'];
    propertySubunitsListManual = json['property_subunits_list_manual'];
    postShowTitle = json['post_show_title'];
    headerType = json['header_type'];
    headerTransparent = json['header_transparent'];
    useFloatSearchFormLocalSet = json['use_float_search_form_local_set'];
    useFloatSearchFormLocal = json['use_float_search_form_local'];
    minHeight = json['min_height'];
    pageCustomImage = json['page_custom_image'];
    revSlider = json['rev_slider'];
    sidebarOption = json['sidebar_option'];
    sidebarSelect = json['sidebar_select'];
    planTitle = json['plan_title'];
    planDescription = json['plan_description'];
    planImageAttach = json['plan_image_attach'];
    planImage = json['plan_image'];
    planSize = json['plan_size'];
    planRooms = json['plan_rooms'];
    planBath = json['plan_bath'];
    planPrice = json['plan_price'];
    advFilterSearchAction = json['adv_filter_search_action'];
    advFilterSearchCategory = json['adv_filter_search_category'];
    currentAdvFilterCity = json['current_adv_filter_city'];
    currentAdvFilterArea = json['current_adv_filter_area'];
    address = json['address'];
    placeId = json['place_id'];
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
    checkboxValues = json['checkbox_values'];
    north = json['north'];
    northeast = json['northeast'];
    east = json['east'];
    southeast = json['southeast'];
    south = json['south'];
    southwest = json['southwest'];
    west = json['west'];
    northwest = json['northwest'];
    badMood = json['bad_mood'];
    okayMood = json['okay_mood'];
    goodMood = json['good_mood'];
    greatMood = json['great_mood'];
    excellencMood = json['excellenc_mood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_author'] = this.originalAuthor;
    data['_thumbnail_id'] = this.sThumbnailId;
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
    data['wpestate_total_views'] = this.wpestateTotalViews;
    data['wpestate_detailed_views'] = this.wpestateDetailedViews;
    data['beach'] = this.beach;
    data['pontoon'] = this.pontoon;
    data['shop'] = this.shop;
    data['kind'] = this.kind;
    data['nav_property_latitude'] = this.navPropertyLatitude;
    data['nav_property_longitude'] = this.navPropertyLongitude;
    data['mooringTypes'] = this.mooringTypes;
    data['timezone'] = this.timezone;
    data['plan'] = this.plan;
    data['rating'] = this.rating;
    data['maxDraft'] = this.maxDraft;
    data['multihullFriendly'] = this.multihullFriendly;
    data['equipmentAvailability'] = this.equipmentAvailability;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['navly_url'] = this.navlyUrl;
    data['hasDock'] = this.hasDock;
    data['hasPontoon'] = this.hasPontoon;
    data['hasBeach'] = this.hasBeach;
    data['hasShop'] = this.hasShop;
    data['hasHawser'] = this.hasHawser;
    data['_edit_lock'] = this.sEditLock;
    data['_wp_trash_meta_status'] = this.sWpTrashMetaStatus;
    data['_wp_trash_meta_time'] = this.sWpTrashMetaTime;
    data['_wp_old_slug'] = this.sWpOldSlug;
    data['_edit_last'] = this.sEditLast;
    data['rs_page_bg_color'] = this.rsPageBgColor;
    data['property_price'] = this.propertyPrice;
    data['property_label'] = this.propertyLabel;
    data['property_label_before'] = this.propertyLabelBefore;
    data['local_pgpr_slider_type'] = this.localPgprSliderType;
    data['local_pgpr_content_type'] = this.localPgprContentType;
    data['prop_featured'] = this.propFeatured;
    data['property_county'] = this.propertyCounty;
    data['property_size'] = this.propertySize;
    data['owner_notes'] = this.ownerNotes;
    data['property_lot_size'] = this.propertyLotSize;
    data['property_rooms'] = this.propertyRooms;
    data['property_has_subunits'] = this.propertyHasSubunits;
    data['property_subunits_list'] = this.propertySubunitsList;
    data['property_bedrooms'] = this.propertyBedrooms;
    data['property_bathrooms'] = this.propertyBathrooms;
    data['property_status'] = this.propertyStatus;
    data['embed_video_type'] = this.embedVideoType;
    data['embed_video_id'] = this.embedVideoId;
    data['virtual_tour'] = this.virtualTour;
    data['property_google_view'] = this.propertyGoogleView;
    data['google_camera_angle'] = this.googleCameraAngle;
    data['pay_status'] = this.payStatus;
    data['page_custom_zoom'] = this.pageCustomZoom;
    data['hidden_address'] = this.hiddenAddress;
    data['property_theme_slider'] = this.propertyThemeSlider;
    data['image_to_attach'] = this.imageToAttach;
    data['embed_virtual_tour'] = this.embedVirtualTour;
    data['mls'] = this.mls;
    data['attic'] = this.attic;
    data['gas_heat'] = this.gasHeat;
    data['ocean_view'] = this.oceanView;
    data['wine_cellar'] = this.wineCellar;
    data['basketball_court'] = this.basketballCourt;
    data['gym'] = this.gym;
    data['pound'] = this.pound;
    data['fireplace'] = this.fireplace;
    data['lake_view'] = this.lakeView;
    data['pool'] = this.pool;
    data['back_yard'] = this.backYard;
    data['front_yard'] = this.frontYard;
    data['fenced_yard'] = this.fencedYard;
    data['sprinklers'] = this.sprinklers;
    data['washer_and_dryer'] = this.washerAndDryer;
    data['deck'] = this.deck;
    data['balcony'] = this.balcony;
    data['laundry'] = this.laundry;
    data['concierge'] = this.concierge;
    data['doorman'] = this.doorman;
    data['private_space'] = this.privateSpace;
    data['storage'] = this.storage;
    data['recreation'] = this.recreation;
    data['roof_deck'] = this.roofDeck;
    data['property_agent'] = this.propertyAgent;
    data['property_user'] = this.propertyUser;
    data['use_floor_plans'] = this.useFloorPlans;
    data['property_subunits_list_manual'] = this.propertySubunitsListManual;
    data['post_show_title'] = this.postShowTitle;
    data['header_type'] = this.headerType;
    data['header_transparent'] = this.headerTransparent;
    data['use_float_search_form_local_set'] = this.useFloatSearchFormLocalSet;
    data['use_float_search_form_local'] = this.useFloatSearchFormLocal;
    data['min_height'] = this.minHeight;
    data['page_custom_image'] = this.pageCustomImage;
    data['rev_slider'] = this.revSlider;
    data['sidebar_option'] = this.sidebarOption;
    data['sidebar_select'] = this.sidebarSelect;
    data['plan_title'] = this.planTitle;
    data['plan_description'] = this.planDescription;
    data['plan_image_attach'] = this.planImageAttach;
    data['plan_image'] = this.planImage;
    data['plan_size'] = this.planSize;
    data['plan_rooms'] = this.planRooms;
    data['plan_bath'] = this.planBath;
    data['plan_price'] = this.planPrice;
    data['adv_filter_search_action'] = this.advFilterSearchAction;
    data['adv_filter_search_category'] = this.advFilterSearchCategory;
    data['current_adv_filter_city'] = this.currentAdvFilterCity;
    data['current_adv_filter_area'] = this.currentAdvFilterArea;
    data['address'] = this.address;
    data['place_id'] = this.placeId;
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    data['checkbox_values'] = this.checkboxValues;
    data['north'] = this.north;
    data['northeast'] = this.northeast;
    data['east'] = this.east;
    data['southeast'] = this.southeast;
    data['south'] = this.south;
    data['southwest'] = this.southwest;
    data['west'] = this.west;
    data['northwest'] = this.northwest;
    data['bad_mood'] = this.badMood;
    data['okay_mood'] = this.okayMood;
    data['good_mood'] = this.goodMood;
    data['great_mood'] = this.greatMood;
    data['excellenc_mood'] = this.excellencMood;
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
