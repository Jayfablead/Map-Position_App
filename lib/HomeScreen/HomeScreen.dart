import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/bottombar.dart';
import 'package:sizer/sizer.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/ShoAllMarkerModal.dart';
import '../Provider/Authprovider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController _positionname = TextEditingController();
  TextEditingController _comments = TextEditingController();
  Set<Marker> _markers = {};
  List<MarkerData> _customMarkers = [];

  LatLng _center = LatLng(21.1702, 72.8311); // Default initial position
  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 10);
  Position? _currentPosition;
  int? select;
  late LatLng dynamicLatLng;
  late GoogleMapController mapController;
  late LatLng _currentPosition1 = LatLng(21.1702, 72.8311);
  bool _isSatellite = false;
  GoogleMapController? _mapController;
  ImagePicker picker = ImagePicker();
  File? selectedimage = null;
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('Tapped Location'),
        position: latLng,
      ));
    });
  }

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
    });
  }

  MapType _mapType = MapType.satellite;

  void _toggleMapType() {
    setState(() {
      _isSatellite = !_isSatellite;
    });
    setState(() {
      _mapType = _isSatellite ? MapType.satellite : MapType.normal;
    });
  }

  Color secondary1 = Color(0xff808080); // Initial color for the first InkWell
  Color secondary2 = Color(0xff808080);
  Color secondary3 = Color(0xff808080);
  Color secondary4 = Color(0xff808080);
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation().then((_) {
      // setState(() async {
      //   _markers.add(Marker(
      //     markerId: MarkerId((shoallmarkermodal?.id).toString()),
      //     // icon: await BitmapDescriptor.fromAssetImage(
      //     //   ImageConfiguration(
      //     //       devicePixelRatio: 2.5, size: Size(1000.sp, 1000.sp)),
      //     //   'assets/morning.png',
      //     // ),
      //     position: LatLng(
      //       double.parse(shoallmarkermodal?.latitude ?? '0'), // Parsing latitude as double
      //       double.parse(shoallmarkermodal?.longitude ?? '0'), // Parsing longitude as double
      //     ),
      //   ));
      //
      // });
    });
    print("livelocation:-${_currentPosition1}");
    showmarker();
  }

  Widget build(BuildContext context) {
    return  commanScreen(
      isLoading: isLoading,
      scaffold:Scaffold(
      extendBody: true,
      bottomNavigationBar: Bottombar(select_tab: 2),
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body: isLoading
    ? Container()
        : Stack(
        children: [
          CustomGoogleMapMarkerBuilder(
            //screenshotDelay: const Duration(seconds: 4),
            customMarkers: _customMarkers,
            builder: (BuildContext context, Set<Marker>? markers) {
              if (markers == null) {
                return const Center(child: CircularProgressIndicator());
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

                // initialCameraPosition: _currentPosition != null
                //     ? CameraPosition(
                //   target: LatLng(
                //     _currentPosition!.latitude,
                //     _currentPosition!.longitude,
                //   ),
                //   zoom: 12.0,
                // )
                //     : CameraPosition(
                //   target: LatLng(0, 0),
                //   zoom: 1.0,
                // ),
                // onMapCreated: (GoogleMapController controller) {
                //   setState(() {
                //     mapController = controller;
                //   });
                // },
                mapToolbarEnabled: true,
                mapType: MapType.normal,
                markers: markers,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,

                compassEnabled: true,
              );
            },
          ),
          // GoogleMap(
          //   onMapCreated: _onMapCreated,
          //   initialCameraPosition: CameraPosition(
          //     target: _currentPosition1,
          //     // You can set your initial position here
          //     zoom: 12.0,
          //   ),
          //   mapType: _isSatellite ? MapType.satellite : MapType.normal,
          //   markers: _markers,
          //   myLocationButtonEnabled: false,
          //   myLocationEnabled: true,
          //   zoomControlsEnabled: true,
          //   compassEnabled: true,
          // ),
          Positioned(
            top: 4.h,
            left: 10,
            right: 10,
            child: SizedBox(
              width: 85.w,
              child: header(
                  text: "Home",
                  callback1: () {
                    _scaffoldKeyProductlistpage.currentState?.openDrawer();
                  }),
            ),
          ),
          Positioned(
            top: 10.h,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: inputDecoration(
                        hintText: "Search....",
                        icon: Icon(
                          Icons.search,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackback),
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white, size: 20.sp),
                    onPressed: _searchAndNavigate,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20.h,
            left: 55.w,
            child: PopupMenuButton(
                color: bgcolor,
                elevation: 00,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: secondary),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    alignment: Alignment.center,
                    width: 40.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: blackback),
                    child: Text(
                      "+ Add Position",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Volkan"),
                    )),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () {
                        showratingpop();
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: blackback,
                            ),
                            child: Image.asset(
                              "assets/lagan.png",
                              height: 25.w,
                              width: 25.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Anchorage',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Volkan"),
                          ),
                        ],
                      ),
                      value: 'Anchorage',
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      onTap: () {
                        showratingpop();
                      },
                      child: Row(
                        children: [
                          Container(
                              width: 8.w,
                              height: 8.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: blackback,
                              ),
                              child: Icon(
                                Icons.warning_amber_outlined,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Warning',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Volkan"),
                          ),
                        ],
                      ),
                      value: 'Warning',
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      onTap: () {
                        showratingpop();
                      },
                      child: Row(
                        children: [
                          Container(
                              width: 8.w,
                              height: 8.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: blackback,
                              ),
                              child: Icon(
                                Icons.devices_other_sharp,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Other',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Volkan"),
                          ),
                        ],
                      ),
                      value: 'Warning',
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      onTap: () {
                        showratingpop();
                      },
                      child: Row(
                        children: [
                          Container(
                              width: 8.w,
                              height: 8.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: blackback,
                              ),
                              child: Icon(Icons.directions_boat,
                                  color: Colors.white)),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Marina',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Volkan"),
                          ),
                        ],
                      ),
                      value: 'Warning',
                    ),
                  ];
                },
                onSelected: (value) {
                  print('Selected: $value');
                }),
          ),
          Positioned(
            bottom: 250,
            right: 20,
            child: InkWell(
              onTap: () {
                legend();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: blackback,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.fmd_good,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text("Legend",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: blackback,
              onPressed: () {
                _focusOnLiveLocation();
              },
              child: Icon(Icons.my_location, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 110,
            right: 20,
            child: FloatingActionButton(
              onPressed: _toggleMapType,
              backgroundColor: blackback,
              child: Icon(_isSatellite ? Icons.map_outlined : Icons.map,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }

  void _focusOnLiveLocation() {
    if (_currentPosition1 != null && mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition1,
          zoom: 10.0,
        ),
      ));
    }
  }

  showratingpop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // backgroundColor: Colors.transparent,
            child: Form(
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    // height:  MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bgcolor,
                    ),
                    child: Column(children: [
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
                                borderRadius: BorderRadius.circular(100),
                                color: blackback),
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 17.sp,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black54,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8.w,
                                  height: 1.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.grey,
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text("Position Name:- ",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken")),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            width: 85.w,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: secondary),
                              controller: _positionname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Position Name";
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                hintText: "Enter Your Position Name",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          batan(
                              title: "Save Next",
                              route: () {
                                Get.back();
                                addmarker();
                              },
                              hight: 6.h,
                              width: 40.w,
                              txtsize: 15.sp),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ]),
                  ),
                ]),
              ),
            ));
      },
    );
  }

  addmarker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // backgroundColor: Colors.transparent,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      // height:  MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: bgcolor,
                      ),
                      child: Column(children: [
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
                                  borderRadius: BorderRadius.circular(100),
                                  color: blackback),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 17.sp,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black54,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20.w,
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.grey,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  secondary1 =
                                      blackback; // Change to any color you desire
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: secondary1, width: 1.sp)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15.w,
                                      width: 15.w,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 1.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTAaMkDgX6jts8zrbrgdKCKcvv1Ej797yziRZa8zanKbmTlYUA4",
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(Default_Profile),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Use Your Own Anchor(s)",
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
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  secondary2 =
                                      blackback; // Change to any color you desire
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: secondary2, width: 1.sp)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15.w,
                                      width: 15.w,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 1.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRaBKeK6wNXC0miPo0xPySQB7KlfFschpuEE36RHM9mVUTwSxb0",
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(Default_Profile),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Fixed Buoys are Available",
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
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  secondary3 =
                                      blackback; // Change to any color you desire
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: secondary3, width: 1.sp)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15.w,
                                      width: 15.w,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 1.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRsuOEAeqfLBWmOiHFKl3b7qNF1kbRZSkNNiIuTI1la2P_1Ckgu",
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(Default_Profile),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        "Fixed Mountain Wedges available",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: secondary,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "volken",
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  secondary4 =
                                      blackback; // Change to any color you desire
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: secondary4, width: 1.sp)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15.w,
                                      width: 15.w,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 1.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQT2drB7N17HmLqx4UzFHxuXWnQ8O2KRxoRx3Wp2vnDMNEcbCyf",
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(Default_Profile),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Use Your Own Lines Ashore",
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            batan(
                                title: "Save Next",
                                route: () {
                                  Get.back();
                                  addmapadd();
                                },
                                hight: 6.h,
                                width: 40.w,
                                txtsize: 15.sp),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ]),
                    ),
                  ]),
                ),
              ));
        });
      },
    );
  }

  addmapadd() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // backgroundColor: Colors.transparent,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      // height:  MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(children: [
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
                                  borderRadius: BorderRadius.circular(100),
                                  color: blackback),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 17.sp,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black54,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35.w,
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.grey,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVM_V8qDAZB0zcdTh_ab6TVb4_7xMvEXtSNYO7m7PGX2kdPNo5",
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
                                            Text(
                                              "Sand",
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSe0dP7c4doZOnbn5eWQCdiv1hn2cg4visMGff3p7T46c5_HEB0",
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
                                            Text(
                                              "Mud",
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQcTjDNEoMZGc-8fD9iEjGO-_TFILg0FNmsGV8BiL2WWLkmHxbr",
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
                                            Text(
                                              "Clay",
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
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcS9uACGi1F5UMGPlL_1Crtjf3E0joc_PXvwaB_5UTO3tdZzTbTa",
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
                                            Text(
                                              "Coral",
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  width: 5.5.w,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRV6ZHxdZ3zrFnId6sOl1xhuovMAQvC0IV6IHc3BSGO-SPRHglK",
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
                                            Text(
                                              "Rocks",
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            batan(
                                title: "Save Next",
                                route: () {
                                  Get.back();
                                  nearbuy();
                                },
                                hight: 6.h,
                                width: 40.w,
                                txtsize: 15.sp),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ]),
                    ),
                  ]),
                ),
              ));
        });
      },
    );
  }

  nearbuy() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // backgroundColor: Colors.transparent,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      // height:  MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(children: [
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
                                  borderRadius: BorderRadius.circular(100),
                                  color: blackback),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 17.sp,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black54,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45.w,
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.grey,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtRIWAWJ82MIU3sZz_G753lnqYMkP6MBq6ly1FUtoCaAW9tsUl",
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuoa863jQHob2mOU5heotg6KO4Af4JcqDcgwfZ4yzPt_DvntQA",
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ-Ny6we7GlTTn8xMrp9v4RAh6iUVUGDfKoJfeMX-Gddc6YYK3",
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
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4UP0P6tKJ1DQG4Q6DI5TferlLPkz9xiKMp0UGWvfXIxeJweQm",
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  width: 5.5.w,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          secondary1 =
                                              blackback; // Change to any color you desire
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary1,
                                                width: 1.sp)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 1.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgAT9tkJyYp2ai141ZTuPOYa1h0MpXg06Tq1y_ZeiIss-2Tg2O",
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            batan(
                                title: "Save Next",
                                route: () {
                                  Get.back();
                                  Commentpop();
                                },
                                hight: 6.h,
                                width: 40.w,
                                txtsize: 15.sp),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ]),
                    ),
                  ]),
                ),
              ));
        });
      },
    );
  }

  Commentpop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // backgroundColor: Colors.transparent,
            child: Form(
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    // height:  MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bgcolor,
                    ),
                    child: Column(children: [
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
                                borderRadius: BorderRadius.circular(100),
                                color: blackback),
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 17.sp,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black54,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 55.w,
                                  height: 1.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.grey,
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text("Comments :- ",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken")),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            width: 85.w,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: secondary),
                              controller: _comments,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Comments";
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                hintText: "Enter Your Comments",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          batan(
                              title: "Save Next",
                              route: () {
                                Get.back();
                                imagepop();
                              },
                              hight: 6.h,
                              width: 40.w,
                              txtsize: 15.sp),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ]),
                  ),
                ]),
              ),
            ));
      },
    );
  }

  imagepop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // backgroundColor: Colors.transparent,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      // height:  MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: bgcolor,
                      ),
                      child: Column(children: [
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
                                  borderRadius: BorderRadius.circular(100),
                                  color: blackback),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 17.sp,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black54,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80.w,
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.grey,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text("Upload Pictures :- ",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                            SizedBox(
                              height: 1.h,
                            ),
                            selectedimage == null
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        height: 30.w,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: bgcolor, // Border color
                                            width: 2.sp, // Border width
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: selectedimage != null
                                              ? Image.file(
                                                  selectedimage!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                    ],
                                  ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1.sp, color: secondary),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final XFile? photo =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          setState(() {
                                            selectedimage = File(photo!.path);
                                            print(selectedimage);
                                          });
                                        },
                                        child: Container(
                                          width: 18.w,
                                          height: 18.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.black),
                                          child: Icon(
                                            Icons.browse_gallery_rounded,
                                            size: 20.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text("Gallery",
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: blackback,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "volken"))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final XFile? photo =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);
                                          setState(() {
                                            selectedimage = File(photo!.path);
                                            print(selectedimage);
                                          });
                                        },
                                        child: Container(
                                          width: 18.w,
                                          height: 18.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.black),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 20.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text("Camera",
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: blackback,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "volken"))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            batan(
                                title: "Save Next",
                                route: () {
                                  Get.back();
                                  Scessfully();
                                },
                                hight: 6.h,
                                width: 40.w,
                                txtsize: 15.sp),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ]),
                    ),
                  ]),
                ),
              ));
        });
      },
    );
  }

  Scessfully() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // backgroundColor: Colors.transparent,
            child: Form(
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    // height:  MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bgcolor,
                    ),
                    child: Column(children: [
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
                                borderRadius: BorderRadius.circular(100),
                                color: blackback),
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 17.sp,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Well Done!",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Position Successfully Save Nextd",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken")),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          batan(
                              title: "Save Next",
                              route: () {
                                Get.back();
                              },
                              hight: 6.h,
                              width: 40.w,
                              txtsize: 15.sp),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ]),
                  ),
                ]),
              ),
            ));
      },
    );
  }

  legend() {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                  child: Column(children: [
                    SizedBox(height: 3.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Anchorages",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/mooring-green.png",
                              height: 15.w,
                              width: 15.w,

                            ),
                            Text("Recommended",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/mooring-yellow.png",
                              height: 15.w,
                              width: 15.w,


                            ),
                            Text("Average",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),

                        Column(
                          children: [
                            Image.asset(
                              "assets/mooring-red.png",
                              height: 15.w,
                              width:15.w,


                            ),
                            Text("To Avoid",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Divider(color: secondary),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Marinas",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/mooringbuoygreen.png",
                              height: 15.w,
                              width: 15.w,

                            ),
                            Text("Recommended",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/mooring-buoy-yellow.png",
                              height: 15.w,
                              width: 15.w,


                            ),
                            Text("Average",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),

                        Column(
                          children: [
                            Image.asset(
                              "assets/mooring-buoy-red.png",
                              height: 15.w,
                              width:15.w,


                            ),
                            Text("To Avoid",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Divider(color: secondary,),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Other",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/othergreen.png",
                              height: 15.w,
                              width: 15.w,

                            ),
                            Text("Recommended",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/otheryellow.png",
                              height: 15.w,
                              width: 15.w,


                            ),
                            Text("Average",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),

                        Column(
                          children: [
                            Image.asset(
                              "assets/yellowred.png",
                              height: 15.w,
                              width:15.w,


                            ),
                            Text("To Avoid",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    SizedBox(height: 1.h,),
                    Divider(color: secondary,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Warning",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/mooringbuoygreen.png",
                              height: 15.w,
                              width: 15.w,

                            ),
                            Text("Recommended",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/mooring-buoy-yellow.png",
                              height: 15.w,
                              width: 15.w,


                            ),
                            Text("Average",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),

                        Column(
                          children: [
                            Image.asset(
                              "assets/mooring-buoy-red.png",
                              height: 15.w,
                              width:15.w,


                            ),
                            Text("To Avoid",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h,),

                  ]),
                ),
              ));
        });
      },
    );
  }
  showmarker() {
    print("dtadone");
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().showmarker().then((response) async {
          shoallmarkermodal = ShoAllMarkerModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200) {
            print("api calling done");
            for (int index = 0; index < (shoallmarkermodal?.positions?.length ?? 0); index++) {
              print("allMarkerLength${shoallmarkermodal?.positions?.length ?? 0}");
              var latitudeString = shoallmarkermodal?.positions?[index].geometry?.coordinates?[0]?.toString();
              var longitudeString = shoallmarkermodal?.positions?[index].geometry?.coordinates?[1]?.toString();

              if (latitudeString != null && longitudeString != null) {
                try {
                  double latitude = double.parse(latitudeString);
                  double longitude = double.parse(longitudeString);
                  setState(() {
                    _customMarkers.add(
                      MarkerData(
                        marker: Marker(
                          onTap: () {
                            print("jdkc");
                            setState(() {
                              select = index;
                            });

                            // alert();

                          },
                          markerId:
                          MarkerId('id-$index'), // Use a unique identifier
                          position: LatLng(latitude, longitude),
                           // Use the correct position
                        ),
                        child: shoallmarkermodal?.positions?[index].properties?.imgURL==null||shoallmarkermodal?.positions?[index].properties?.imgURL==""?Icon(Icons.location_on,color: Colors.green,size: 15.sp,):Image.network((shoallmarkermodal?.positions?[index].properties?.imgURL)
                            .toString(),width: 50.w,height: 50.w),
                      
                      ),

                    );
                  });

                  // _markers.add(Marker(
                  //   markerId: MarkerId((shoallmarkermodal?.positions?[index].properties?.postId).toString()),
                  //   position: LatLng(latitude, longitude),
                  //
                  // ));
                } catch (e) {
                  print("Error parsing coordinates: $e");
                }
              } else {
                print("Latitude or longitude is null");
              }
            }



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
  // alert() {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         insetPadding: EdgeInsets.all(15),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         backgroundColor: Colors.black.withOpacity(0.4),
  //         child: GestureDetector(
  //           onTap: () {
  //             // Get.to(Tenth(
  //             //   id: mapexplorationmodal?.data?[select!].ideaId,
  //             // ));
  //           },
  //           child: Container(
  //             width: MediaQuery.of(context).size.width,
  //             padding: EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //               color: Colors.black.withOpacity(0.4),
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 SizedBox(
  //                   height: 3.h,
  //                 ),
  //                 InkWell(onTap: (){
  //                   // Get.to(Tenth(
  //                   //   id: mapexplorationmodal?.data?[select!].ideaId,
  //                   // ));
  //                 },
  //                   child: Text(
  //                     mapexplorationmodal?.data?[select!].eventTitle == "" ||
  //                         mapexplorationmodal?.data?[select!].eventTitle ==
  //                             null
  //                         ? "N/A"
  //                         : (mapexplorationmodal?.data?[select!].eventTitle)
  //                         .toString(),
  //                     style: TextStyle(
  //                       fontFamily: "simsan",
  //                       color: Colors.white,
  //                       fontSize: 18.sp,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Text(
  //                   "已体验：" +
  //                       (mapexplorationmodal?.data?[select!].noOfExperienced)
  //                           .toString() +
  //                       "| 已收藏：" +
  //                       (mapexplorationmodal?.data?[select!].noOfCollected)
  //                           .toString(),
  //                   style: TextStyle(
  //                     fontFamily: "simsan",
  //                     color: Colors.white,
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.normal,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Container(
  //                             height: 30.0,
  //                             width: 30.0,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: Colors.white,
  //                             ),
  //                             child: Icon(
  //                               Icons.currency_yen,
  //                               color: Colors.black,
  //                             )),
  //                         SizedBox(
  //                           width: 3.h,
  //                         ),
  //                         Text(
  //                           mapexplorationmodal?.data?[select!].eventFees ==
  //                               null ||
  //                               mapexplorationmodal
  //                                   ?.data?[select!].eventFees ==
  //                                   ""
  //                               ? "N/A"
  //                               : (mapexplorationmodal
  //                               ?.data?[select!].eventFees)
  //                               .toString(),
  //                           style: TextStyle(
  //                             fontFamily: "simsan",
  //                             color: Colors.white,
  //                             fontSize: 14.sp,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     // Row(
  //                     //   crossAxisAlignment: CrossAxisAlignment.start,
  //                     //   children: [
  //                     //     InkWell(
  //                     //       onTap: (){
  //                     //         Navigator.of(context).pop();
  //                     //         print("1111111111111111111111111111111");
  //                     //         alert1();
  //                     //       },
  //                     //       child:Icon(
  //                     //         Icons.check_circle_outline,
  //                     //         color: Colors.grey,
  //                     //       )
  //                     //     ),
  //                     //     SizedBox(
  //                     //       width: 3.h,
  //                     //     ),
  //                     //     Text(
  //                     //       "已休验",
  //                     //       style: TextStyle(
  //                     //         fontFamily: "simsan",
  //                     //         color: Color(0xffbA8A8A8),
  //                     //         fontSize: 14.sp,
  //                     //         fontWeight: FontWeight.normal,
  //                     //       ),
  //                     //     ),
  //                     //     SizedBox(
  //                     //       width: 10.h,
  //                     //     ),
  //                     //     InkWell(
  //                     //       onTap: (){
  //                     //         Navigator.of(context).pop();
  //                     //         print("22222222222222222222222222222222");
  //                     //         alert2();
  //                     //       },
  //                     //       child:Icon(
  //                     //         Icons.favorite,
  //                     //         color: Colors.red.shade900,
  //                     //       ),
  //                     //     ),
  //                     //     SizedBox(
  //                     //       width: 3.h,
  //                     //     ),
  //                     //     Text(
  //                     //       "收藏",
  //                     //       style: TextStyle(
  //                     //         fontFamily: "simsan",
  //                     //         color: Color(0xffbA8A8A8),
  //                     //         fontSize: 14.sp,
  //                     //         fontWeight: FontWeight.normal,
  //                     //       ),
  //                     //     ),
  //                     //   ],
  //                     // ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //
  //                             setState(
  //                                     () {
  //
  //                                   sel =
  //                                       select;
  //                                 });
  //                             Navigator.of(context).pop();
  //                             // print("1111111111111");
  //                             // alert1();
  //                           },
  //                           child: (mapexplorationmodal?.data?[select!].buttonExperience.toString() ==
  //                               "1")
  //                               ? GestureDetector(
  //                             onTap:
  //                                 () {
  //                               mapexplorationmodal?.data?[select!].ideaId.toString();
  //                             },
  //                             child:
  //                             Icon(
  //                               Icons.check_circle_rounded,
  //                               color: Color(0xffbEBEAEA),
  //
  //                             ),
  //                           )
  //                               : GestureDetector(
  //                             onTap:
  //                                 () {
  //                               experincebuttonap(mapexplorationmodal?.data?[select!].ideaId.toString());
  //                             },
  //                             child:
  //                             Icon(
  //                               Icons.check_circle_outline,
  //                               color: Color(0xffb777777),
  //
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 5.w,
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             setState(
  //                                     () {
  //                                   sel =
  //                                       select;
  //                                 });
  //                             experincebuttonap(mapexplorationmodal?.data?[select!].ideaId.toString());
  //                           },
  //                           child: Text(
  //                             "已体验",
  //                             style:
  //                             TextStyle(
  //                               color: Color(
  //                                   0xffbA8A8A8),
  //                               fontSize: 14.sp,
  //
  //                               fontFamily:
  //                               "simsan",
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 5.w,
  //                         ),
  //                         GestureDetector(
  //                             onTap:
  //                                 () async{
  //                               setState(
  //                                       () {
  //                                     COLLSEL =
  //                                         select;
  //                                   });
  //                               // Navigator.of(context).pop();
  //                               // print("222222222");
  //                               // alert2();
  //                             },
  //                             child: mapexplorationmodal?.data?[select!].buttonCollected ==
  //                                 "1"
  //                                 ? GestureDetector(
  //                               onTap: () {
  //                                 collectedbuttonap(mapexplorationmodal?.data?[select!].ideaId);
  //                               },
  //                               child: Icon(
  //                                 Icons.favorite,
  //                                 color: Color(0xffbD05454),
  //
  //                               ),
  //                             )
  //                                 : GestureDetector(
  //                               onTap: () {
  //                                 collectedbuttonap(mapexplorationmodal?.data?[select!].ideaId);
  //                               },
  //                               child: Icon(
  //                                 Icons.favorite_border,
  //                                 color: Color(0xffb777777),
  //
  //                               ),
  //                             )),
  //                         SizedBox(
  //                           width: 5.w,
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             setState(
  //                                     () {
  //                                   COLLSEL =
  //                                       select;
  //                                 });
  //                             collectedbuttonap(mapexplorationmodal?.data?[select!].ideaId);
  //                           },
  //                           child: Text(
  //                             "收藏",
  //                             style:
  //                             TextStyle(
  //                               color: Color(
  //                                   0xffbA8A8A8),
  //                               fontSize: 14.sp,
  //
  //                               fontFamily:
  //                               "simsan",
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Container(
  //                       // height: 30.0,
  //                       // width: 30.0,
  //                         decoration: BoxDecoration(
  //                           shape: BoxShape.circle,
  //                         ),
  //                         child: Icon(
  //                           Icons.watch_later,
  //                           color: Colors.white,
  //                         )),
  //                     SizedBox(
  //                       width: 3.h,
  //                     ),
  //                     Text(
  //                       "开始时间",
  //                       style: TextStyle(
  //                         fontFamily: "simsan",
  //                         color: Colors.white,
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Text(
  //                   mapexplorationmodal?.data?[select!].eventStartDate ==
  //                       null ||
  //                       mapexplorationmodal
  //                           ?.data?[select!].eventStartDate ==
  //                           ""
  //                       ? "N/A"
  //                       : (mapexplorationmodal?.data?[select!].eventStartDate)
  //                       .toString() +
  //                       (mapexplorationmodal?.data?[select!].eventStartTime)
  //                           .toString(),
  //                   style: TextStyle(
  //                     fontFamily: "simsan",
  //                     color: Colors.white,
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.normal,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Container(
  //                         height: 30.0,
  //                         width: 30.0,
  //                         child: Icon(
  //                           Icons.watch_later_outlined,
  //                           color: Colors.white,
  //                         )),
  //                     Text(
  //                       "体验时长",
  //                       style: TextStyle(
  //                         fontFamily: "simsan",
  //                         color: Colors.white,
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Text(
  //                   "15分钟",
  //                   style: TextStyle(
  //                     fontFamily: "simsan",
  //                     color: Colors.white,
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.normal,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Container(
  //                         height: 30.0,
  //                         width: 30.0,
  //                         child: Icon(
  //                           Icons.location_on,
  //                           color: Colors.white,
  //                         )),
  //                     Text(
  //                       "体验地点",
  //                       style: TextStyle(
  //                         fontFamily: "simsan",
  //                         color: Colors.white,
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 // Text(
  //                 //   "中国 陕西西安 桃园南路21号公园天下小",
  //                 //   style: TextStyle(
  //                 //     fontFamily: "simsan",
  //                 //       color: Colors.white,
  //                 //       fontSize: 14.sp,
  //                 //       fontWeight: FontWeight.bold,
  //                 //       ),
  //                 // ),
  //                 Text(
  //                   mapexplorationmodal?.data?[select!].address == null ||
  //                       mapexplorationmodal?.data?[select!].address == ""
  //                       ? "N/A"
  //                       : (mapexplorationmodal?.data?[select!].address)
  //                       .toString() +
  //                       " | " +
  //                       (mapexplorationmodal?.data?[select!]
  //                           .distanceToCurrentPlace ==
  //                           null ||
  //                           mapexplorationmodal?.data?[select!]
  //                               .distanceToCurrentPlace ==
  //                               ""
  //                           ? "N/A"
  //                           : (mapexplorationmodal?.data?[select!].distanceToCurrentPlace)
  //                           .toString()),
  //                   style: TextStyle(
  //                     fontFamily: "simsan",
  //                     color: Colors.white,
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

}
