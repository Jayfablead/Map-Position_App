

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/buildErrorDialog.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Modal/AddAlaramModal.dart';
import '../Modal/UpdateAlaramModal.dart';
import '../Provider/Authprovider.dart';
import 'UpdateAlarmScreen.dart';

class SubscriptionAlarmScreen extends StatefulWidget {
  const SubscriptionAlarmScreen({super.key});

  @override
  State<SubscriptionAlarmScreen> createState() => _SubscriptionAlarmScreenState();
}

class _SubscriptionAlarmScreenState extends State<SubscriptionAlarmScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage1 =GlobalKey<ScaffoldState>();

  double? lat1,lng1;

  TextEditingController _position =TextEditingController();

  TextEditingController _title =TextEditingController();

  LatLng _center = LatLng(21.1702, 72.8311); // Default initial position
  CameraPosition _initialCameraPosition =
  CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 10);
  Position? _currentPosition;
  int? select;
  late LatLng dynamicLatLng;
  late GoogleMapController mapController;
  late LatLng _currentPosition1 = LatLng(21.1702, 72.8311);
  bool _isSatellite = false;

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // searchController.dispose();
    super.dispose();
  }





  GoogleMapController? _mapController; // Add this line
  double? _lastLatitude;
  double? _lastLongitude;
  Set<Marker> _markers = {};
  double _calculateZoomLevel(double latitude, double longitude) {
    // Adjust this logic based on your needs
    // You can use distance from a reference point or other criteria
    double zoomLevel = 15; // Default zoom level

    // Example: Increase zoom level for closer ranges
    if (latitude != 0.0 && longitude != 0.0) {
      zoomLevel = 16; // More zoomed in
    } else {
      zoomLevel = 10; // Zoomed out
    }

    return zoomLevel;
  }
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    print('Map Controller Created');

    // Set initial camera position dynamically
    LatLng initialPosition;
    double initialZoom;

    if (newupdatealarammodal?.alarm?.lattiude != null &&
        newupdatealarammodal?.alarm?.longitude != null) {
      double latitude = double.tryParse(viewcategorywisevieweetailmodal
          ?.data?.latitude ==
          "null" ||
          viewcategorywisevieweetailmodal?.data?.latitude == "" ||
          viewcategorywisevieweetailmodal?.data?.latitude == "null" ||
          viewcategorywisevieweetailmodal?.data?.latitude == null
          ? _latitude.text
          : viewcategorywisevieweetailmodal?.data?.latitude.toString() ??
          '0.0') ??
          0.0;
      double longitude = double.tryParse(viewcategorywisevieweetailmodal
          ?.data?.longitude ==
          "null" ||
          viewcategorywisevieweetailmodal?.data?.longitude == null ||
          viewcategorywisevieweetailmodal?.data?.longitude == ""
          ? _latitude1.text
          : viewcategorywisevieweetailmodal?.data?.longitude.toString() ??
          "0.0") ??
          0.0;
      initialPosition = LatLng(latitude, longitude);

      // Dynamic zoom level logic (adjust as needed)
      initialZoom = _calculateZoomLevel(latitude, longitude);
    } else {
      initialPosition = LatLng(37.7749, -122.4194); // Default location
      initialZoom = 10; // Default zoom level
    }

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: initialPosition,
          zoom: initialZoom,
        ),
      ),
    );

    _updateMarker(); // Update marker after setting the camera position

    print('Markers: $_markers');
  }
  bool isloding =true;
  void _updateMarker() {
    if (_latitude.text.isNotEmpty && _latitude1.text.isNotEmpty) {
      double latitude = double.tryParse(_latitude.text) ?? 0.0;
      double longitude = double.tryParse(_latitude1.text) ?? 0.0;

      print('Updating marker to lat: $latitude, lng: $longitude'); // Debugging

      Marker marker = Marker(
        markerId: MarkerId('alarm_marker'), // Ensure this ID is unique
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: 'Alarm Location'),
      );

      setState(() {
        _markers.removeWhere((m) =>
        m.markerId.value ==
            'alarm_marker'); // Remove old marker if it exists
        _markers.add(marker); // Add new marker
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(latitude, longitude),
        ),
      );
    } else {
      print('No valid latitude or longitude'); // Debugging
    }
  }
  double lat = 0.0;
  double long = 0.0;
  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat = double.tryParse(position.latitude.toString()) ?? 0.0;

    long = double.tryParse(position.longitude.toString()) ?? 1.0;
    LatLng location = LatLng(lat, long);
    print("latlatlatlat${lat}");
    setState(() {
      _currentPosition1 = location;
      _latitude.text = lat.toString();
      _latitude1.text = long.toString();
      _updateMarker();
      isloding = false; // Ensure marker is updated with new location
    });
    print(" _latitude.text${_latitude.text}");
    print(" _latitude.text${_latitude1.text}");
  }
  TextEditingController  _latitude =TextEditingController();
  TextEditingController  _latitude1 =TextEditingController();
  // void _onTap() {
  //   setState(() {
  //     _lastLatitude = lat1;
  //     _lastLongitude = ;
  //     _latitude.text= _lastLatitude.toString();
  //     _latitude1.text= _lastLongitude.toString();
  //     _marker = Marker(
  //       markerId: MarkerId(location.toString()),
  //       position: location,
  //       infoWindow: InfoWindow(
  //         title: 'New Marker',
  //         snippet: 'This is a new marker at ${_lastLatitude}, ${_lastLongitude}',
  //       ),
  //     );
  //
  //     // Move the camera to the new marker position
  //     _mapController?.animateCamera(
  //       CameraUpdate.newLatLng(location),
  //     );
  //   });
  // }
  String? selectedvalue = "";
  String? selectedvalue1 = "1";
  MapType _mapType = MapType.satellite;
  void _onMapTapped(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('Tapped Location'),
        position: latLng,
      ));

      // Update text fields with tapped location
      _latitude.text = latLng.latitude.toString();
      _latitude1.text = latLng.longitude.toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isloding=true;
    });
    getLocation();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      key: _scaffoldKeyProductlistpage1,
      drawer: drawer1(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
SizedBox(
  height: 5.h,

),
                header(
                    text: "Add Alert",
                    callback1: () {
                      _scaffoldKeyProductlistpage1.currentState?.openDrawer();
                    }),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Location",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
                SizedBox(height: 2.h,),
                Row(
                  children: [
                    Container(
                      height: 45.h,
                      width: MediaQuery.of(context).size.width * .95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black12, width: 1.sp)),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        onTap: _onMapTapped,
                        markers: _markers,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: _currentPosition1, // Default location
                          zoom: 10,
                        ),
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                          // Example: Disable all gestures
                          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                        }.toSet(),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text("Latitude",
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
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: secondary),
                        controller: _latitude,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Latitude";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                            hintText: "Latitude",
                            icon: Icon(
                              Icons.location_on,
                              color: secondary,
                            )),
                      ),

                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text("Longitude",
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
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: secondary),
                        controller: _latitude1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Longitude";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                            hintText: "Longitude",
                            icon: Icon(
                              Icons.location_on,
                              color: secondary,
                            )),
                      ),

                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Title",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Title of Alert";

                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Title of Alert",
                        icon: Icon(
                          Icons.map,
                          color: secondary,
                        )),
                  ),
                ),

                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Select a category",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(

                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    border: Border.all(width: 1, color:secondary),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child:DropdownButton(
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    hint: Text("Please Select Category",style: TextStyle(color: Colors.black,  fontFamily: "volken",)),

                    value: selectedvalue,
                    onChanged: (val)
                    {
                      setState((){
                        selectedvalue = val as String?;
                        print(selectedvalue);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("All Categories",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "",
                      ),
                      DropdownMenuItem(
                        child: Text("Anchorage",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "49",
                      ),
                      // DropdownMenuItem(
                      //   child: Text("Ferries",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                      //   value: "54",
                      // ),
                      // DropdownMenuItem(
                      //   child: Text("Harbors",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                      //   value: "48",
                      // ),
                      // DropdownMenuItem(
                      //   child: Text("Inlets",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                      //   value: "50",
                      // ),
                      // DropdownMenuItem(
                      //   child: Text("Landmarks",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                      //   value: "55",
                      // ),
                      // DropdownMenuItem(
                      //   child: Text("Marinas",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                      //   value: "47",
                      // ),
                      DropdownMenuItem(
                        child: Text("Other",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "66",
                      ),
                      DropdownMenuItem(
                        child: Text("Warning",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "65",
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Status",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(

                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    border: Border.all(width: 1, color:secondary),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child:DropdownButton(
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    hint: Text("Please Select Category",style: TextStyle(color: Colors.black,  fontFamily: "volken",)),

                    value: selectedvalue1,
                    onChanged: (val)
                    {
                      setState((){
                        selectedvalue1 = val as String?;
                        print(selectedvalue1);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("Active",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "1",
                      ),
                      DropdownMenuItem(
                        child: Text("InActive",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "0",
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alert radius from position",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: secondary),
                    controller: _position,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Alert radius from position";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Alert radius from position",
                        icon: Icon(
                          Icons.map,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 2.h,),
                batan(
                    title: "Add ALERT",
                    route: () {
                      AddAlaram();
                    },
                    hight: 6.h,
                    width: MediaQuery.of(context).size.width,
                    txtsize: 15.sp),
                SizedBox(height: 10.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  AddAlaram() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['radius'] = _position.text.trim().toString();
      data['user_id'] = (loginmodal?.userId).toString();
      data['latitude'] = _latitude.text.toString();
      data['longitude'] = _latitude1.text.toString();
      data['location'] =_title.text.trim().toString();
      data['category'] =selectedvalue.toString() ;
      data['status'] =selectedvalue1.toString() ;

      print("Alaramapidata${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().updatealaramapi(data).then((response) async {
            addalarammodal = AddAlaramModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && addalarammodal?.success == true) {

              EasyLoading.showSuccess(addalarammodal?.message ?? '');
              Get.offAll(UpdateAlarmScreen());

              setState(() {

              });
            } else {
              EasyLoading.showError(addalarammodal?.message ?? '');
              buildErrorDialog(
                  context, "Login Error", (addalarammodal?.message ?? ''));
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
}
