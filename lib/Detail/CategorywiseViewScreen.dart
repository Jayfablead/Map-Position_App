import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import '../Extras/Drwer.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../HomeScreen/HomeScreen.dart';
import '../LoginSinupScreen/LoginScreen.dart';
import '../Modal/AddFavouritePositionModal.dart';
import '../Modal/AddReviewModal.dart';
import '../Modal/DaywiseWedhterModal.dart';
import '../Modal/ReportModal.dart';
import '../Modal/ViewCategoryWiseviewDetailModal.dart';
import '../PrimiumPayments/positionController.dart';
import '../Provider/Authprovider.dart';
import 'DetailsOtherScreen.dart';
import 'DetailsScreen.dart';
import 'OtherWarningDetailsScreen.dart';
import 'ViewAllPositionDetailsScreen.dart';

class CategoryWiseViewScreen extends StatefulWidget {
  String? postid;

  CategoryWiseViewScreen({super.key, this.postid});

  @override
  State<CategoryWiseViewScreen> createState() => _CategoryWiseViewScreenState();
}

final List<String> titles = [
  "Surat",
  "Up",
  "Gujarat",
  "Karon",
  "Mp",
];
List imgs = [
  "https://assets-global.website-files.com/5e83362767d71ffd59a0c8a9/6377b0249bab82a13967e18f_hero%20image%20-%20Mapbox%20Satellite%20Streets.png",
  "https://taxiboatvarenna.com/wp-content/uploads/2023/11/TaxiBoatVarenna-Boat-sailing-on-lake-Como-2.webp",
  "https://d2ugbn5gb88fyp.cloudfront.net/1289393/0_0.png",
  "https://d2ugbn5gb88fyp.cloudfront.net/1289393/0_0.png",
  "https://d2ugbn5gb88fyp.cloudfront.net/1289393/0_0.png",
];

class _CategoryWiseViewScreenState extends State<CategoryWiseViewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _review = TextEditingController();
  int _rating = 0;
  String? selectedvalue="--- Select ---";
  bool isLoading = true;
  String htmlString = '';
  String plainText = '';
  final _formKey = GlobalKey<FormState>();
  bool showError = false;
  int type = 0;
  DateTime now = DateTime.now();
  TextEditingController searchController = TextEditingController();
  final PositionController positionController = Get.put(PositionController());

  TextEditingController _comments = TextEditingController();
  Set<Marker> _markers = {};
  List<MarkerData> _customMarkers = [];
  var latitudeString;
  var longitudeString;

  LatLng _center = LatLng(21.1702, 72.8311); // Default initial position
  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 10);
  Position? _currentPosition;
  int? select;
  late LatLng dynamicLatLng;

  late GoogleMapController mapController;
  late LatLng _currentPosition1 = LatLng(
      double.parse(viewcategorywisevieweetailmodal?.data?.latitude ?? ""),
      double.parse(viewcategorywisevieweetailmodal?.data?.longitude ?? ""));
  bool _isSatellite = false;
  GoogleMapController? _mapController;
  ImagePicker picker = ImagePicker();
  File? selectedimage = null;

  List<String> _imagePaths = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // void _onMapTapped(LatLng latLng) {
  //   setState(() {
  //     _markers.clear();
  //     _markers.add(Marker(
  //       markerId: MarkerId('Tapped Location'),
  //       position: latLng,
  //     ));
  //   });
  // }

  void _searchAndNavigate() async {
    final String address = searchController.text;
    List<Location> locations = await locationFromAddress(address);
    if (locations != null && locations.isNotEmpty) {
      setState(() {
        _center = LatLng(locations[0].latitude, locations[0].longitude);
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId('Searched Location'),
          position: _center,
        ));
        mapController!.animateCamera(CameraUpdate.newLatLng(_center));
      });
    }
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;
    LatLng location = LatLng(lat, long);
    setState(() {
      _currentPosition1 = location;
      lat1 = lat;
      lng1 = long;
      isLoading = false;
    });
  }

  MapType _mapType = MapType.normal;

  void _toggleMapType() {
    setState(() {
      _isSatellite = !_isSatellite;
    });
    setState(() {
      _mapType = _isSatellite ? MapType.satellite : MapType.normal;
    });
  }

  DateTime? futureDate;
  double? lat1, lng1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewposition();
    getLocation();
    isLoading = true;
    setState(() {
      futureDate = now.add(Duration(days: 10));
    });
    setState(() {
      isLoading = true;
    });
    wedther();
    print("Postidavigayache:-${widget.postid.toString()}");
  }

  Widget build(BuildContext context) {
    return commanScreen(
      isLoading: isLoading,
      scaffold: Scaffold(
        key: _scaffoldKeyProductlistpage,
        drawer: drawer1(),
        backgroundColor: bgcolor,
        body: isLoading
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: bgcolor, // Border color
                                  width: 2.sp, // Border width
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: viewcategorywisevieweetailmodal
                                          ?.data?.thumbnail ??
                                      "",
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Container(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Default_Profile,
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 5.h,
                          left: 4.w,
                          right: 3.w,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(HomeScreen());
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _scaffoldKeyProductlistpage
                                              .currentState
                                              ?.openDrawer();
                                        },
                                        icon: Icon(
                                          Icons.menu_rounded,
                                          color: blackback,
                                          size: 23.sp,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Column(children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 90.w,
                                  child: Text(
                                    viewcategorywisevieweetailmodal
                                                    ?.data?.title ==
                                                "" ||
                                            viewcategorywisevieweetailmodal
                                                    ?.data?.title ==
                                                null
                                        ? "N/A"
                                        : viewcategorywisevieweetailmodal
                                                ?.data?.title ??
                                            "",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: blackback,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "volken"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.black, size: 15.sp),
                                Text(
                                  "${viewcategorywisevieweetailmodal?.data?.latitude == "" || viewcategorywisevieweetailmodal?.data?.latitude == null ? "N/A" : viewcategorywisevieweetailmodal?.data?.latitude}, ${viewcategorywisevieweetailmodal?.data?.longitude == "" || viewcategorywisevieweetailmodal?.data?.longitude == null ? "N/A" : viewcategorywisevieweetailmodal?.data?.longitude} ",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken"),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Text(
                              " ⭐️ ${viewcategorywisevieweetailmodal?.averageRating == "" || viewcategorywisevieweetailmodal?.averageRating == null ? "4.5" : viewcategorywisevieweetailmodal?.averageRating ?? ""} [${viewcategorywisevieweetailmodal?.reviews?.length == null || viewcategorywisevieweetailmodal?.reviews?.length == "" || viewcategorywisevieweetailmodal?.reviews?.length == 0 ? "0" : viewcategorywisevieweetailmodal?.reviews?.length} reviews]",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: secondary,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "volken"),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),

                            // Icon(
                            //   Icons.add_location,
                            //   color: Colors.black,
                            //   size: 20.sp,
                            // ),
                            // Text(
                            //   "Sleman,Yogyakarta",
                            //   style: TextStyle(
                            //       letterSpacing: 1,
                            //       color: secondary,
                            //       fontSize: 12.sp,
                            //       fontWeight: FontWeight.normal,
                            //       fontFamily: "volken"),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Container(
                        //           margin: EdgeInsets.symmetric(horizontal: 1.w),
                        //           height: 15.w,
                        //           width: 15.w,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(15),
                        //             border: Border.all(
                        //               color: bgcolor, // Border color
                        //               width: 2.sp, // Border width
                        //             ),
                        //           ),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(15),
                        //             child: CachedNetworkImage(
                        //               imageUrl:
                        //                   'https://i.pinimg.com/originals/51/e0/d5/51e0d5aa27808ce689e3dd5a5cd7685a.png',
                        //               fit: BoxFit.cover,
                        //               progressIndicatorBuilder:
                        //                   (context, url, progress) =>
                        //                       CircularProgressIndicator(),
                        //               errorWidget: (context, url, error) =>
                        //                   Image.asset(Default_Profile, fit: BoxFit.cover),
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: 3.w,
                        //         ),
                        //         Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text("Rabert Downerny",
                        //                 style: TextStyle(
                        //                     letterSpacing: 1,
                        //                     color: Colors.black,
                        //                     fontSize: 12.sp,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontFamily: "volken")),
                        //             SizedBox(
                        //               height: 0.5.h,
                        //             ),
                        //             Text("Boat Owner",
                        //                 style: TextStyle(
                        //                     letterSpacing: 1,
                        //                     color: secondary,
                        //                     fontSize: 12.sp,
                        //                     fontWeight: FontWeight.normal,
                        //                     fontFamily: "volken")),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         Container(
                        //           height: 12.w,
                        //           width: 12.w,
                        //           alignment: Alignment.center,
                        //           padding: EdgeInsetsDirectional.all(2.2.w),
                        //           decoration: BoxDecoration(
                        //             color: blackback,
                        //             borderRadius: BorderRadius.circular(900),
                        //           ),
                        //           child: Icon(
                        //             Icons.sms,
                        //             color: Colors.white,
                        //             size: 15.sp,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 1.h,
                        // ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                report();
                              },
                              child: Icon(
                                Icons.flag_outlined,
                                color: Colors.black,
                                size: 23.sp,
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            InkWell(
                            onTap: (){
                              report();
                            },
                              child: Text("Report",

                                  style: TextStyle(
                                      letterSpacing: 1,
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Text("Facilities Nearby :-",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5.w, vertical: 1.h),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.sp, color: secondary),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-groceries-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/groceries.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.groceries ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Groceries",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-pharmacy-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/icons8-pharmacy-100.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.pharmacy ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Pharmacy",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-alcohol-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/icons8-alcohol-100.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.alcohol ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Alcohol",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-restaurant-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/icons8-restaurant-100.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.restaurant ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Restaurant",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-water-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/icons8-water-100.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.water ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Water",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/04/icons8-beach-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "icons8-beach-100.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.alcohol ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Beach",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/04/icons8-pontoon-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/icons8-restaurant-100.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.restaurant ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Pontoon",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 25.w,
                                                  width: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/04/icons8-shop-100.png",
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/icons8-shop-100.png"),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 18.w,
                                                  child:
                                                      viewcategorywisevieweetailmodal
                                                                  ?.data
                                                                  ?.metaFields
                                                                  ?.water ==
                                                              false
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ))
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green,
                                                                    width:
                                                                        1.sp),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 18.sp,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "Shop",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Text("Description :-",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: blackback,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken"))
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 95.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: secondary, width: 1.sp),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ReadMoreText(
                                '${viewcategorywisevieweetailmodal?.data?.content == "" || viewcategorywisevieweetailmodal?.data?.content == null ? "N/A" : viewcategorywisevieweetailmodal?.data?.content ?? ""}',
                                trimLines: 4,
                                trimLength: 146,
                                colorClickableText: Colors.blue,
                                trimMode: TrimMode.Length,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: ' Show less',
                                moreStyle: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken",
                                    letterSpacing: 1,
                                    color: blackback),
                                lessStyle: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: "volken",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    color: blackback),
                                style: TextStyle(
                                  height: 1.5,
                                  color: secondary,
                                  fontFamily: "volken",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text("Details :-",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: blackback,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken"))
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Container(
                                width: 95.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: secondary, width: 1.sp),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Characteristics",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: blackback,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 87.w,
                                          child: Text(
                                              "Here are the mooring conditions you'll find in the anchorage Anse de l'Aiguade",
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  color: secondary,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "volken")),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/anchor.jpg',
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          Default_Profile,
                                                          fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 12.w,
                                              child:
                                                  viewcategorywisevieweetailmodal
                                                              ?.data
                                                              ?.metaFields
                                                              ?.ownAnchor ==
                                                          false
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.red,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                            size: 18.sp,
                                                          ))
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                            size: 18.sp,
                                                          )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text("Use your own anchor(s)",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: secondary,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/buoys.jpg',
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          Default_Profile,
                                                          fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 12.w,
                                              child:
                                                  viewcategorywisevieweetailmodal
                                                              ?.data
                                                              ?.metaFields
                                                              ?.buoys ==
                                                          false
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.red,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                            size: 18.sp,
                                                          ))
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                            size: 18.sp,
                                                          )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text("Fixed Buoys are available",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: secondary,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/mountain.png',
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          Default_Profile,
                                                          fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 12.w,
                                              child:
                                                  viewcategorywisevieweetailmodal
                                                              ?.data
                                                              ?.metaFields
                                                              ?.mountainWedges ==
                                                          false
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.red,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                            size: 18.sp,
                                                          ))
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                            size: 18.sp,
                                                          )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text("mountain wedges available",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: secondary,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/ashore.jpg',
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          Default_Profile,
                                                          fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 12.w,
                                              child:
                                                  viewcategorywisevieweetailmodal
                                                              ?.data
                                                              ?.metaFields
                                                              ?.ownLines ==
                                                          false
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.red,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                            size: 18.sp,
                                                          ))
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green,
                                                                width: 1.sp),
                                                          ),
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                            size: 18.sp,
                                                          )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text("Use your own lines ashore",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: secondary,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Container(
                                width: 95.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: secondary, width: 1.sp),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Seabed types :-",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: blackback,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 87.w,
                                          child: Text(
                                              "You'll find the following types of seabed at Anse de l'Aiguade",
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  color: secondary,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "volken")),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black12,
                                                      width: 1.sp)),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 25.w,
                                                        width: 25.w,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(90),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Sand.jpg",
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        progress) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    Default_Profile),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 18.w,
                                                        child: viewcategorywisevieweetailmodal
                                                                    ?.data
                                                                    ?.metaFields
                                                                    ?.sand ==
                                                                false
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 18.sp,
                                                                ))
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .green,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 18.sp,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "Sand",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black12,
                                                      width: 1.sp)),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 25.w,
                                                        width: 25.w,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(90),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Mud.jpg",
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        progress) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              "assets/Mud.jpg",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 18.w,
                                                        child: viewcategorywisevieweetailmodal
                                                                    ?.data
                                                                    ?.metaFields
                                                                    ?.mud ==
                                                                false
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 18.sp,
                                                                ))
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .green,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 18.sp,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "Mud",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black12,
                                                      width: 1.sp)),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 25.w,
                                                        width: 25.w,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(90),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Clay.jpg",
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        progress) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    Default_Profile),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 18.w,
                                                        child: viewcategorywisevieweetailmodal
                                                                    ?.data
                                                                    ?.metaFields
                                                                    ?.clay ==
                                                                false
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 18.sp,
                                                                ))
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .green,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 18.sp,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "Clay",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black12,
                                                      width: 1.sp)),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 25.w,
                                                        width: 25.w,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(90),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Coral.png",
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        progress) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    Default_Profile),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 18.w,
                                                        child: viewcategorywisevieweetailmodal
                                                                    ?.data
                                                                    ?.metaFields
                                                                    ?.coral ==
                                                                false
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 18.sp,
                                                                ))
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .green,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 18.sp,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "Coral",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black12,
                                                      width: 1.sp)),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 25.w,
                                                        width: 25.w,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(90),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Rocks.jpg",
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        progress) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    Default_Profile),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 18.w,
                                                        child: viewcategorywisevieweetailmodal
                                                                    ?.data
                                                                    ?.metaFields
                                                                    ?.rocks ==
                                                                false
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 18.sp,
                                                                ))
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .green,
                                                                      width:
                                                                          1.sp),
                                                                ),
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 18.sp,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "Rocks",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Container(
                                width: 95.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: secondary, width: 1.sp),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Weather :-",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: blackback,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(00),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/weather/wind.png",
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                              Default_Profile),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              "Wind",
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 20.w,
                                                    width: 20.w,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              00),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/weather/swell.png",
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    progress) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/Mud.jpg",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Text(
                                                    "Swell",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(00),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/weather/wind-speed.png",
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                              Default_Profile),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                "Speed :${daywisewedhtermodal?.days?[0].hours?[0].windspeed == "" || daywisewedhtermodal?.days?[0].hours?[0].windspeed == null ? "N/A" : (daywisewedhtermodal?.days?[0].hours?[0].windspeed).toString()}",
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 13.sp,
                                                  color: secondary,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "volken",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 20.w,
                                                    width: 20.w,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              00),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/weather/height.png",
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    progress) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/Mud.jpg",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "Height",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(00),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://img.myloview.com/posters/cloud-sun-icon-simple-color-with-outline-vector-elements-of-forecast-icons-for-ui-and-ux-website-or-mobile-application-700-219337463.jpg",
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                              Default_Profile),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                daywisewedhtermodal
                                                                ?.days?[0]
                                                                .hours?[0]
                                                                .conditions ==
                                                            "" ||
                                                        daywisewedhtermodal
                                                                ?.days?[0]
                                                                .hours?[0]
                                                                .conditions ==
                                                            null
                                                    ? "N/A"
                                                    : (daywisewedhtermodal
                                                            ?.days?[0]
                                                            .hours?[0]
                                                            .conditions)
                                                        .toString(),
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 13.sp,
                                                  color: secondary,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "volken",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.h),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 20.w,
                                                    width: 20.w,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              00),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/weather/wave-line.png",
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    progress) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/Mud.jpg",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "    --",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      color: secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "volken",
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20.w,
                                              width: 20.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(00),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/weather/temp.png",
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                              Default_Profile),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                "${daywisewedhtermodal?.days?[0].temp == "" || daywisewedhtermodal?.days?[0].temp == null ? "N/A" : (daywisewedhtermodal?.days?[0].temp).toString()}°C",
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 13.sp,
                                                  color: secondary,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "volken",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),

                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          height: 25.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black12, width: 1.sp)),
                          child: CustomGoogleMapMarkerBuilder(
                            //screenshotDelay: const Duration(seconds: 4),
                            customMarkers: _customMarkers,
                            builder:
                                (BuildContext context, Set<Marker>? markers) {
                              if (markers == null) {
                                print("online");
                                return GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                    target: _currentPosition1,
                                    // You can set your initial position here
                                    zoom: 12.0,
                                  ),
                                  mapType: _mapType,
                                  markers: _markers,
                                  myLocationButtonEnabled: false,
                                  myLocationEnabled: true,
                                  zoomControlsEnabled: true,
                                  compassEnabled: true,
                                  scrollGesturesEnabled: true,
                                );
                              }
                              return GoogleMap(
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _currentPosition1,
                                  // You can set your initial position here
                                  zoom: 12.0,
                                ),
                                gestureRecognizers: Set()
                                  ..add(Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer(),
                                  )),
                                scrollGesturesEnabled: true,
                                mapToolbarEnabled: true,
                                mapType: _mapType,
                                markers: markers,
                                myLocationButtonEnabled: false,
                                myLocationEnabled: true,
                                zoomControlsEnabled: false,
                                compassEnabled: true,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Text("Nearby Listings :-",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: blackback,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        viewcategorywisevieweetailmodal
                            ?.nearbyPosts?.length==""||viewcategorywisevieweetailmodal
                            ?.nearbyPosts?.length==0||viewcategorywisevieweetailmodal
                            ?.nearbyPosts?.length==null?Container(height: 20.h,alignment: Alignment.center,child: Text("No Nearby Listings Available", style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight:
                            FontWeight.w500,
                            fontFamily:
                            "volken",
                            letterSpacing: 1), ),)
                            :Container(
                          height: 28.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewcategorywisevieweetailmodal
                                ?.nearbyPosts?.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 1.w),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1.sp, color: secondary),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            height: 15.h,
                                            width: 45.w,
                                            imageUrl:
                                                viewcategorywisevieweetailmodal
                                                        ?.nearbyPosts?[index]
                                                        .thumbnail ??
                                                    "",
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                    url, progress) =>
                                                Container(
                                                    alignment: Alignment.center,
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              Default_Profile,
                                            ),
                                          ),
                                        ),
                                        loginmodal?.userId == "" ||
                                                loginmodal?.userId == null
                                            ? Container()
                                            : Positioned(
                                                top: 0.2.h,
                                                left: 34.w,
                                                child: InkWell(
                                                  onTap: () {
                                                    print(
                                                        "datavalye${viewcategorywisevieweetailmodal?.nearbyPosts?[index].isFavorite}");
                                                    addfevorite(
                                                        (viewcategorywisevieweetailmodal
                                                            ?.nearbyPosts?[
                                                                index]
                                                            .isFavorite)!,
                                                        (viewcategorywisevieweetailmodal
                                                                    ?.nearbyPosts?[
                                                                        index]
                                                                    .id)
                                                                ?.toString() ??
                                                            "");
                                                    print("abc");
                                                  },
                                                  child: Container(
                                                    height: 9.w,
                                                    width: 9.w,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .all(2.2.w),
                                                    decoration: BoxDecoration(
                                                      color: blackback,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              900),
                                                    ),
                                                    child: viewcategorywisevieweetailmodal
                                                                ?.nearbyPosts?[
                                                                    index]
                                                                .isFavorite ==
                                                            true
                                                        ? Icon(
                                                            CupertinoIcons
                                                                .heart_fill,
                                                            color: Colors.white,
                                                            size: 15.sp,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.white,
                                                            size: 15.sp,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 42.w,
                                          child: Text(
                                            viewcategorywisevieweetailmodal
                                                            ?.nearbyPosts?[
                                                                index]
                                                            .title ==
                                                        "" ||
                                                    viewcategorywisevieweetailmodal
                                                            ?.nearbyPosts?[
                                                                index]
                                                            .title ==
                                                        null
                                                ? "N/A"
                                                : (viewcategorywisevieweetailmodal
                                                        ?.nearbyPosts?[index]
                                                        .title)
                                                    .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: "Volkan",
                                              letterSpacing: 1.2,
                                              color: secondary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    batan(
                                        title: "View Details",
                                        route: () {
                                          print(
                                              "dsfsf${viewcategorywisevieweetailmodal?.nearbyPosts?[index].id}");
                                          Get.to(ViewAllPositionDetailsScreen(
                                              postid:
                                                  (viewcategorywisevieweetailmodal
                                                          ?.nearbyPosts?[index]
                                                          .id)
                                                      ?.toString()));
                                        },
                                        hight: 5.h,
                                        width: 30.w,
                                        txtsize: 12.sp)
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Review",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: blackback,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                            loginmodal?.userId == "" ||
                                    loginmodal?.userId == null
                                ? Container()
                                : loginmodal?.userId == "" ||
                                        loginmodal?.userId == null
                                    ? buildErrorDialog1(
                                        context,
                                        "",
                                        "Please Login To Use This",
                                        buttonname: 'Login',
                                        () {
                                          Get.offAll(LoginScreen());
                                        },
                                      )
                                    :
                            loginmodal?.userId == viewcategorywisevieweetailmodal?.data?.authorId ?Container(): InkWell(
                                        onTap: () {
                                          showratingpop1();
                                        },
                                        child: Text("Add Review",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: blackback,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "volken")),
                                      ),
                          ],
                        ),
                        viewcategorywisevieweetailmodal?.reviews?.length ==
                                    null ||
                                viewcategorywisevieweetailmodal
                                        ?.reviews?.length ==
                                    '' ||
                                viewcategorywisevieweetailmodal
                                        ?.reviews?.length ==
                                    0
                            ? Container(
                                height: 20.h,
                                alignment: Alignment.center,
                                child: Text(
                                  "No Review Available",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "volken",
                                      letterSpacing: 1),
                                ),
                              )
                            : Column(
                                children: [
                                  for (int i = 0;
                                      i <
                                          (viewcategorywisevieweetailmodal
                                                  ?.reviews?.length ??
                                              0);
                                      i++) ...[
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 0.5.h),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 0.5.h,
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade400,
                                                width: 0.5),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          children: [
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 20.w,
                                                    width: 20.w,
                                                    padding:
                                                        EdgeInsets.all(1.w),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90),
                                                      child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              viewcategorywisevieweetailmodal
                                                                      ?.reviews?[
                                                                          i]
                                                                      .userImg ??
                                                                  "",
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      progress) =>
                                                                  Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                                Icons.person,
                                                                size: 15.w,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 60.w,
                                                            child: Text(
                                                              viewcategorywisevieweetailmodal
                                                                              ?.reviews?[
                                                                                  i]
                                                                              .name ==
                                                                          "" ||
                                                                      viewcategorywisevieweetailmodal
                                                                              ?.reviews?[
                                                                                  i]
                                                                              .name ==
                                                                          null
                                                                  ? "N/A"
                                                                  : (viewcategorywisevieweetailmodal
                                                                          ?.reviews?[
                                                                              i]
                                                                          .name)
                                                                      .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontFamily:
                                                                    "volken",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: 14.sp,
                                                          ),
                                                          Text(
                                                            viewcategorywisevieweetailmodal
                                                                            ?.reviews?[
                                                                                i]
                                                                            .reviewerRating ==
                                                                        "" ||
                                                                    viewcategorywisevieweetailmodal
                                                                            ?.reviews?[
                                                                                i]
                                                                            .reviewerRating ==
                                                                        null
                                                                ? "0"
                                                                : (viewcategorywisevieweetailmodal
                                                                        ?.reviews?[
                                                                            i]
                                                                        .reviewerRating)
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "volken",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing:
                                                                  0.5,
                                                              color: secondary
                                                                  .withOpacity(
                                                                      0.45),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                      SizedBox(
                                                        width: 65.w,
                                                        child: Text(
                                                          viewcategorywisevieweetailmodal
                                                                          ?.reviews?[
                                                                              i]
                                                                          .reviewSummary
                                                                          ?.xsReviwSummery ==
                                                                      "" ||
                                                                  viewcategorywisevieweetailmodal
                                                                          ?.reviews?[
                                                                              i]
                                                                          .reviewSummary
                                                                          ?.xsReviwSummery ==
                                                                      null
                                                              ? "N/A"
                                                              : (viewcategorywisevieweetailmodal
                                                                      ?.reviews?[
                                                                          i]
                                                                      .reviewSummary
                                                                      ?.xsReviwSummery)
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "volken",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 0.5,
                                                            color: secondary
                                                                .withOpacity(
                                                                    0.45),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              )
                      ]),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
  report() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // backgroundColor: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          // height:  MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bgcolor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 7.w,
                                    width: 7.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        color: Colors.black),
                                    child: InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 15.sp,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Report Property",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Volkan"),
                                  ),
                                  SizedBox(height: 1.h),

                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text("Category :-",style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken")),
                              SizedBox(height: 1.h,),
                              Container(
                                height: 5.5.h,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  border: Border.all(width: 1, color: secondary),
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child:DropdownButton(
                                  dropdownColor: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  hint: Text("Please Select Position Category",style: TextStyle(color:secondary,fontFamily: "volken",)),

                                  value: selectedvalue,
                                  onChanged: (val)
                                  {
                                    setState((){
                                      selectedvalue=val!;
                                      print(selectedvalue);
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("--- Select ---",style: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "--- Select ---",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("sexual content",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "sexual-content",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("violent or repulsive content",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "violent-or-repulsive-content",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("hateful or abusive content",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "hateful-or-abusive-content",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("harassment or bullying",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "harassment-or-bullying",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("harmful or dangerous acts",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "harmful-or-dangerous-acts",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Misinformation",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "misinformation",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Child Abuse",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "child-abuse",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Promotes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "promotes",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Spam or Misleading",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "spam-or-misleading",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Legal issue",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "legal-issue",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Captions issue",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "captions-issue",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Other",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "other",
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Your Name :-",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Volkan")),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    width: 85.w,
                                    child: TextFormField(

                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black),
                                      controller: _name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Your Name ";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(
                                        hintText: "Enter Your Your Name",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Message :-",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Volkan")),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    width: 85.w,
                                    child: TextFormField(
                                      maxLines: 4,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black),
                                      controller: _email,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Message ";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(
                                        hintText: "Enter Your Message",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                             batan(
                                  title: "REPORT",
                                  route: () {
                                    reportapifun();
                                  },
                                  hight: 6.h,
                                  width: 85.w,
                                  txtsize: 15.sp),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
  reportapifun() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['post_id'] = widget.postid.toString();
      data['opinion_text'] = selectedvalue.toString();
      data['name'] =_name.text.toString();
      data['message'] = _email.text.toString();
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().reportapi(data).then((response) async {
            reportmodal =
                ReportModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && reportmodal?.success == true) {
              EasyLoading.showSuccess(reportmodal?.message ?? '');
              Get.back();
              setState(() {});
            } else {
              EasyLoading.showError(reportmodal?.message ?? '');
              setState(() {});
            }
          });
        } else {
          EasyLoading.showError(reportmodal?.message ?? '');
          setState(() {});
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
  viewposition() {
    final Map<String, String> data = {};
    data['post_id'] = widget.postid.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    print(data);
    print("printData${data}");
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewsinganalpositionviewapi(data).then((response) async {
          viewcategorywisevieweetailmodal =
              ViewCategoryWiseviewDetailModal.fromJson(
                  json.decode(response.body));
          if (response.statusCode == 200 &&
              viewcategorywisevieweetailmodal?.success == true) {
            print("Categorywiseapicall");
            for (int index = 0;
                index < (shoallmarkermodal?.positions?.length ?? 0);
                index++) {
              print("markerlength${shoallmarkermodal?.positions?.length}");
              var latitudeString =
                  viewcategorywisevieweetailmodal?.data?.latitude;
              var longitudeString =
                  viewcategorywisevieweetailmodal?.data?.longitude;

              if (latitudeString != null && longitudeString != null) {
                // Validate latitude and longitude strings
                if (_isValidDouble(latitudeString) &&
                    _isValidDouble(longitudeString)) {
                  try {
                    double latitude = double.parse(latitudeString);
                    double longitude = double.parse(longitudeString);
                    String imageurl = (shoallmarkermodal
                            ?.positions?[index].properties?.imgURL)
                        .toString();
                    _customMarkers.add(
                      MarkerData(
                        marker: Marker(
                          onTap: () {
                            print(
                                "positiname:-${shoallmarkermodal?.positions?[index].properties?.title.toString()}");
                            setState(() {
                              select = index;
                            });
                          },
                          markerId: MarkerId(
                              'id-${shoallmarkermodal?.positions?[index].properties?.title.toString()}'),
                          position: LatLng(latitude, longitude),
                        ),
                        child: Image.asset(
                          "assets/otheryellow.png",
                          height: 20.w,
                          width: 20.w,
                          color: Colors.blue,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );

                    // Set _currentPosition1 to the first marker position
                    if (index == 0) {
                      _currentPosition1 = LatLng(latitude, longitude);
                    }
                  } catch (e) {
                    print("Error parsing coordinates: $e");
                  }
                } else {
                  print("Invalid latitude or longitude format");
                }
              } else {
                print("Latitude or longitude is null");
              }
            }
            setState(() {
              isLoading = false;
              print(plainText);
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }

  addreview() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['post_id'] = widget.postid.toString();
      data['user_id'] = (loginmodal?.userId).toString();
      data['rating'] = _rating.toString();
      data['review_summary'] = _review.text.trim().toString();
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().addreviewapi(data).then((response) async {
            addreviewmodal =
                AddReviewModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && addreviewmodal?.success == true) {
              EasyLoading.showSuccess(addreviewmodal?.message ?? '');
              viewposition();
              setState(() {});
            } else {
              EasyLoading.showError(addreviewmodal?.message ?? '');
              setState(() {});
            }
          });
        } else {
          EasyLoading.showError(addreviewmodal?.message ?? '');
          setState(() {});
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }

  showratingpop1() {
    setState(() {
      _review.clear();
      _rating = 0;
      showError = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // backgroundColor: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          // height:  MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bgcolor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 7.w,
                                    width: 7.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: primary),
                                    child: InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 15.sp,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Rating :-",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Volkan"),
                                  ),
                                  SizedBox(height: 1.h),
                                  RatingBar.builder(
                                    itemSize: 25,
                                    initialRating: _rating.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    glow: false,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    unratedColor: Colors.amber,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, index) {
                                      if (index < _rating.floor()) {
                                        return Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        );
                                      } else {
                                        return Icon(
                                          Icons.star_border,
                                          color: Colors.amber,
                                        );
                                      }
                                    },
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        _rating = rating.toInt();
                                        showError = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              if (showError)
                                SizedBox(
                                  height: 2.h,
                                ),
                              if (showError)
                                Center(
                                  child: Text(
                                    '* Please Select Rating *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Volkan",
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Review  : ",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Volkan")),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    width: 85.w,
                                    child: TextFormField(
                                      maxLines: 4,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black),
                                      controller: _review,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Your Review ";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(
                                        hintText: "Enter Your Review",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              loginmodal?.userId == "" ||
                                      loginmodal?.userId == null
                                  ? Container()
                                  : batan(
                                      title: "Add Review",
                                      route: () {
                                        if (_rating == 0) {
                                          setState(() {
                                            showError = true;
                                          });
                                        } else {
                                          Get.back();
                                          addreview();
                                        }
                                      },
                                      hight: 6.h,
                                      width: 85.w,
                                      txtsize: 15.sp),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  addfevorite(bool value, id) {
    EasyLoading.show(status: 'Please Wait ...');
    final Map<String, String> data = {};
    data['post_id'] = id.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    data['isFavorite'] = value ? '0' : '1';
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().addfevouriteapi(data).then((response) async {
          addfavouritepositionmodal =
              AddFavouritePositionModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              addfavouritepositionmodal?.success == true) {
            EasyLoading.showSuccess(addfavouritepositionmodal?.message ?? '');
            // viewposition();
            viewposition();
            print('Categorywise api call');
            setState(() {});
          } else {
            EasyLoading.showError(addreviewmodal?.message ?? '');
            setState(() {});
          }
        });
      } else {
        EasyLoading.showError(addreviewmodal?.message ?? '');
        setState(() {});
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }

  bool _isValidDouble(String value) {
    if (value == null) return false;
    final RegExp regex = RegExp(r'^-?[\d.]+$');
    return regex.hasMatch(value);
  }

  wedther() {
    checkInternet().then((internet) async {
      if (internet) {
        authprovider()
            .wedtherapi(
                viewcategorywisevieweetailmodal?.data?.latitude,
                viewcategorywisevieweetailmodal?.data?.longitude,
                '${now.year}-${now.month}-${now.day}',
                '${futureDate!.year}-${futureDate!.month}-${futureDate!.day}')
            .then((response) async {
          daywisewedhtermodal =
              DaywiseWeatherModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
}
