

import 'dart:convert';

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
import '../Modal/UpdateAlaramModal.dart';
import '../Provider/Authprovider.dart';

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
      lat1=lat;
      lng1=long;
    });
  }
  String? selectedvalue = "All Categories";
  String? selectedvalue1 = "Active";
  MapType _mapType = MapType.satellite;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation().then((_) {
      setState(() async {
        _markers.add(Marker(
          markerId: MarkerId('Current Location'),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
                devicePixelRatio: 2.5, size: Size(1000.sp, 1000.sp)),
            'assets/morning.png',
          ),
          position: _currentPosition1,
        ));
      });
    });
    print("livelocation:-${_currentPosition1}");
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40.h,
                  child:   GoogleMap(
                    onMapCreated: _onMapCreated,

                    initialCameraPosition: CameraPosition(
                      target: _currentPosition1,
                      // You can set your initial position here
                      zoom: 12.0,
                    ),
                    mapType: _isSatellite ? MapType.satellite : MapType.normal,
                    markers: _markers,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    compassEnabled: true,
                  ),
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
                        value: "All Categories",
                      ),
                      DropdownMenuItem(
                        child: Text("Anchorage",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Anchorage",
                      ),
                      DropdownMenuItem(
                        child: Text("Ferries",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Ferries",
                      ),
                      DropdownMenuItem(
                        child: Text("Harbors",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Harbors",
                      ),
                      DropdownMenuItem(
                        child: Text("Inlets",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Inlets",
                      ),
                      DropdownMenuItem(
                        child: Text("Landmarks",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Landmarks",
                      ),
                      DropdownMenuItem(
                        child: Text("Marinas",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Marinas",
                      ),
                      DropdownMenuItem(
                        child: Text("Other",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Other",
                      ),
                      DropdownMenuItem(
                        child: Text("Warning",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Warning",
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
                        value: "Active",
                      ),
                      DropdownMenuItem(
                        child: Text("InActive",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "InActive",
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
                    title: "UPDATE ALARAM",
                    route: () {
                      updatealaram();
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
  updatealaram() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['radius_around'] = _position.text.trim().toString();
      data['id'] = (loginmodal?.userId).toString();
      data['my_lat'] =lat1.toString() ;
      data['my_lng'] = lng1.toString();
      print("Alaramapidata${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().updatealaramapi(data).then((response) async {
            updatealarammodal = UpdateAlaramModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && loginmodal?.success == true) {

              EasyLoading.showSuccess(updatealarammodal?.message ?? '');
              Get.offAll(HomeScreen());

              setState(() {

              });
            } else {
              EasyLoading.showError(updatealarammodal?.message ?? '');
              buildErrorDialog(
                  context, "Login Error", (updatealarammodal?.message ?? ''));
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
}
