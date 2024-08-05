

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapposition/Extras/load.dart';

import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/buildErrorDialog.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Modal/AddAlaramModal.dart';
import '../Modal/NewUpdatealaramModal.dart';
import '../Modal/UpdateAlaramModal.dart';
import '../Modal/UpdatealramModalscreen.dart';
import '../Provider/Authprovider.dart';
import 'UpdateAlarmScreen.dart';

class UpdatealramScreenTwo extends StatefulWidget {
  String? id;
  UpdatealramScreenTwo({super.key,required this.id});

  @override
  State<UpdatealramScreenTwo> createState() => _UpdatealramScreenTwoState();
}

class _UpdatealramScreenTwoState extends State<UpdatealramScreenTwo> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage1 =GlobalKey<ScaffoldState>();

  double? lat1,lng1;

  TextEditingController _position =TextEditingController();

  TextEditingController _title =TextEditingController();
  Set<Marker> _markers = {};
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
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // searchController.dispose();
    super.dispose();
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


  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = double.parse((newupdatealarammodal?.alarm?.lattiude).toString());
    double long = double.parse((newupdatealarammodal?.alarm?.longitude).toString());
    LatLng location = LatLng(lat, long);
    setState(() {
      _currentPosition1 = location;
      lat1=lat;
      lng1=long;
    });
  }
  String? selectedvalue = "";
  String? selectedvalue1 = "1";
  MapType _mapType = MapType.satellite;
  bool isLoading =true;

  Marker? _marker;
  // Add this line
  double? _lastLatitude;
  double? _lastLongitude;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    // Example: Move camera to a new position if a condition is met
    if (_lastLatitude != null && _lastLongitude != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_lastLatitude!, _lastLongitude!),
        ),
      );
    } else {
      // Default camera position if no marker is set
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(37.7749, -122.4194), // Default location
        ),
      );
    }
  }
  TextEditingController  _latitude =TextEditingController();
  TextEditingController  _latitude1 =TextEditingController();
  void _onTap(LatLng location) {

    setState(() {
      _lastLatitude = location.latitude;
      _lastLongitude = location.longitude;
      _latitude.text= _lastLatitude.toString();
      _latitude1.text= _lastLongitude.toString();
      _marker = Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: 'New Marker',
          snippet: 'This is a new marker at ${_lastLatitude}, ${_lastLongitude}',
        ),
      );

      // Move the camera to the new marker position
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(location),
      );
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatealaram();
    getLocation();
  }
  Widget build(BuildContext context) {
    return commanScreen(
      isLoading: isLoading,
       scaffold:Scaffold(
        backgroundColor: bgcolor,
        key: _scaffoldKeyProductlistpage1,
        drawer: drawer1(),
        body: Form(
          key: _formKey,
          child: isLoading?Container():SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,

                  ),
                  header(
                      text: "Subscription Alarm",
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
                          onTap: _onTap,
                          markers: _marker != null ? {_marker!} : {},
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
                      Text("Latitude:- ",
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
                      Text("Longitude:- ",
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
                      Text("Title :-",
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
                          return "Please Enter Your Title";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your Title",
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
                      Text("Select a category:-",
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
                      Text("Status:-",
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
                      Text("Radius around your position (km)",
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
                          return "Please Enter Your position";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your position",
                          icon: Icon(
                            Icons.map,
                            color: secondary,
                          )),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  batan(
                      title: "Add ALARM",
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
      ),
    );
  }
  AddAlaram() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['radius'] = _position.text.trim().toString();
      data['user_id'] =widget.id.toString();
      data['latitude'] =_latitude.text.toString();
      data['longitude'] = _latitude1.text.toString();
      data['location'] =_title.text.trim().toString();
      data['category'] =selectedvalue.toString() ;
      data['status'] =selectedvalue1.toString() ;

      print("Alaramapidata${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().updatealaramapitwo(data).then((response) async {
            updatealrammodalscreen = UpdatealramModalscreen.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && updatealrammodalscreen?.success == true) {

              EasyLoading.showSuccess(updatealrammodalscreen?.message ?? '');
              Get.offAll(UpdateAlarmScreen());

              setState(() {

              });
            } else {
              EasyLoading.showError(updatealrammodalscreen?.message ?? '');
              // buildErrorDialog(
              //     context, "Error", (updatealrammodalscreen?.message ?? ''));
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
  updatealaram() {
    final Map<String, String> data = {};
    data['id'] = widget.id.toString();

    print("Alaramapidata${data}");
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().newupdatealaramapi(data).then((response) async {
          newupdatealarammodal = NewUpdatealaramModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && newupdatealarammodal?.success == true) {
            _title.text=newupdatealarammodal?.alarm?.location ?? "";
            _position.text=newupdatealarammodal?.alarm?.radius ?? "";
            selectedvalue=newupdatealarammodal?.alarm?.category ?? "";
            selectedvalue1=newupdatealarammodal?.alarm?.status ?? "";
            _latitude.text=newupdatealarammodal?.alarm?.lattiude ?? "";
            _latitude1.text=newupdatealarammodal?.alarm?.longitude ?? "";


            setState(() {
              isLoading=false;
            });
          } else {
            setState(() {
              isLoading=false;
            });
            buildErrorDialog(
                context, "Error", (addalarammodal?.message ?? ''));
          }
        });
      } else {
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
}
