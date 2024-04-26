import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/bottombar.dart';
import 'package:mapposition/LoginSinupScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Achorage/AddAchoragePositionScreen.dart';
import '../Achorage/AddOtherPositionScreen.dart';
import '../Achorage/AddWarningScreen.dart';
import '../Detail/CategorywiseViewScreen.dart';
import '../Detail/DetailsOtherScreen.dart';
import '../Detail/DetailsScreen.dart';
import '../Detail/OtherWarningDetailsScreen.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Marina/AddMarinaScreen.dart';
import '../Modal/ShoAllMarkerModal.dart';
import '../Payments/PaymentsScreen.dart';
import '../PrimiumPayments/positionController.dart';
import '../Provider/Authprovider.dart';
import 'package:intl/intl.dart';

String? storedPlanEndDate;
String? time;
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final PositionController positionController = Get.put(PositionController());
  TextEditingController _name = TextEditingController();
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
  late LatLng _currentPosition1 = LatLng(21.1702, 72.8311);
  bool _isSatellite = false;
  GoogleMapController? _mapController;
  ImagePicker picker = ImagePicker();
  File? selectedimage = null;
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();
  List<String> _imagePaths = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  castommarker() async {
    await showmarker();
  }

  // void _onMapTapped(LatLng latLng) {
  //   setState(() {
  //     _markers.clear();
  //     _markers.add(Marker(
  //       markerId: MarkerId('Tapped Location'),
  //       position: latLng,
  //     ));
  //   });  // }

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
  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    DateTime desiredDate = DateTime(now.year, now.month, now.day,now.hour,now.minute);
    return DateFormat('yyyy-MM-dd HH:mm').format(desiredDate);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedPlanEndDate= prefs.getString('stripeSuccess');
      time = getCurrentDateTime();
      print("ViyojaBHai${storedPlanEndDate}");
      print("Time Avi gayo:-${time}");
      print("Date Avi gayo:-${storedPlanEndDate}");
    });
    await  storedPlanEndDate != time ? showmarker11():showmarker();
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

  double? lat1, lng1;
  Color secondary1 = Color(0xff808080); // Initial color for the first InkWell
  Color secondary2 = Color(0xff808080);
  Color secondary3 = Color(0xff808080);
  Color secondary4 = Color(0xff808080);
  bool anchor = false;
  bool buoys = false;
  bool mountain = false;
  bool ownlines = false;
  bool sand = false;
  bool coral = false;
  bool rocks = false;
  bool clay = false;
  bool pano = false;
  bool groceries = false;
  bool pharmacy = false;
  bool alcohol = false;
  bool restaurant = false;
  bool water = false;
  bool N1 = false;
  bool N2 = false;
  bool N3 = false;
  bool NE1 = false;
  bool NE2 = false;
  bool NE3 = false;
  bool E1 = false;
  bool E2 = false;
  bool E3 = false;
  bool SE1 = false;
  bool SE2 = false;
  bool SE3 = false;
  bool S1 = false;
  bool S2 = false;
  bool S3 = false;
  bool SW1 = false;
  bool SW2 = false;
  bool SW3 = false;
  bool W1 = false;
  bool W2 = false;
  bool W3 = false;
  bool NW1 = false;
  bool NW2 = false;
  bool NW3 = false;
  bool isLoading = true;
  bool _isConnected = false;

  Timer? _timer;

  Future<void> getStoredPlanEndDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedPlanEndDate = prefs.getString('stripeSuccess');
      print("it is plan end date $storedPlanEndDate");
    });
  }


  @override
  void initState() {

    // TODO: implement initState
    getLocation();
    positionController?.filteredProducts;
    positionController?.fetchPositionData();
    getStoredPlanEndDate();
    print("paymentsdate${storedPlanEndDate}");
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      stripepay();
    });
    super.initState();
    print("livelocation:-${_currentPosition1}");
    print("offlineimagestore:-${_currentPosition1}");
    _checkInternet();
  }

  void stripepay(){
    setState(() {
      storedPlanEndDate== time? buildErrorDialog(context, '', "Your Premium expired"):null;
    });
  }
  Widget build(BuildContext context) {
    return commanScreen(
        isLoading: isLoading,
        scaffold: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          bottomNavigationBar:
          loginmodal?.userId == "" || loginmodal?.userId == null
              ? Container()
              : isLoading
              ? Container()
              : Bottombar(select_tab: 2),
          key: _scaffoldKeyProductlistpage,
          drawer: drawer1(),
          body: isLoading
              ? Container()
              : Stack(
            children: [
              Obx(() {
                if (positionController.isLoading.value) {
                  return CustomGoogleMapMarkerBuilder(
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
                  );
                } else {
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
              }),
              Positioned(
                top: 4.h,
                left: 10,
                right: 10,
                child: SizedBox(
                  width: 85.w,
                  child: header(
                      text: "Home",
                      callback1: () {
                        _scaffoldKeyProductlistpage.currentState
                            ?.openDrawer();
                      }),
                ),
              ),
              _isConnected?Positioned(
                top: 10.h,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            showmarker();
                          }
                        },
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
                        icon: Icon(Icons.search,
                            color: Colors.white, size: 20.sp),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          showmarker();
                        },
                      ),
                    ),
                  ],
                ),
              ):

              Positioned(
                top: 10.h,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged:    positionController.updateSearchQuery,
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
                        icon: Icon(Icons.search,
                            color: Colors.white, size: 20.sp),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          positionController.fetchPositionData();
                          positionController.printSearchResults();

                          offlineserach();

                        },
                      ),
                    ),
                  ],
                ),
              ),
              _isConnected ?Positioned(
                top: 20.h,
                left: 55.w,
                child: loginmodal?.userId == "" ||
                    loginmodal?.userId == null
                    ? batan(
                    title: "+ Add Position",
                    route: () {
                      buildErrorDialog1(
                        context,
                        "",
                        "Please Login To Use This",
                        buttonname: 'Login',
                            () {
                          Get.offAll(LoginScreen());
                        },
                      );
                    },
                    hight: 5.h,
                    width: 40.w,
                    txtsize: 12.sp)
                    : PopupMenuButton(
                    color: bgcolor,
                    elevation: 00,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: secondary),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        alignment: Alignment.center,
                        width: 40.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
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
                            Get.offAll(AddAchoragePositionScreen(
                              lat: lat1.toString(),
                              lng: lng1.toString(),
                            ));
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(100),
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
                            Get.offAll(AddWarningScreen(
                                lat: lat1.toString(),
                                lng: lng1.toString()));
                          },
                          child: Row(
                            children: [
                              Container(
                                  width: 8.w,
                                  height: 8.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(100),
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
                            Get.offAll(AddOtherPositionScreen(
                              lat: lat1.toString(),
                              lng: lng1.toString(),
                            ));
                          },
                          child: Row(
                            children: [
                              Container(
                                  width: 8.w,
                                  height: 8.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(100),
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
                            Get.offAll(AddMarinaScreen(
                              lat: lat1.toString(),
                              lng: lng1.toString(),
                            ));
                          },
                          child: Row(
                            children: [
                              Container(
                                  width: 8.w,
                                  height: 8.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(100),
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
              ): Container() ,
              Positioned(
                bottom: 250,
                right: 20,
                child: InkWell(
                  onTap: () {
                    legend();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.h, horizontal: 5.w),
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
              _isConnected ?Positioned(
                bottom: 110,
                right: 20,
                child: FloatingActionButton(
                  onPressed: _toggleMapType,
                  backgroundColor: blackback,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isSatellite = !_isSatellite;
                      });
                      setState(() {
                        _mapType = _isSatellite
                            ? MapType.satellite
                            : MapType.normal;
                      });
                    },
                    child: Icon(
                        _isSatellite ? Icons.map_outlined : Icons.map,
                        color: Colors.white),
                  ),
                ),
              ):Container(),
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
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgcolor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 7.w,
                            width: 7.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: blackback,
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 17.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
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
                      SizedBox(height: 1.5.h),
                      Text(
                        "Position Name:- ",
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "volken",
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        height: 8.h, // Set a fixed height for TextFormField
                        width: 85.w,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: secondary),
                          controller: _name,
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
                      SizedBox(height: 3.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          batan(
                            title: "Save Next",
                            route: () {
                              // Get.back();
                              addmarker();
                            },
                            hight: 6.h,
                            width: 40.w,
                            txtsize: 15.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
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
                                anchor =
                                !anchor; // Change to any color you desire
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: anchor ? Colors.black : Colors.white,
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
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
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
                                      color: anchor ? Colors.white : secondary,
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
                                buoys =
                                !buoys; // Change to any color you desire
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: buoys ? Colors.black : Colors.white,
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
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
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
                                      color: buoys ? Colors.white : secondary,
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
                                mountain = !mountain;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mountain ? Colors.black : Colors.white,
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
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
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
                                        color:
                                        mountain ? Colors.white : secondary,
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
                                ownlines =
                                !ownlines; // Change to any color you desire
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ownlines ? Colors.black : Colors.white,
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
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
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
                                      color:
                                      ownlines ? Colors.white : secondary,
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
                                        sand = !sand;
                                        // Change to any color you desire
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: sand
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVM_V8qDAZB0zcdTh_ab6TVb4_7xMvEXtSNYO7m7PGX2kdPNo5",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: sand
                                                  ? Colors.white
                                                  : secondary,
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
                                        pano = !pano;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: pano
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSe0dP7c4doZOnbn5eWQCdiv1hn2cg4visMGff3p7T46c5_HEB0",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: pano
                                                  ? Colors.white
                                                  : secondary,
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
                                        clay =
                                        !clay; // Change to any color you desire
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: clay
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQcTjDNEoMZGc-8fD9iEjGO-_TFILg0FNmsGV8BiL2WWLkmHxbr",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: clay
                                                  ? Colors.white
                                                  : secondary,
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
                                        coral = !coral;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: coral
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcS9uACGi1F5UMGPlL_1Crtjf3E0joc_PXvwaB_5UTO3tdZzTbTa",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: coral
                                                  ? Colors.white
                                                  : secondary,
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
                                        rocks = !rocks;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: rocks
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRV6ZHxdZ3zrFnId6sOl1xhuovMAQvC0IV6IHc3BSGO-SPRHglK",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: rocks
                                                  ? Colors.white
                                                  : secondary,
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
                                        groceries =
                                        !groceries; // Change to any color you desire
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: groceries
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtRIWAWJ82MIU3sZz_G753lnqYMkP6MBq6ly1FUtoCaAW9tsUl",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: groceries
                                                  ? Colors.white
                                                  : secondary,
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
                                        pharmacy =
                                        !pharmacy; // Change to any color you desire
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: pharmacy
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuoa863jQHob2mOU5heotg6KO4Af4JcqDcgwfZ4yzPt_DvntQA",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: pharmacy
                                                  ? Colors.white
                                                  : secondary,
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
                                        alcohol = !alcohol;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: alcohol
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ-Ny6we7GlTTn8xMrp9v4RAh6iUVUGDfKoJfeMX-Gddc6YYK3",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: alcohol
                                                  ? Colors.white
                                                  : secondary,
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
                                        restaurant = !restaurant;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: restaurant
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4UP0P6tKJ1DQG4Q6DI5TferlLPkz9xiKMp0UGWvfXIxeJweQm",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: restaurant
                                                  ? Colors.white
                                                  : secondary,
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
                                        water =
                                        !water; // Change to any color you desire
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: water
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: secondary1, width: 1.sp)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25.w,
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(90),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgAT9tkJyYp2ai141ZTuPOYa1h0MpXg06Tq1y_ZeiIss-2Tg2O",
                                                progressIndicatorBuilder: (context,
                                                    url, progress) =>
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
                                              color: water
                                                  ? Colors.white
                                                  : secondary,
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
                                n1n2n3();
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
              ));
        });
      },
    );
  }

  n1n2n3() {
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
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Wind Rose",
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
                      Text("North (N) : -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: N1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    N1 = value!;
                                  });
                                },
                              ),
                              Text("N1",
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
                              Checkbox(
                                value: N2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    N2 = value!;
                                  });
                                },
                              ),
                              Text("N2",
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
                              Checkbox(
                                value: N3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    N3 = value!;
                                  });
                                },
                              ),
                              Text("N3",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Northeast (NE) : -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: NE1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    NE1 = value!;
                                  });
                                },
                              ),
                              Text("NE1",
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
                              Checkbox(
                                value: NE2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    NE2 = value!;
                                  });
                                },
                              ),
                              Text("NE2",
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
                              Checkbox(
                                value: NE3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    NE3 = value!;
                                  });
                                },
                              ),
                              Text("NE3",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("East (E) : -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: E1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    E1 = value!;
                                  });
                                },
                              ),
                              Text("E1",
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
                              Checkbox(
                                value: E2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    E2 = value!;
                                  });
                                },
                              ),
                              Text("E2",
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
                              Checkbox(
                                value: E3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    E3 = value!;
                                  });
                                },
                              ),
                              Text("E3",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Southeast (SE): -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: SE1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    SE1 = value!;
                                  });
                                },
                              ),
                              Text("SE1",
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
                              Checkbox(
                                value: SE2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    SE2 = value!;
                                  });
                                },
                              ),
                              Text("SE2",
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
                              Checkbox(
                                value: SE3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    SE3 = value!;
                                  });
                                },
                              ),
                              Text("SE3",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("South (S): -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: S1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    SE1 = value!;
                                  });
                                },
                              ),
                              Text("S1",
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
                              Checkbox(
                                value: S2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    S2 = value!;
                                  });
                                },
                              ),
                              Text("S2",
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
                              Checkbox(
                                value: S3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    S3 = value!;
                                  });
                                },
                              ),
                              Text("S3",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Southwest (SW): -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: SW1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    SW1 = value!;
                                  });
                                },
                              ),
                              Text("SW1",
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
                              Checkbox(
                                value: SW2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    SW2 = value!;
                                  });
                                },
                              ),
                              Text("SW2",
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
                              Checkbox(
                                value: SW3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    SW3 = value!;
                                  });
                                },
                              ),
                              Text("SW3",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("West (W): -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: W1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    W1 = value!;
                                  });
                                },
                              ),
                              Text("W1",
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
                              Checkbox(
                                value: W2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    W2 = value!;
                                  });
                                },
                              ),
                              Text("W2",
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
                              Checkbox(
                                value: W2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    W2 = value!;
                                  });
                                },
                              ),
                              Text("W2",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Northwest (NW): -",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: NW1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    NW1 = value!;
                                  });
                                },
                              ),
                              Text("NW1",
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
                              Checkbox(
                                value: NW2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    NW2 = value!;
                                  });
                                },
                              ),
                              Text("NW2",
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
                              Checkbox(
                                value: NW3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    NW3 = value!;
                                  });
                                },
                              ),
                              Text("NW3",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
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
                                  // addanchorage();
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
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 10.w,
                            height: 10.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
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
                    SizedBox(
                      height: 2.h,
                    ),
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
                              width: 15.w,
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
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(color: secondary),
                    SizedBox(
                      height: 2.h,
                    ),
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
                    SizedBox(
                      height: 1.h,
                    ),
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
                              width: 15.w,
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
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(
                      color: secondary,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
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
                    SizedBox(
                      height: 1.h,
                    ),
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
                              width: 15.w,
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
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(
                      color: secondary,
                    ),
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
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/greenwarning.png",
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
                              "assets/yellowwarning.png",
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
                              "assets/redwarning.png",
                              height: 15.w,
                              width: 15.w,
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
                    SizedBox(
                      height: 2.h,
                    ),
                  ]),
                ),
              ));
        });
      },
    );
  }

  showmarker() {
    print("dtadone");
    print("showmarker");
    final Map<String, String> data = {};
    data['s'] = searchController.text.trim().toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        positionController?.fetchPositionData();

        authprovider().showmarkerapi(data).then((response) async {
          shoallmarkermodal =
              ShoAllMarkerModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200) {
            print(" ${shoallmarkermodal?.positions?.length}");
            print("api calling done");

            // Clear existing markers
            _customMarkers.clear();
            if (shoallmarkermodal?.positions?.length == 0) {
              buildErrorDialog1(
                context,
                '',
                "No spots listed in this area",
                    () {
                  setState(() {
                    searchController.clear();
                    isLoading = true;
                    Get.back();
                  });
                  showmarker();
                },
              );
            } else {
              for (int index = 0;
              index < (shoallmarkermodal?.positions?.length ?? 0);
              index++) {
                print("markerlength${shoallmarkermodal?.positions?.length}");
                var latitudeString = shoallmarkermodal
                    ?.positions?[index].geometry?.coordinates?[1]
                    ?.toString();
                var longitudeString = shoallmarkermodal
                    ?.positions?[index].geometry?.coordinates?[0]
                    ?.toString();

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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                        return Dialog(
                                            insetPadding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            child: SingleChildScrollView(
                                                child: Stack(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: 0.7.h),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 2.w,
                                                            vertical: 1.h),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                            border: Border.all(
                                                                color: secondary,
                                                                width: 1.sp)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 35.w,
                                                                  width: 35.w,
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        15),
                                                                    child:
                                                                    CachedNetworkImage(
                                                                      imageUrl: shoallmarkermodal
                                                                          ?.positions?[
                                                                      index]
                                                                          .properties
                                                                          ?.postImage ??
                                                                          "",
                                                                      fit: BoxFit.cover,
                                                                      progressIndicatorBuilder: (context,
                                                                          url,
                                                                          progress) =>
                                                                          Container(
                                                                              alignment:
                                                                              Alignment
                                                                                  .center,
                                                                              child: Center(
                                                                                  child:
                                                                                  CircularProgressIndicator())),
                                                                      errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                          Image.asset(
                                                                              Default_Profile),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 4.w),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height: 0.h),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 46.w,
                                                                          child: Text(
                                                                            shoallmarkermodal?.positions?[index].properties?.title ==
                                                                                null ||
                                                                                shoallmarkermodal?.positions?[index].properties?.title ==
                                                                                    ""
                                                                                ? "N/A"
                                                                                : shoallmarkermodal?.positions?[index].properties?.title ??
                                                                                "",
                                                                            maxLines: 1,
                                                                            style: TextStyle(
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                fontSize: 14
                                                                                    .sp,
                                                                                color: Colors
                                                                                    .black,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                                fontFamily:
                                                                                "volken",
                                                                                letterSpacing:
                                                                                1),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height: 0.5.h),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          'Ratings :',
                                                                          maxLines: 1,
                                                                          style:
                                                                          TextStyle(
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            fontSize:
                                                                            13.sp,
                                                                            color: Colors
                                                                                .black,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                            "volken",
                                                                            letterSpacing:
                                                                            1,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width: 2.w),
                                                                        Text(
                                                                          shoallmarkermodal?.positions?[index].properties?.onlyAvg ==
                                                                              "" ||
                                                                              shoallmarkermodal?.positions?[index].properties?.onlyAvg ==
                                                                                  null
                                                                              ? "0"
                                                                              : (shoallmarkermodal
                                                                              ?.positions?[index]
                                                                              .properties
                                                                              ?.onlyAvg)
                                                                              .toString(),
                                                                          maxLines: 1,
                                                                          style:
                                                                          TextStyle(
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            fontSize:
                                                                            13.sp,
                                                                            color:
                                                                            secondary,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                            "",
                                                                            letterSpacing:
                                                                            1,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                            0.5.w),
                                                                        Padding(
                                                                          padding: EdgeInsets
                                                                              .only(
                                                                              bottom:
                                                                              0.5.h),
                                                                          child: Text(
                                                                            '⭐️',
                                                                            maxLines: 1,
                                                                            style:
                                                                            TextStyle(
                                                                              overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                              fontSize:
                                                                              12.sp,
                                                                              color: Colors
                                                                                  .orange,
                                                                              letterSpacing:
                                                                              1,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height: 0.5.h),
                                                                    batan(
                                                                        title:
                                                                        "View Details",
                                                                        route: () {
                                                                          Get.back();
                                                                          shoallmarkermodal
                                                                              ?.positions?[
                                                                          index]
                                                                              .properties
                                                                              ?.termName ==
                                                                              "Warning"
                                                                              ? Get.to(
                                                                              DetailsWarningDetailsScreen(
                                                                                postid:
                                                                                (shoallmarkermodal?.positions?[index].properties?.postId)?.toString() ?? "",
                                                                              ))
                                                                              : shoallmarkermodal?.positions?[index].properties?.termName ==
                                                                              "Other"
                                                                              ? Get.to(
                                                                              DetailsOtherScreen(postid: ((shoallmarkermodal?.positions?[index].properties?.postId).toString())))
                                                                              : shoallmarkermodal?.positions?[index].properties?.termName == "Anchorages"
                                                                              ? Get.to(DetailsScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()))
                                                                              : Get.to(CategoryWiseViewScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()));
                                                                        },
                                                                        hight: 6.h,
                                                                        width: 40.w,
                                                                        txtsize: 15.sp)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 82.w,
                                                      top: 1.h,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          width: 10.w,
                                                          height: 10.w,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                100),
                                                            color: Colors.black,
                                                          ),
                                                          child: Icon(Icons.clear,
                                                              color: Colors.white,
                                                              size: 15.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )));
                                      });
                                },
                              );
                            },
                            markerId: MarkerId(
                                'id-${shoallmarkermodal?.positions?[index].properties?.title.toString()}'),
                            position: LatLng(latitude, longitude),
                          ),
                          child: shoallmarkermodal?.positions?[index].properties
                              ?.imgURL ==
                              null ||
                              shoallmarkermodal?.positions?[index]
                                  .properties?.imgURL ==
                                  ""
                              ? Image.asset(
                            "assets/mooring-red.png",
                          )
                              : Image.network(
                              (shoallmarkermodal?.positions?[index]
                                  .properties?.imgURL)
                                  .toString(),
                              width: 50.w,
                              height: 50.w),
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
            }

            // Update the state with new markers
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
        Get.snackbar(
          'No Internet Connection',
          'Please connect to the internet',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });
  }

  bool _isValidDouble(String value) {
    if (value == null) return false;
    final RegExp regex = RegExp(r'^-?[\d.]+$');
    return regex.hasMatch(value);
  }

  showmarker11() {
    print("dtadone");
    print("showmarker11");
    final Map<String, String> data = {};
    data['s'] = searchController.text.trim().toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        positionController?.fetchPositionData();

        authprovider().showmarkerapi(data).then((response) async {
          shoallmarkermodal =
              ShoAllMarkerModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200) {
            print("maposition${shoallmarkermodal?.positions?.length}");
            print("api calling done");

            // Clear existing markers
            _customMarkers.clear();
            if (shoallmarkermodal?.positions?.length == 0) {
              buildErrorDialog1(
                context,
                '',
                "No spots listed in this area",
                    () {
                  setState(() {
                    searchController.clear();
                    isLoading = true;
                    Get.back();
                  });
                  showmarker();
                },
              );
            } else {
              for (int index = 0;
              index < (shoallmarkermodal?.positions?.length ?? 0);
              index++) {
                print("markerlength${shoallmarkermodal?.positions?.length}");
                var latitudeString = shoallmarkermodal
                    ?.positions?[index].geometry?.coordinates?[1]
                    ?.toString();
                var longitudeString = shoallmarkermodal
                    ?.positions?[index].geometry?.coordinates?[0]
                    ?.toString();

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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                        return Dialog(
                                            insetPadding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            child: SingleChildScrollView(
                                                child: Stack(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: 0.7.h),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 2.w,
                                                            vertical: 1.h),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                            border: Border.all(
                                                                color: secondary,
                                                                width: 1.sp)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 35.w,
                                                                  width: 35.w,
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        15),
                                                                    child:
                                                                    CachedNetworkImage(
                                                                      imageUrl: shoallmarkermodal
                                                                          ?.positions?[
                                                                      index]
                                                                          .properties
                                                                          ?.postImage ??
                                                                          "",
                                                                      fit: BoxFit.cover,
                                                                      progressIndicatorBuilder: (context,
                                                                          url,
                                                                          progress) =>
                                                                          Container(
                                                                              alignment:
                                                                              Alignment
                                                                                  .center,
                                                                              child: Center(
                                                                                  child:
                                                                                  CircularProgressIndicator())),
                                                                      errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                          Image.asset(
                                                                              Default_Profile),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 4.w),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height: 0.h),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 46.w,
                                                                          child: Text(
                                                                            shoallmarkermodal?.positions?[index].properties?.title ==
                                                                                null ||
                                                                                shoallmarkermodal?.positions?[index].properties?.title ==
                                                                                    ""
                                                                                ? "N/A"
                                                                                : shoallmarkermodal?.positions?[index].properties?.title ??
                                                                                "",
                                                                            maxLines: 1,
                                                                            style: TextStyle(
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                fontSize: 14
                                                                                    .sp,
                                                                                color: Colors
                                                                                    .black,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                                fontFamily:
                                                                                "volken",
                                                                                letterSpacing:
                                                                                1),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height: 0.5.h),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          'Ratings :',
                                                                          maxLines: 1,
                                                                          style:
                                                                          TextStyle(
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            fontSize:
                                                                            13.sp,
                                                                            color: Colors
                                                                                .black,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                            "volken",
                                                                            letterSpacing:
                                                                            1,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width: 2.w),
                                                                        Text(
                                                                          shoallmarkermodal?.positions?[index].properties?.onlyAvg ==
                                                                              "" ||
                                                                              shoallmarkermodal?.positions?[index].properties?.onlyAvg ==
                                                                                  null
                                                                              ? "0"
                                                                              : (shoallmarkermodal
                                                                              ?.positions?[index]
                                                                              .properties
                                                                              ?.onlyAvg)
                                                                              .toString(),
                                                                          maxLines: 1,
                                                                          style:
                                                                          TextStyle(
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            fontSize:
                                                                            13.sp,
                                                                            color:
                                                                            secondary,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                            "",
                                                                            letterSpacing:
                                                                            1,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                            0.5.w),
                                                                        Padding(
                                                                          padding: EdgeInsets
                                                                              .only(
                                                                              bottom:
                                                                              0.5.h),
                                                                          child: Text(
                                                                            '⭐️',
                                                                            maxLines: 1,
                                                                            style:
                                                                            TextStyle(
                                                                              overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                              fontSize:
                                                                              12.sp,
                                                                              color: Colors
                                                                                  .orange,
                                                                              letterSpacing:
                                                                              1,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height: 0.5.h),
                                                                    batan(
                                                                        title:
                                                                        "View Details",
                                                                        route: () {
                                                                          Get.back();
                                                                          shoallmarkermodal
                                                                              ?.positions?[
                                                                          index]
                                                                              .properties
                                                                              ?.termName ==
                                                                              "Warning"
                                                                              ? Get.to(
                                                                              DetailsWarningDetailsScreen(
                                                                                postid:
                                                                                (shoallmarkermodal?.positions?[index].properties?.postId)?.toString() ?? "",
                                                                              ))
                                                                              : shoallmarkermodal?.positions?[index].properties?.termName ==
                                                                              "Other"
                                                                              ? Get.to(
                                                                              DetailsOtherScreen(postid: ((shoallmarkermodal?.positions?[index].properties?.postId).toString())))
                                                                              : shoallmarkermodal?.positions?[index].properties?.termName == "Anchorages"
                                                                              ? Get.to(DetailsScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()))
                                                                              : Get.to(CategoryWiseViewScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()));
                                                                        },
                                                                        hight: 6.h,
                                                                        width: 40.w,
                                                                        txtsize: 15.sp)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 82.w,
                                                      top: 1.h,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          width: 10.w,
                                                          height: 10.w,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                100),
                                                            color: Colors.black,
                                                          ),
                                                          child: Icon(Icons.clear,
                                                              color: Colors.white,
                                                              size: 15.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )));
                                      });
                                },
                              );
                            },
                            markerId: MarkerId(
                                'id-${shoallmarkermodal?.positions?[index].properties?.title.toString()}'),
                            position: LatLng(latitude, longitude),
                          ),
                          child: shoallmarkermodal?.positions?[index].properties
                              ?.imgURL ==
                              null ||
                              shoallmarkermodal?.positions?[index]
                                  .properties?.imgURL ==
                                  ""
                              ? Image.asset(
                            "assets/mooring-red.png",
                          )
                              : Image.network(
                              (shoallmarkermodal?.positions?[index]
                                  .properties?.imgURL)
                                  .toString(),
                              width: 50.w,
                              height: 50.w),
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
            }

            // Update the state with new markers
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

        // Handle offline mode
        for (int index = 0;
        index < (positionController.position?.positions.length ?? 0);
        index++) {
          print(
              "offline${positionController.position?.positions[index].geometry.coordinates[1].toString()}");
          print(
              "offlinemappositionlength${positionController.position?.positions.length}");
          var latitudeString = positionController
              .position?.positions[index].geometry.coordinates[1]
              .toString();
          var longitudeString = positionController
              .position?.positions[index].geometry.coordinates[0]
              .toString();

          if (latitudeString != null && longitudeString != null) {
            // Validate latitude and longitude strings
            if (_isValidDouble(latitudeString) &&
                _isValidDouble(longitudeString)) {
              try {
                double latitude = double.parse(latitudeString);
                double longitude = double.parse(longitudeString);
                _customMarkers.add(
                  MarkerData(
                    marker: Marker(
                      onTap: () {
                        setState(() {
                          select = index;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {

                                  return Dialog(
                                      insetPadding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      child: SingleChildScrollView(
                                          child: Stack(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width:
                                                  MediaQuery.of(context).size.width,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 0.7.h),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.w, vertical: 1.h),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      border: Border.all(
                                                          color: secondary,
                                                          width: 1.sp)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.w,
                                                            width: 35.w,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  15),
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                positionController


                                                                    ?.position
                                                                    ?.positions?[
                                                                index]
                                                                    .properties
                                                                    ?.postImage ??
                                                                    "",
                                                                fit: BoxFit.cover,
                                                                progressIndicatorBuilder: (context,
                                                                    url,
                                                                    progress) =>
                                                                    Container(
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Center(
                                                                            child:
                                                                            CircularProgressIndicator())),
                                                                errorWidget: (context,
                                                                    url, error) =>
                                                                    Image.asset(
                                                                        Default_Profile),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 4.w),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            children: [
                                                              SizedBox(height: 0.h),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 46.w,
                                                                    child: Text(
                                                                      positionController
                                                                          ?.position
                                                                          ?.positions?[
                                                                      index]
                                                                          .properties
                                                                          ?.title ==
                                                                          "" ||
                                                                          positionController
                                                                              ?.position
                                                                              ?.positions?[
                                                                          index]
                                                                              .properties
                                                                              ?.title ==
                                                                              null
                                                                          ? "N/A"
                                                                          : positionController
                                                                          ?.position
                                                                          ?.positions?[
                                                                      index]
                                                                          .properties
                                                                          ?.title ??
                                                                          "",
                                                                      maxLines: 1,
                                                                      style: TextStyle(
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontSize:
                                                                          14.sp,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                          "volken",
                                                                          letterSpacing:
                                                                          1),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 0.5.h),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    'Ratings :',
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      fontSize: 13.sp,
                                                                      color:
                                                                      Colors.black,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontFamily:
                                                                      "volken",
                                                                      letterSpacing: 1,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 2.w),
                                                                  Text(
                                                                    positionController
                                                                        ?.position
                                                                        ?.positions?[
                                                                    index]
                                                                        .properties
                                                                        ?.onlyAvg ==
                                                                        "" ||
                                                                        positionController
                                                                            ?.position
                                                                            ?.positions?[
                                                                        index]
                                                                            .properties
                                                                            ?.onlyAvg ==
                                                                            null
                                                                        ? "N/A"
                                                                        : (positionController
                                                                        ?.position
                                                                        ?.positions?[
                                                                    index]
                                                                        .properties
                                                                        ?.onlyAvg)
                                                                        .toString(),
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      fontSize: 13.sp,
                                                                      color: secondary,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontFamily: "",
                                                                      letterSpacing: 1,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 0.5.w),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.only(
                                                                        bottom:
                                                                        0.5.h),
                                                                    child: Text(
                                                                      '⭐️',
                                                                      maxLines: 1,
                                                                      style: TextStyle(
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        fontSize: 12.sp,
                                                                        color: Colors
                                                                            .orange,
                                                                        letterSpacing:
                                                                        1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // SizedBox(
                                                              //     height: 0.5.h),
                                                              // batan(
                                                              //     title:
                                                              //     "View Details",
                                                              //     route: () {
                                                              //       Get.back();
                                                              //       shoallmarkermodal
                                                              //           ?.positions?[
                                                              //       index]
                                                              //           .properties
                                                              //           ?.termName ==
                                                              //           "Warning"
                                                              //           ? Get.to(
                                                              //           DetailsWarningDetailsScreen(
                                                              //             postid:
                                                              //             (shoallmarkermodal?.positions?[index].properties?.postId)?.toString() ?? "",
                                                              //           ))
                                                              //           : shoallmarkermodal?.positions?[index].properties?.termName ==
                                                              //           "Other"
                                                              //           ? Get.to(
                                                              //           DetailsOtherScreen(postid: ((shoallmarkermodal?.positions?[index].properties?.postId).toString())))
                                                              //           : shoallmarkermodal?.positions?[index].properties?.termName == "Anchorages"
                                                              //           ? Get.to(DetailsScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()))
                                                              //           : Get.to(CategoryWiseViewScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()));
                                                              //     },
                                                              //     hight: 6.h,
                                                              //     width: 40.w,
                                                              //     txtsize: 15.sp)
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 82.w,
                                                top: 1.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    width: 10.w,
                                                    height: 10.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(100),
                                                      color: Colors.black,
                                                    ),
                                                    child: Icon(Icons.clear,
                                                        color: Colors.white,
                                                        size: 15.sp),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )));
                                });
                          },
                        );
                      },
                      markerId: MarkerId(
                          'id-${positionController.position?.positions[index].properties.postId.toString()}'),
                      position: LatLng(latitude, longitude),
                    ),
                    child: positionController?.position?.positions?[index]
                        .properties?.termName ==
                        "Anchorages"
                        ? Image.asset(
                      "assets/mooring-red.png",
                    )
                        : positionController?.position?.positions?[index]
                        .properties?.termName ==
                        "Other"
                        ? Image.asset(
                      "assets/yellowred.png",
                    )
                        : positionController?.position?.positions?[index]
                        .properties?.termName ==
                        "Warning"
                        ? Image.asset(
                      "assets/redwarning.png",
                    )
                        : Image.asset(
                      "assets/mooring-red.png",
                    ),
                  ),
                );
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

      }
    });
  }
  Future<void> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
    }
  }


  offlineserach(){
    setState(() {
      isLoading = false;
    });

    print("jayla${positionController?.filteredProducts.length}");
    for (int index = 0;
    index < (positionController?.filteredProducts.length ?? 0);
    index++) {
      print("Serachoffline${positionController?.filteredProducts.length}");
      var latitudeString = positionController
          .filteredProducts?[index].geometry?.coordinates[1].toString();
      var longitudeString =positionController
          .filteredProducts?[index].geometry?.coordinates[0].toString();

      if (latitudeString != null && longitudeString != null) {
        // Validate latitude and longitude strings
        if (_isValidDouble(latitudeString) &&
            _isValidDouble(longitudeString)) {
          try {
            double latitude = double.parse(latitudeString);
            double longitude = double.parse(longitudeString);
            print("haresh${latitudeString}");
            print("ram${longitudeString}");
            _customMarkers.add(
              MarkerData(
                marker: Marker(
                  onTap: () {
                    setState(() {
                      select = index;
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                                  insetPadding:
                                  EdgeInsets.symmetric(horizontal: 3.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  child: SingleChildScrollView(
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width:
                                              MediaQuery.of(context).size.width,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 0.7.h),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w, vertical: 1.h),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: secondary,
                                                      width: 1.sp)),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 35.w,
                                                        width: 35.w,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                          child: CachedNetworkImage(
                                                            imageUrl:
                                                            positionController
                                                                ?.position
                                                                ?.positions?[
                                                            index]
                                                                .properties
                                                                ?.postImage ??
                                                                "",
                                                            fit: BoxFit.cover,
                                                            progressIndicatorBuilder: (context,
                                                                url,
                                                                progress) =>
                                                                Container(
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    child: Center(
                                                                        child:
                                                                        CircularProgressIndicator())),
                                                            errorWidget: (context,
                                                                url, error) =>
                                                                Image.asset(
                                                                    Default_Profile),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          SizedBox(height: 0.h),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 46.w,
                                                                child: Text(
                                                                  positionController
                                                                      ?.position
                                                                      ?.positions?[
                                                                  index]
                                                                      .properties
                                                                      ?.title ==
                                                                      "" ||
                                                                      positionController
                                                                          ?.position
                                                                          ?.positions?[
                                                                      index]
                                                                          .properties
                                                                          ?.title ==
                                                                          null
                                                                      ? "N/A"
                                                                      : positionController
                                                                      ?.position
                                                                      ?.positions?[
                                                                  index]
                                                                      .properties
                                                                      ?.title ??
                                                                      "",
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      fontSize:
                                                                      14.sp,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontFamily:
                                                                      "volken",
                                                                      letterSpacing:
                                                                      1),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 0.5.h),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                'Ratings :',
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: 13.sp,
                                                                  color:
                                                                  Colors.black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontFamily:
                                                                  "volken",
                                                                  letterSpacing: 1,
                                                                ),
                                                              ),
                                                              SizedBox(width: 2.w),
                                                              Text(
                                                                positionController
                                                                    ?.position
                                                                    ?.positions?[
                                                                index]
                                                                    .properties
                                                                    ?.onlyAvg ==
                                                                    "" ||
                                                                    positionController
                                                                        ?.position
                                                                        ?.positions?[
                                                                    index]
                                                                        .properties
                                                                        ?.onlyAvg ==
                                                                        null
                                                                    ? "N/A"
                                                                    : (positionController
                                                                    ?.position
                                                                    ?.positions?[
                                                                index]
                                                                    .properties
                                                                    ?.onlyAvg)
                                                                    .toString(),
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: 13.sp,
                                                                  color: secondary,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontFamily: "",
                                                                  letterSpacing: 1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 0.5.w),
                                                              Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                    0.5.h),
                                                                child: Text(
                                                                  '⭐️',
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    fontSize: 12.sp,
                                                                    color: Colors
                                                                        .orange,
                                                                    letterSpacing:
                                                                    1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // SizedBox(
                                                          //     height: 0.5.h),
                                                          // batan(
                                                          //     title:
                                                          //     "View Details",
                                                          //     route: () {
                                                          //       Get.back();
                                                          //       shoallmarkermodal
                                                          //           ?.positions?[
                                                          //       index]
                                                          //           .properties
                                                          //           ?.termName ==
                                                          //           "Warning"
                                                          //           ? Get.to(
                                                          //           DetailsWarningDetailsScreen(
                                                          //             postid:
                                                          //             (shoallmarkermodal?.positions?[index].properties?.postId)?.toString() ?? "",
                                                          //           ))
                                                          //           : shoallmarkermodal?.positions?[index].properties?.termName ==
                                                          //           "Other"
                                                          //           ? Get.to(
                                                          //           DetailsOtherScreen(postid: ((shoallmarkermodal?.positions?[index].properties?.postId).toString())))
                                                          //           : shoallmarkermodal?.positions?[index].properties?.termName == "Anchorages"
                                                          //           ? Get.to(DetailsScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()))
                                                          //           : Get.to(CategoryWiseViewScreen(postid: (shoallmarkermodal?.positions?[index].properties?.postId).toString()));
                                                          //     },
                                                          //     hight: 6.h,
                                                          //     width: 40.w,
                                                          //     txtsize: 15.sp)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 82.w,
                                            top: 1.h,
                                            child: InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                width: 10.w,
                                                height: 10.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                  color: Colors.black,
                                                ),
                                                child: Icon(Icons.clear,
                                                    color: Colors.white,
                                                    size: 15.sp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )));
                            });
                      },
                    );
                  },
                  markerId: MarkerId(
                      'id-${positionController
                          .filteredProducts?[index].properties.postId.toString() }'),
                  position: LatLng(latitude, longitude),
                ),
                child: positionController
                    .filteredProducts?[index].properties.termName ==
                    "Anchorages"
                    ? Image.asset(
                  "assets/mooring-red.png",
                )
                    : positionController
                    .filteredProducts?[index].properties.termName ==
                    "Other"
                    ? Image.asset(
                  "assets/yellowred.png",
                )
                    : positionController
                    .filteredProducts?[index].properties.termName ==
                    "Warning"
                    ? Image.asset(
                  "assets/redwarning.png",
                )
                    : Image.asset(
                  "assets/mooring-red.png",
                ),
              ),
            );
            _focusOnLiveLocation();
            if (index == 0) {
              setState(() {
                _currentPosition1 = LatLng(latitude, longitude);
                  print("Denish${_currentPosition1}");
              });
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
  }
}
