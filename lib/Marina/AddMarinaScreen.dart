import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/Drwer.dart';
import 'package:mapposition/HomeScreen/HomeScreen.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Headerwidget.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/CastomPositionMarinaModal.dart';
import '../Modal/EditCasotamMarinaModal.dart';
import '../Modal/ViewCategoryWiseviewDetailModal.dart';
import '../Provider/Authprovider.dart';

class AddMarinaScreen extends StatefulWidget {
  String? lat;
  String? lng;
  String? postid;

  AddMarinaScreen({super.key,this.lat,this.lng,this.postid});


  @override
  State<AddMarinaScreen> createState() => _AddMarinaScreenState();
}

class _AddMarinaScreenState extends State<AddMarinaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();
  TextEditingController _title =TextEditingController();
  TextEditingController _descripation =TextEditingController();
  TextEditingController _priceindoller =TextEditingController();
  TextEditingController _pricelebal =TextEditingController();
  TextEditingController _address =TextEditingController();
  TextEditingController _city =TextEditingController();
  TextEditingController _neighborthood =TextEditingController();
  TextEditingController _zipcode =TextEditingController();
  TextEditingController _state =TextEditingController();
  TextEditingController _country =TextEditingController();
  TextEditingController _slips =TextEditingController();
  TextEditingController _approach =TextEditingController();
  TextEditingController _meanlowwaterdockdepth =TextEditingController();
  TextEditingController _minimumapproachdepth =TextEditingController();
  TextEditingController _feet =TextEditingController();
  TextEditingController _meanhighwaterclearance =TextEditingController();
  TextEditingController _MaxVesselLOA =TextEditingController();
  TextEditingController _MaaSlipLength =TextEditingController();
  TextEditingController _MaaSlipwidth =TextEditingController();
  TextEditingController _pricelebal1 =TextEditingController();
  String? selectedvalue="Anchorages";
  String? services="Yes";
  String? gas="Yes";
  String? TransientStorage="Yes";
  String? longtermstorage="Yes";
  String? maxvesselloa;
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
  bool Use = false;
  bool Fixed  = false;
  bool mountain  = false;
  bool ashore = false;
  bool Sand = false;
  bool Mud = false;
  bool Clay = false;
  bool Coral = false;
  bool Rocks = false;
  bool Groceries = false;
  bool Pharmacy = false;
  bool Water = false;
  bool Restaurant = false;
  bool Alcohol = false;
  bool beach = false;
  bool shop = false;
  bool pontoon = false;
  List<List<int>> data = [
    [3, 3, 3, 3, 3, 3, 3, 3],
  ];
  ImagePicker picker = ImagePicker();
  List<XFile>? resultList;
  List<XFile>? resultList1;
  List<File> selectedImages = [];
  List<String> imagePaths = [];
  List<XFile> imagesList = <XFile>[];
  String _error = 'No Error Dectected';
  List<String> imageNames = [];
  ImagePicker _picker = ImagePicker();
  int maxImageLimit = 9;
  File? selectedimage;
  List<String> networkImageUrls = [];
  final _formKey = GlobalKey<FormState>();
  late LatLng _currentPosition1 = LatLng(21.1702, 72.8311);
  double? lat1,lng1;
  Set<Marker> _markers = {};


  Marker? _marker;
  GoogleMapController? _mapController; // Add this line
  double? _lastLatitude;
  double? _lastLongitude;

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
        _markers.removeWhere((m) => m.markerId.value == 'alarm_marker'); // Remove old marker if it exists
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


  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double lat = double.tryParse(newupdatealarammodal?.alarm?.lattiude ?? '0.0') ?? 0.0;
    double long = double.tryParse(newupdatealarammodal?.alarm?.longitude ?? '0.0') ?? 0.0;
    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition1 = location;
      _latitude.text = lat.toString();
      _latitude1.text = long.toString();
      _updateMarker(); // Ensure marker is updated with new location
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    print('Map Controller Created');

    // Set initial camera position dynamically
    LatLng initialPosition;
    double initialZoom;

    if (newupdatealarammodal?.alarm?.lattiude != null &&
        newupdatealarammodal?.alarm?.longitude != null) {
      double latitude = double.tryParse(newupdatealarammodal?.alarm?.lattiude ?? '0.0') ?? 0.0;
      double longitude = double.tryParse(newupdatealarammodal?.alarm?.longitude ?? '0.0') ?? 0.0;
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

// Example function to calculate zoom level dynamically based on latitude and longitude
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
    widget.postid==null?"": viewposition();
    getLocation();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key:_scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h,),
                header(
                    text: "Add Position",
                    callback1: () {
                      _scaffoldKeyProductlistpage.currentState?.openDrawer();
                    }),
             SizedBox(height: 2.h,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Position Description",style: TextStyle(
                     letterSpacing: 1,
                     color: Colors.black,
                     fontSize: 15.sp,
                     fontWeight: FontWeight.bold,
                     fontFamily: "volken")),
               ],
             ),
                SizedBox(height: 2.h,),
                Text("Title :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Position Title";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Position Title",
                        icon: Icon(
                          Icons.title,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 2.h,),
                Text("Description :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _descripation,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Description";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Description",
                    ),
                  ),
                ),
                SizedBox(height: 2.h,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("Position Price",style: TextStyle(
                //         letterSpacing: 1,
                //         color: Colors.black,
                //         fontSize: 15.sp,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: "volken")),
                //   ],
                // ),
                // SizedBox(height: 2.h,),
                // Text("Price in \$  :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     style: TextStyle(color: secondary),
                //     controller: _priceindoller,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter Price";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your Price",
                //         icon: Icon(
                //           Icons.payment,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(height: 2.h,),
                // Text("After Price Label :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     style: TextStyle(color: secondary),
                //     controller: _pricelebal,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter After Price Label";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your After Price Label",
                //         icon: Icon(
                //           Icons.price_check,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(height: 2.h,),
                // Text("Before Price Label :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     style: TextStyle(color: secondary),
                //     controller: _pricelebal1,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter Before Price Label";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your Before Price Label",
                //         icon: Icon(
                //           Icons.price_check,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Select Categories",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                        SizedBox(height: 1.h,),
                        SizedBox(
                          width: 85.w,
                          child: Text("Selecting a category will make it easier for users to find you Position in search results.",style: TextStyle(
                              letterSpacing: 1,
                              color: secondary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                Text("Category :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")
                ),

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
                        child: Text("Anchorages",style: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Anchorages",
                      ),
                      DropdownMenuItem(
                        child: Text("Bridges",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Bridges",
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
                        child: Text("Lighthouses",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Lighthouses",
                      ),
                      DropdownMenuItem(
                        child: Text("Locks",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Locks",
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
                        child: Text("Sabah",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "SBH",
                      ),
                      DropdownMenuItem(
                        child: Text("Ramps",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Ramps",
                      ),
                      DropdownMenuItem(
                        child: Text("Warning",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Warning",
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Listing Media",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                  ],
                ),
              SizedBox(height: 2.h,),
                selectedimage == null?Container():Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: bgcolor, // Border color
                          width: 2.sp, // Border width
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child:  selectedimage != null
                            ? Image.file(selectedimage!, fit: BoxFit.cover,)
                            : Container(),

                      ),
                    ),
                  ],
                ),
                resultList1==null||resultList1==""?Container():Column(
                  children: [
                    //for first select
                    selectedImages.isEmpty
                        ? GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            resultList = await ImagePicker()
                                .pickMultiImage();

                            if (resultList != null) {
                              if (resultList!.length +
                                  selectedImages.length >
                                  maxImageLimit) {
                                print(
                                    'Maximum image limit exceeded');
                              } else {
                                setState(() {
                                  selectedImages = resultList!
                                      .map((XFile file) =>
                                      File(file.path))
                                      .toList()!;
                                  imagePaths.addAll(
                                      resultList!
                                          .map((file) =>
                                      file.path)
                                          .toList());
                                });
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(3.w),
                            height: 60.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.grey)),
                          ),
                        );
                      },
                      itemCount: 9,
                    )
                        : Container(),
                    selectedImages.isEmpty
                        ? Container()
                        :
                    //disply after first selection
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        if (index < selectedImages.length &&
                            selectedImages[index] != null) {
                          return Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(3.w),
                                  height: 70.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius
                                          .circular(15),
                                      border: Border.all(
                                          color:
                                          Colors.grey)),
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius
                                          .circular(15),
                                      child: Image.file(
                                          selectedImages[
                                          index],
                                          height: 60.h,
                                          width: 70.w,
                                          fit:
                                          BoxFit.cover))),
                              Positioned(
                                  left: 50.w,
                                  top: 10.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImages
                                            .removeAt(index);
                                        imagePaths
                                            .removeAt(index);
                                      });
                                    },
                                    child: Container(
                                        height: 15.w,
                                        width: 15.w,
                                        alignment:
                                        Alignment.center,
                                        decoration:
                                        BoxDecoration(
                                            shape: BoxShape
                                                .circle,
                                            color: Colors
                                                .white),
                                        child: Icon(
                                          Icons.close,
                                          size: 15.sp,
                                        )),
                                  ))
                            ],
                          );
                        } else {
                          //remaining container
                          return GestureDetector(
                            onTap: () async {
                              resultList1 =
                              await ImagePicker()
                                  .pickMultiImage();
                              if (resultList1 != null) {
                                if (resultList1!.length +
                                    selectedImages
                                        .length >
                                    maxImageLimit) {
                                  // Handle maximum image limit exceeded
                                  buildErrorDialog(context,
                                      "", "You selected more than 9 images");
                                } else {
                                  setState(() {
                                    print(selectedImages);
                                    selectedImages.addAll(
                                        resultList1!
                                            .map((XFile
                                        file) =>
                                            File(file
                                                .path))
                                            .toList());
                                    imagePaths = resultList1!
                                        .map((file) =>
                                    file.path)
                                        .toList();
                                  });
                                }
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(3.w),
                              height: 60.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(
                                      15),
                                  border: Border.all(
                                      color: Colors.grey)),
                            ),
                          );
                        }
                      },
                    )

                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  batan(title: "Select Photo", route: ()async{
                    // final XFile? photo = await picker.pickImage(
                    //     source: ImageSource.gallery);
                    // setState(() {
                    //   selectedimage = File(photo!.path);
                    //   print(selectedimage);
                    // });
                    resultList1 =
                    await ImagePicker()
                        .pickMultiImage();
                    if (resultList1 != null) {
                      if (resultList1!.length +
                          selectedImages
                              .length >
                          maxImageLimit) {
                        // Handle maximum image limit exceeded
                        buildErrorDialog(context,
                            "", "You selected more than 9 images");
                      } else {
                        setState(() {
                          print(selectedImages);
                          selectedImages.addAll(
                              resultList1!
                                  .map((XFile
                              file) =>
                                  File(file
                                      .path))
                                  .toList());
                          imagePaths = resultList1!
                              .map((file) =>
                          file.path)
                              .toList();
                        });
                      }
                    }
                  }, hight: 6.h, width:55.w, txtsize: 20.sp),
                ],
              ),
                Row(
                  children: [
                    Text("Listing Location :-",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
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
                        border: Border.all(color: Colors.black12, width: 1.sp),
                      ),
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
                          target: LatLng(
                            double.tryParse(newupdatealarammodal?.alarm?.lattiude ?? '0.0') ?? 0.0,
                            double.tryParse(newupdatealarammodal?.alarm?.longitude ?? '0.0') ?? 0.0,
                          ),
                          zoom: 10,
                        ),
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
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
                          keyboardType: TextInputType.number,
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
                            ),
                          ),
                          onChanged: (value) {
                            _updateMarker(); // Update marker when latitude changes
                          },
                        ))
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
                          keyboardType: TextInputType.number,
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
                            ),
                          ),
                          onChanged: (value) {
                            _updateMarker(); // Update marker when longitude changes
                          },
                        ))
                  ],
                ),

                SizedBox(
                  height: 2.h,
                ),
                // SizedBox(
                //   height: 2.h,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("Listing Location",style: TextStyle(
                //         letterSpacing: 1,
                //         color: Colors.black,
                //         fontSize: 15.sp,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: "volken")),
                //   ],
                // ),
                // SizedBox(height: 1.h,),
                // Text("Address :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     style: TextStyle(color: secondary),
                //     controller: _address,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter Address";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your Address",
                //         icon: Icon(
                //           Icons.home,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(height: 1.h,),
                // Text("City :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     style: TextStyle(color: secondary),
                //     controller: _city,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter City";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your City",
                //         icon: Icon(
                //           Icons.location_city_sharp,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(height: 1.h,),
                // Text("Neighborhood :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     style: TextStyle(color: secondary),
                //     controller: _neighborthood,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter Neighborhood";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your Neighborhood",
                //         icon: Icon(
                //           Icons.location_city_sharp,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(height: 1.h,),
                // Text("Zipcode :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     style: TextStyle(color: secondary),
                //     controller: _zipcode,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter Zipcode";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your Zipcode",
                //         icon: Icon(
                //           Icons.location_city_sharp,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(height: 1.h,),
                // Text("State :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     style: TextStyle(color: secondary),
                //     controller: _state,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter State";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your State",
                //         icon: Icon(
                //           Icons.location_city_sharp,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Text("Country :-",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // SizedBox(
                //   height: 1.h,
                // ),
                // Container(
                //   width:MediaQuery.of(context).size.width,
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     style: TextStyle(color: secondary),
                //     controller: _country,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please Enter Country";
                //       }
                //       return null;
                //     },
                //     decoration: inputDecoration(
                //         hintText: "Enter Your Country",
                //         icon: Icon(
                //           Icons.location_city_sharp,
                //           color: secondary,
                //         )),
                //   ),
                // ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Berth Capacity",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                  ],
                ),
                Text("Slips  :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _slips ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Slips";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Slips",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Approach",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                    SizedBox(
                      height: 1.h,
                    ),

                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
          Text("Minimum Approach Depth : ( Meters ) :-",style: TextStyle(
              letterSpacing: 1,
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "volken")),
          SizedBox(
            height: 1.h,
          ),

                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: secondary),
                    controller: _minimumapproachdepth ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Minimum Approach Depth";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Minimum Approach Depth",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text("Mean Low Water Dock Depth : ( Meters ) :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: secondary),
                    controller: _meanlowwaterdockdepth ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Minimum Approach Depth";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Minimum Approach Depth",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text("Minimum Channel Depth : ( Feet ) :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _feet ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Minimum Channel Depth";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Minimum Channel Depth",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),SizedBox(
                  height: 1.h,
                ),
                Text("Mean High Water Clearance : ( Feet ) :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _meanhighwaterclearance ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Mean High Water Clearance";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Mean High Water Clearance",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Services & Amenities",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                    SizedBox(
                      height: 1.h,
                    ),

                  ],
                ),
                SizedBox(height: 1.h,),
                Text("Fuel Dock :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
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

                    hint: Text("Please Select Fuel Dock ",style: TextStyle(color:secondary,fontFamily: "volken",)),

                    value: services,
                    onChanged: (val)
                    {
                      setState((){
                        services=val!;
                        print(services);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("Yes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Yes",
                      ),
                      DropdownMenuItem(
                        child: Text("No",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "No",
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Gas  :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
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

                    hint: Text("Please Select Gas ",style: TextStyle(color:secondary,fontFamily: "volken",)),

                    value: gas,
                    onChanged: (val)
                    {
                      setState((){
                        gas=val!;
                        print(gas);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("Yes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Yes",
                      ),
                      DropdownMenuItem(
                        child: Text("No",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "No",
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Transient Storage  :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
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

                    hint: Text("Please Select Transient Storage ",style: TextStyle(color:secondary,fontFamily: "volken",)),

                    value: TransientStorage,
                    onChanged: (val)
                    {
                      setState((){
                        TransientStorage=val!;
                        print(TransientStorage);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("Yes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Yes",
                      ),
                      DropdownMenuItem(
                        child: Text("No",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "No",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Long Term Storage  :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
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

                    hint: Text("Please Select Transient Storage ",style: TextStyle(color:secondary,fontFamily: "volken",)),

                    value: longtermstorage,
                    onChanged: (val)
                    {
                      setState((){
                        longtermstorage=val!;
                        print(longtermstorage);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("Yes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "Yes",
                      ),
                      DropdownMenuItem(
                        child: Text("No",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                        value: "No",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Max. Vessel LOA  :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _MaxVesselLOA ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Max. Vessel LOA";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Max. Vessel LOA",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Max. Slip Length :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _MaaSlipLength ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Max. Slip Length";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Max. Slip Length",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ), SizedBox(height: 1.h,),
                Text("Max. Slip Width :-",style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "volken")),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _MaaSlipwidth ,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Max. Slip Width";
                    //   }
                    //   return null;
                    // },
                    decoration: inputDecoration(
                        hintText: "Enter Your Max. Slip Width",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),

                Row(
                  children: [
                    Text("Protection",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken"))
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  children: [
                    Container(
                      height: 50.h,
                      child: RadarChart.light(
                        ticks: [2, 4, 6, 8, 10],
                        features: ["N", "NE", "E", "SE", "S", "SW", "W", "NW"],
                        data: data,
                        // graphColors: [Colors.blue, Colors.green],
                        // featuresTextStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    buildCheckboxRow('North (N)', [
                      buildCheckbox('Some protection', N1, (val) {
                        setState(() {
                          N1 = val;
                          N2 = false;
                          N3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', N2, (val) {
                        setState(() {
                          N2 = val;
                          N1 = false;
                          N3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', N3, (val) {
                        setState(() {
                          N3 = val;
                          N2 = false;
                          N1 = false;
                          updateData();
                        });
                      }),
                    ]),
                    buildCheckboxRow('Northeast (NE)', [
                      buildCheckbox('Some protection', NE1, (val) {
                        setState(() {
                          NE1 = val;
                          NE2 = false;
                          NE3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', NE2, (val) {
                        setState(() {
                          NE2 = val;
                          NE1 = false;
                          NE3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', NE3, (val) {
                        setState(() {
                          NE3 = val;
                          NE2 = false;
                          NE1 = false;
                          updateData();
                        });
                      }),
                    ]),
                    buildCheckboxRow('East (E)', [
                      buildCheckbox('Some protection', E1, (val) {
                        setState(() {
                          E1 = val;
                          E2 = false;
                          E3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', E2, (val) {
                        setState(() {
                          E2 = val;
                          E3 = false;
                          E1 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', E3, (val) {
                        setState(() {
                          E3 = val;
                          E2 = false;
                          E1 = false;
                          updateData();
                        });
                      }),
                    ]),
                    buildCheckboxRow('Southeast (SE)', [
                      buildCheckbox('Some protection', SE1, (val) {
                        setState(() {
                          SE1 = val;
                          SE3= false;
                          SE2 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', SE2, (val) {
                        setState(() {
                          SE2 = val;
                          SE1 = false;
                          SE3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', SE3, (val) {
                        setState(() {
                          SE3 = val;
                          SE2 = false;
                          SE1 = false;
                          updateData();
                        });
                      }),
                    ]),
                    buildCheckboxRow('South (S)', [
                      buildCheckbox('Some protection', S1, (val) {
                        setState(() {
                          S1 = val;
                          S2= false;
                          S3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', S2, (val) {
                        setState(() {
                          S2 = val;
                          S1= false;
                          S3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', S3, (val) {
                        setState(() {
                          S3 = val;
                          S1= false;
                          S2 = false;
                          updateData();
                        });
                      }),
                    ]),
                    buildCheckboxRow('Southwest (SW)', [
                      buildCheckbox('Some protection', SW1, (val) {
                        setState(() {
                          SW1 = val;
                          SW2= false;
                          SW3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', SW2, (val) {
                        setState(() {
                          SW2 = val;
                          SW1= false;
                          SW3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', SW3, (val) {
                        setState(() {
                          SW3 = val;
                          SW1= false;
                          SW2 = false;
                          updateData();
                        });
                      }),
                    ]),
                    buildCheckboxRow('West (W)', [
                      buildCheckbox('Some protection', W1, (val) {
                        setState(() {
                          W1 = val;
                          W2 = false;
                          W3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', W2, (val) {
                        setState(() {
                          W2 = val;
                          W1 = false;
                          W3 = false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', W3, (val) {
                        setState(() {
                          W3 = val;
                          W2 = false;
                          W1 = false;
                          updateData();
                        });
                      }),
                    ]),
                    buildCheckboxRow('West (NW)', [
                      buildCheckbox('Some protection', NW1, (val) {
                        setState(() {
                          NW1 = val;
                          NW2=false;
                          NW3=false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Average protection', NW2, (val) {
                        setState(() {
                          NW2 = val;
                          NW1=false;
                          NW3=false;
                          updateData();
                        });
                      }),
                      buildCheckbox('Completely protected', NW3, (val) {
                        setState(() {
                          NW3 = val;
                          NW2=false;
                          NW1=false;
                          print("NW2${NW2}");
                          updateData();
                        });
                      }),
                    ]),
                    // Repeat for other directions...
                  ],
                ),
                // Text("North (N) : -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: N1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               N1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: N2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               N2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: N3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               N3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                // SizedBox(height: 1.h,),
                // Text("Northeast (NE) : -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: NE1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               NE1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: NE2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               NE2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: NE3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               NE3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),
                // SizedBox(height: 1.h,),
                // Text("East (E) : -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: E1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               E1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: E2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               E2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: E3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               E3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),SizedBox(height: 1.h,),
                // Text("Southeast (SE): -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: SE1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               SE1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: SE2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               SE2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: SE3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               SE3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),SizedBox(height: 1.h,),
                // Text("South (S): -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: S1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               S1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: S2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               S2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: S3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               S3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),SizedBox(height: 1.h,),
                // Text("Southwest (SW): -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: SW1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               SW1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: SW2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               SW2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: SW3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               SW3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),SizedBox(height: 1.h,),
                // Text("West (W): -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: W1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               W1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: W2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               W2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: W3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               W3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),SizedBox(height: 1.h,),
                // Text("Northwest (NW): -",style: TextStyle(
                //     letterSpacing: 1,
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "volken")),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: NW1,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               NW1 = value!;
                //             });
                //           },
                //         ),
                //         Text("Some protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: NW2,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               NW2 = value!;
                //             });
                //           },
                //         ),
                //         Text("Average protection",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Checkbox(
                //           value: NW3,
                //           onChanged: (bool? value) {
                //             setState(() {
                //               NW3 = value!;
                //             });
                //           },
                //         ),
                //         Text("Completely protected",style: TextStyle(
                //             letterSpacing: 1,
                //             color: secondary,
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "volken")),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Features: -",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(

                  children: [
                    Checkbox(
                      value: Use,
                      onChanged: (bool? value) {
                        setState(() {
                          Use  = value!;
                        });
                      },
                    ),
                    Text("Use own anchor's",style: TextStyle(
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
                      value: Fixed ,
                      onChanged: (bool? value) {
                        setState(() {
                          Fixed  = value!;
                        });
                      },
                    ),
                    Text("Buoys available",style: TextStyle(
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
                      value: mountain,
                      onChanged: (bool? value) {
                        setState(() {
                          mountain  = value!;
                        });
                      },
                    ),
                    Text("Wedges available",style: TextStyle(
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
                      value: ashore,
                      onChanged: (bool? value) {
                        setState(() {
                          ashore = value!;
                        });
                      },
                    ),
                    Text("Use lines ashore",style: TextStyle(
                        letterSpacing: 1,
                        color: secondary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                  ],
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Conditions",style: TextStyle(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: Sand,
                              onChanged: (bool? value) {
                                setState(() {
                                  Sand  = value!;
                                });
                              },
                            ),
                            Text("Sand",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            Checkbox(
                              value: Coral,
                              onChanged: (bool? value) {
                                setState(() {
                                  Coral  = value!;
                                });
                              },
                            ),
                            Text("Coral",style: TextStyle(
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
                              value: Rocks,
                              onChanged: (bool? value) {
                                setState(() {
                                  Rocks  = value!;
                                });
                              },
                            ),
                            Text("Rocks",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: Mud,
                              onChanged: (bool? value) {
                                setState(() {
                                  Mud  = value!;
                                });
                              },
                            ),
                            Text("Mud",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            Checkbox(
                              value: Clay,
                              onChanged: (bool? value) {
                                setState(() {
                                  Clay  = value!;
                                });
                              },
                            ),
                            Text("Clay",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Facilities",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),

                  ],
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: Groceries,
                              onChanged: (bool? value) {
                                setState(() {
                                  Groceries  = value!;
                                });
                              },
                            ),
                            Text("Groceries",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            Checkbox(
                              value: Pharmacy,
                              onChanged: (bool? value) {
                                setState(() {
                                  Pharmacy  = value!;
                                });
                              },
                            ),
                            Text("Pharmacy",style: TextStyle(
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
                              value: Water,
                              onChanged: (bool? value) {
                                setState(() {
                                  Water  = value!;
                                });
                              },
                            ),
                            Text("Water",style: TextStyle(
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
                              value: shop,
                              onChanged: (bool? value) {
                                setState(() {
                                  shop  = value!;
                                });
                              },
                            ),
                            Text("Shop",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: Restaurant,
                              onChanged: (bool? value) {
                                setState(() {
                                  Restaurant  = value!;
                                });
                              },
                            ),
                            Text("Restaurant",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            Checkbox(
                              value: Alcohol,
                              onChanged: (bool? value) {
                                setState(() {
                                  Alcohol  = value!;
                                });
                              },
                            ),
                            Text("Alcohol",style: TextStyle(
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
                              value: beach,
                              onChanged: (bool? value) {
                                setState(() {
                                  beach  = value!;
                                });
                              },
                            ),
                            Text("Beach",style: TextStyle(
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
                              value: pontoon,
                              onChanged: (bool? value) {
                                setState(() {
                                  pontoon  = value!;
                                });
                              },
                            ),
                            Text("Pontoon",style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "volken")),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
                SizedBox(height: 3.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.postid==null||widget.postid==""?batan(title: "Add Position", route: (){
                  castommapposition();
                }, hight: 6.h, width: 70.w, txtsize: 20.sp):batan(title: "Update Position", route: (){
                      updatecasotammarina();
                    }, hight: 6.h, width: 70.w, txtsize: 20.sp),
                  ],
                ),
                SizedBox(height: 5.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  //AddNewPositionapifuncation
  castommapposition() async {
    if (_formKey.currentState!.validate()) {
      print(selectedimage?.path);
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      var meta = {
        "property_address":  _address.text==null?"":_address.text.trim().toString(),
        "property_city": _city.text==null?"":_city.text.trim().toString(),
        "property_area": _neighborthood.text.trim().toString(),
        "property_zip":  _zipcode.text==null?"":_zipcode.text.trim().toString(),
        "property_country": _country.text==null?"":_country.text.trim().toString(),
        "property_latitude": _latitude.text.toString(),
        "property_longitude": _latitude1.text.toString(),
        "text_slips": _slips.text.trim().toString(),
        "text_minimumapproachdepth": _minimumapproachdepth.text==null?"":_minimumapproachdepth.text.trim()
            .toString(),
        "text_meanlowwaterdockdepth": _meanlowwaterdockdepth.text==null?"":_meanlowwaterdockdepth.text.trim()
            .toString(),
        "text_minimumchanneldepth": _feet.text==null?"":_feet.text.trim().toString(),
        "text_meanhighwaterclearance": _meanhighwaterclearance.text==null?"":_meanhighwaterclearance.text.trim()
            .toString(),
        "text_fueldock": services,
        "text_gas": gas,
        "text_transientstorage": TransientStorage,
        "text_longtermstorage": longtermstorage,
        "text_maxvesselloa": maxvesselloa,
        "text_maxsliplength": _MaaSlipLength.text==null?"":_MaaSlipLength.text.trim().toString(),
        "text_maxslipwidth": _MaaSlipwidth.text==null?"":_MaaSlipwidth.text.trim().toString(),
        "n1": N1,
        "n2": N2,
        "n3": N3,
        "ne1": NE1,
        "ne2": NE2,
        "ne3": NE3,
        "e1": E1,
        "e2": E2,
        "e3": E3,
        "se1": SE1,
        "se2": SE2,
        "se3": SE3,
        "s1": S1,
        "s2": S2,
        "s3": S3,
        "sw1": SW1,
        "sw2": SW2,
        "sw3": SW3,
        "w1": W1,
        "w2": W2,
        "w3": W3,
        "nw1": NW1,
        "nw2": NW2,
        "nw3": NW3,
        "own_anchor": Use,
        "buoys": Fixed,
        "mountain_wedges": mountain,
        "own_lines": ashore,
        "sand": Sand,
        "mud": Mud,
        "clay": Clay,
        "coral": Coral,
        "rocks": Rocks,
        "groceries": Groceries,
        "pharmacy": Pharmacy,
        "water": Water,
        "restaurant": Restaurant,
        "alcohol": Alcohol
        // add other meta fields here
      };
      meta.forEach((key, value) {
        data['meta[$key]'] = value.toString();
      });
      data['user_id'] = (loginmodal?.userId).toString();
      data['title'] = _title.text.trim().toString();
      data['content'] = _descripation.text.trim().toString();
      data['post_category'] = selectedvalue.toString();
      data['post_images[]'] = jsonEncode(imagePaths);
      // data['meta'] = meta.toString();
      print("Printapivalue $data");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().addmarinacastomapi(data,imagePaths).then((response) async {
            castompositionmarinamodal =CastomPositionMarinaModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && castompositionmarinamodal?.success==true) {
              print("admin chalu karo bhai");
              EasyLoading.showSuccess(castompositionmarinamodal?.message ?? "");
              Get.off(HomeScreen());
            } else {
              EasyLoading.showError(castompositionmarinamodal?.message ?? "");
              setState(() {});
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
  //updatepositionfuncation
  updatecasotammarina() async {
    if (_formKey.currentState!.validate()) {
      print(selectedimage?.path);
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      var meta = {
        "property_address":  _address.text==null?"":_address.text.trim().toString(),
        "property_city": _city.text==null?"":_city.text.trim().toString(),
        "property_area": _neighborthood.text.trim().toString(),
        "property_zip":  _zipcode.text==null?"":_zipcode.text.trim().toString(),
        "property_country": _country.text==null?"":_country.text.trim().toString(),
        "property_latitude": _latitude.text.toString(),
        "property_longitude":_latitude1.text.toString(),
        "text_slips": _slips.text.trim().toString(),
        "text_minimumapproachdepth": _minimumapproachdepth.text==null?"":_minimumapproachdepth.text.trim()
            .toString(),
        "text_meanlowwaterdockdepth": _meanlowwaterdockdepth.text==null?"":_meanlowwaterdockdepth.text.trim()
            .toString(),
        "text_minimumchanneldepth": _feet.text==null?"":_feet.text.trim().toString(),
        "text_meanhighwaterclearance": _meanhighwaterclearance.text==null?"":_meanhighwaterclearance.text.trim()
            .toString(),
        "text_fueldock": services,
        "text_gas": gas,
        "text_transientstorage": TransientStorage,
        "text_longtermstorage": longtermstorage,
        "text_maxvesselloa": maxvesselloa,
        "text_maxsliplength": _MaaSlipLength.text==null?"":_MaaSlipLength.text.trim().toString(),
        "text_maxslipwidth": _MaaSlipwidth.text==null?"":_MaaSlipwidth.text.trim().toString(),
        "n1": N1,
        "n2": N2,
        "n3": N3,
        "ne1": NE1,
        "ne2": NE2,
        "ne3": NE3,
        "e1": E1,
        "e2": E2,
        "e3": E3,
        "se1": SE1,
        "se2": SE2,
        "se3": SE3,
        "s1": S1,
        "s2": S2,
        "s3": S3,
        "sw1": SW1,
        "sw2": SW2,
        "sw3": SW3,
        "w1": W1,
        "w2": W2,
        "w3": W3,
        "nw1": NW1,
        "nw2": NW2,
        "nw3": NW3,
        "own_anchor": Use,
        "buoys": Fixed,
        "mountain_wedges": mountain,
        "own_lines": ashore,
        "sand": Sand,
        "mud": Mud,
        "clay": Clay,
        "coral": Coral,
        "rocks": Rocks,
        "groceries": Groceries,
        "pharmacy": Pharmacy,
        "water": Water,
        "restaurant": Restaurant,
        "alcohol": Alcohol,
        "beach": beach,
        "pontoon": pontoon,
        "shop": shop
        // add other meta fields here
      };
      meta.forEach((key, value) {
        data['meta[$key]'] = value.toString();
      });
      data['post_id'] =widget.postid.toString();
      data['title'] = _title.text.trim().toString();
      data['content'] = _descripation.text.trim().toString();
      data['post_category'] = selectedvalue.toString();
      data['post_images[]'] = jsonEncode(imagePaths);
      print("Printapivalue $data");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().updatecastompostionapi(data,imagePaths).then((response) async {
            editcasotammarinamodal =EditCasotamMarinaModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && editcasotammarinamodal?.success==true) {
              print("admin chalu karo bhai");
              EasyLoading.showSuccess(editcasotammarinamodal?.message ?? "");
              Get.off(HomeScreen());
            } else {
              EasyLoading.showError(editcasotammarinamodal?.message ?? "");
              setState(() {});
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }


  viewposition() {
    final Map<String, String> data = {};
    data['post_id'] = widget.postid.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    print("PrintdataAmchorage${data}");
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewsinganalpositionviewapi(data).then((response) async {
          viewcategorywisevieweetailmodal =
              ViewCategoryWiseviewDetailModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              viewcategorywisevieweetailmodal?.success == true) {
            print("anchioirapicall");
            setState(() {
              _title.text=viewcategorywisevieweetailmodal?.data?.title==""||viewcategorywisevieweetailmodal?.data?.title==null?"":(viewcategorywisevieweetailmodal?.data?.title).toString();
              _descripation.text=viewcategorywisevieweetailmodal?.data?.content==""||viewcategorywisevieweetailmodal?.data?.content==null?"":(viewcategorywisevieweetailmodal?.data?.content).toString();
              _address.text=viewcategorywisevieweetailmodal?.data?.content==""||viewcategorywisevieweetailmodal?.data?.content==null?"":(viewcategorywisevieweetailmodal?.data?.content).toString();

              _city.text=viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCity=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCity==""||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCity==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCity).toString();
              _neighborthood.text=viewcategorywisevieweetailmodal?.data?.metaFields?.propertyArea=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyArea==""||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyArea==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.propertyArea).toString();
              _zipcode.text=viewcategorywisevieweetailmodal?.data?.metaFields?.propertyZip=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyZip==""||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyZip==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.propertyZip).toString();
              _country.text=viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCountry=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCountry==""||viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCountry==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.propertyCountry).toString();
              _slips.text=viewcategorywisevieweetailmodal?.data?.metaFields?.textSlips=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textSlips==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textSlips==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textSlips).toString();
              _minimumapproachdepth.text=viewcategorywisevieweetailmodal?.data?.metaFields?.textMinimumapproachdepth=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textMinimumapproachdepth==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textMinimumapproachdepth==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textMinimumapproachdepth).toString();
              _meanlowwaterdockdepth.text=viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanlowwaterdockdepth=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanlowwaterdockdepth==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanlowwaterdockdepth==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanlowwaterdockdepth).toString();
              _meanhighwaterclearance.text=viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanhighwaterclearance=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanhighwaterclearance==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanhighwaterclearance==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textMeanhighwaterclearance).toString();
              // services=viewcategorywisevieweetailmodal?.data?.metaFields?.textFueldock=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textFueldock==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textFueldock==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textFueldock).toString();
              // gas=viewcategorywisevieweetailmodal?.data?.metaFields?.textGas=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textGas==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textGas==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textGas).toString();
              // TransientStorage=viewcategorywisevieweetailmodal?.data?.metaFields?.textTransientstorage=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textTransientstorage==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textTransientstorage==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textTransientstorage).toString();
              // longtermstorage=viewcategorywisevieweetailmodal?.data?.metaFields?.textLongtermstorage=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textLongtermstorage==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textLongtermstorage==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textLongtermstorage).toString();
              _MaxVesselLOA.text=viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxvesselloa=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxvesselloa==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxvesselloa==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxvesselloa).toString();
              _MaaSlipLength.text=viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxsliplength=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxsliplength==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxsliplength==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxsliplength).toString();
              _MaaSlipwidth.text=viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxslipwidth=="null"||viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxslipwidth==""||viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxslipwidth==null?"":(viewcategorywisevieweetailmodal?.data?.metaFields?.textMaxslipwidth).toString();
              _latitude.text=viewcategorywisevieweetailmodal?.data?.latitude=="null"||viewcategorywisevieweetailmodal?.data?.latitude==""||viewcategorywisevieweetailmodal?.data?.latitude==null?"":(viewcategorywisevieweetailmodal?.data?.latitude).toString();
              _latitude1.text=viewcategorywisevieweetailmodal?.data?.longitude=="null"||viewcategorywisevieweetailmodal?.data?.longitude==""||viewcategorywisevieweetailmodal?.data?.longitude==null?"":(viewcategorywisevieweetailmodal?.data?.longitude).toString();


              dynamic waterValue = viewcategorywisevieweetailmodal?.data?.metaFields?.water;
              if (waterValue != null && waterValue is bool) {
                setState(() {
                  Water = waterValue;
                });

              } else {
                Water = false;
              }
              dynamic rocksvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.rocks;
              if (rocksvalue != null && rocksvalue is bool) {
                setState(() {
                  Rocks = rocksvalue;
                });

              } else {
                Rocks = false;
              }
              dynamic coralvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.coral;
              if (coralvalue != null && coralvalue is bool) {
                setState(() {
                  Coral =coralvalue;
                });

              } else {
                Coral = false;
              }
              dynamic clayvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.clay;
              if (clayvalue != null && clayvalue is bool) {
                setState(() {
                  Clay = clayvalue;
                });

              } else {
                Clay = false;
              }
              dynamic sandvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.sand;
              if (sandvalue != null && sandvalue is bool) {
                setState(() {
                  Sand = sandvalue;
                });

              } else {
                Sand = false;
              }
              dynamic buoysvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.buoys;
              if (buoysvalue != null && buoysvalue is bool) {
                setState(() {
                  Fixed = buoysvalue;
                });

              } else {
                Fixed = false;
              }
              dynamic restaurantsvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.restaurant;
              if (restaurantsvalue != null && restaurantsvalue is bool) {

                setState(() {
                  Restaurant = restaurantsvalue;
                });
              } else {
                Restaurant = false;
              }
              dynamic alcoholvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.alcohol;
              if (alcoholvalue != null && alcoholvalue is bool) {
                setState(() {
                  Alcohol = alcoholvalue;
                });

              } else {
                Alcohol = false;
              }
              dynamic pharmacyvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.pharmacy;
              if (pharmacyvalue != null && pharmacyvalue is bool) {
                setState(() {
                  Pharmacy = pharmacyvalue;
                });

              } else {
                Pharmacy = false;
              }
              dynamic beachcyvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.beach;
              if (pharmacyvalue != null && pharmacyvalue is bool) {
                setState(() {
                  beach = beachcyvalue;
                });

              } else {
                beach = false;
              }
              dynamic shopvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.shop;
              if (pharmacyvalue != null && pharmacyvalue is bool) {
                setState(() {
                  shop = shopvalue;
                });

              } else {
                shop = false;
              }
              dynamic pontoonvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.pontoon;
              if (pharmacyvalue != null && pharmacyvalue is bool) {
                setState(() {
                  pontoon = pontoonvalue;
                });

              } else {
                pontoon = false;
              }
              dynamic groceriesvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.groceries;
              if (groceriesvalue != null && groceriesvalue is bool) {
                setState(() {
                  Groceries = groceriesvalue;
                });

              } else {
                Groceries = false;
              }

              dynamic mountainvalue = viewcategorywisevieweetailmodal?.data?.metaFields?.mountainWedges;
              if (mountainvalue != null && mountainvalue is bool) {
                setState(() {
                  mountain = mountainvalue;
                });

              } else {
                mountain = false;
              }
              dynamic NW3value = viewcategorywisevieweetailmodal?.data?.metaFields?.nw3;
              if (NW3value != null && NW3value is bool) {
                setState(() {
                  NW3 = NW3value;
                  updateData();
                });

              } else {
                NW3 = false;
              }
              dynamic NW1value = viewcategorywisevieweetailmodal?.data?.metaFields?.nw1;
              if (NW1value != null && NW1value is bool) {
                setState(() {
                  NW1 = NW1value;
                  updateData();
                });

              } else {
                NW1 = false;
              }
              dynamic NW2value = viewcategorywisevieweetailmodal?.data?.metaFields?.nw2;
              if (NW2value != null && NW2value is bool) {
                setState(() {
                  NW2 = NW1value;
                  updateData();

                });

              } else {
                NW2 = false;
              }
              dynamic N1value = viewcategorywisevieweetailmodal?.data?.metaFields?.n1;
              if (N1value != null && N1value is bool) {
                setState(() {
                  N1 = N1value;
                  updateData();
                });

              } else {
                N1 = false;
              }
              dynamic N2value = onwViewpostionmodal?.data?.metaFields?.n2;
              if (N2value != null && N1value is bool) {
                setState(() {
                  N2 = N2value;
                  updateData();
                });

              } else {
                N2 = false;
              }dynamic N3value = viewcategorywisevieweetailmodal?.data?.metaFields?.n3;
              if (N3value != null && N3value is bool) {
                setState(() {
                  N3 = N3value;
                  updateData();
                });

              } else {
                N3 = false;
              }dynamic E1value = viewcategorywisevieweetailmodal?.data?.metaFields?.e1;
              if (E1value != null && E1value is bool) {
                setState(() {
                  E1= E1value;
                  updateData();
                });

              } else {
                E1 = false;
              }dynamic E2value = viewcategorywisevieweetailmodal?.data?.metaFields?.e2;
              if (E2value != null && E2value is bool) {
                setState(() {
                  E2= E2value;
                  updateData();
                });

              } else {
                E2 = false;
              }dynamic E3value = viewcategorywisevieweetailmodal?.data?.metaFields?.e3;
              if (E3value != null && E3value is bool) {
                setState(() {
                  E3= E3value;
                  updateData();
                });

              } else {
                E3 = false;
              }dynamic W1value = viewcategorywisevieweetailmodal?.data?.metaFields?.w1;
              if (W1value != null && W1value is bool) {
                setState(() {
                  W1= W1value;
                  updateData();
                });

              } else {
                W1 = false;
              }dynamic W2value = viewcategorywisevieweetailmodal?.data?.metaFields?.w2;
              if (W2value != null && W2value is bool) {
                setState(() {
                  W2= W2value;
                  updateData();
                });

              } else {
                W2 = false;
              }dynamic W3value = viewcategorywisevieweetailmodal?.data?.metaFields?.w3;
              if (W3value != null && W3value is bool) {
                setState(() {
                  W3= W3value;
                  updateData();
                });

              } else {
                W3 = false;
              }dynamic SW1value = viewcategorywisevieweetailmodal?.data?.metaFields?.sw1;
              if (SW1value != null && SW1value is bool) {
                setState(() {
                  SW1= SW1value;
                  updateData();
                });

              } else {
                SW1 = false;
              }dynamic SW2value = viewcategorywisevieweetailmodal?.data?.metaFields?.sw2;
              if (SW2value != null && SW2value is bool) {
                setState(() {
                  SW2= SW2value;
                  updateData();
                });

              } else {
                SW2 = false;
              }
              dynamic SW3value = viewcategorywisevieweetailmodal?.data?.metaFields?.sw3;
              if (SW3value != null && SW3value is bool) {
                setState(() {
                  SW3= SW3value;
                  updateData();
                });

              } else {
                SW3 = false;
              }
              dynamic NE1value = viewcategorywisevieweetailmodal?.data?.metaFields?.ne1;
              if (NE1value != null && NE1value is bool) {
                setState(() {
                  NE1= SW3value;
                  updateData();
                });

              } else {
                NE1 = false;
              }
              dynamic NE2value = viewcategorywisevieweetailmodal?.data?.metaFields?.ne2;
              if (NE2value != null && NE2value is bool) {
                setState(() {
                  NE2= NE2value;
                  updateData();
                });
              } else {
                NE2 = false;
              }
              dynamic NE3value = viewcategorywisevieweetailmodal?.data?.metaFields?.ne3;
              if (NE3value != null && NE3value is bool) {
                setState(() {
                  NE3= NE3value;
                  updateData();
                });
              } else {
                NE3 = false;
              }
              dynamic SE1value = viewcategorywisevieweetailmodal?.data?.metaFields?.se1;
              if (SE1value != null && SE1value is bool) {
                setState(() {
                  SE1= SE1value;
                  updateData();
                });
              } else {
                SE1 = false;
              }
              dynamic SE2value = viewcategorywisevieweetailmodal?.data?.metaFields?.se2;
              if (SE2value != null && SE2value is bool) {
                setState(() {
                  SE2= SE2value;
                  updateData();
                });
              } else {
                SE2 = false;
              }
              dynamic SE3value = viewcategorywisevieweetailmodal?.data?.metaFields?.se3;
              if (SE3value != null && SE3value is bool) {
                setState(() {
                  SE3= SE3value;
                  updateData();
                });
              } else {
                SE3 = false;
              }
              dynamic S1value = viewcategorywisevieweetailmodal?.data?.metaFields?.s1;
              if (S1value != null && S1value is bool) {
                setState(() {
                  S1= S1value;
                  updateData();
                });
              } else {
                S1 = false;
              }
              dynamic S2value = viewcategorywisevieweetailmodal?.data?.metaFields?.s2;
              if (S2value != null && S2value is bool) {
                setState(() {
                  S2= S2value;
                  updateData();
                });
              } else {
                S2 = false;
              }
              dynamic S3value = viewcategorywisevieweetailmodal?.data?.metaFields?.s3;
              if (S3value != null && S3value is bool) {
                setState(() {
                  S3= S3value;
                  updateData();
                });
              } else {
                S3 = false;
              }
            });
          } else {
            setState(() {

            });
          }
        });
      } else {
        setState(() {

        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }

  void updateData() {
    data[0] = [
      (N1 ? 4 : 0) + (N2 ? 7 : 0) + (N3 ? 10 : 0),
      (NE1 ? 4 : 0) + (NE2 ? 7 : 0) + (NE3 ? 10 : 0),
      (E1 ? 4 : 0) + (E2 ? 7 : 0) + (E3 ? 10 : 0),
      (SE1 ? 4 : 0) + (SE2 ? 7 : 0) + (SE3 ? 10 : 0),
      (S1 ? 4 : 0) + (S2 ? 7 : 0) + (S3 ? 10 : 0),
      (SW1 ? 4 : 0) + (SW2 ? 7 : 0) + (SW3 ? 10 : 0),
      (W1 ? 4 : 0) + (W2 ? 7 : 0) + (W3 ? 10 : 0),
      (NW1 ? 4 : 0) + (NW2 ? 7 : 0) + (NW3 ? 10 : 0),
    ];
  }


  Widget buildCheckboxRow(String label, List<Widget> checkboxes) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$label",
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "volken"),
            ),
          ],
        ),
        Column(children: checkboxes),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildCheckbox(
      String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? val) {
            onChanged(val!);
          },
        ),
        Text(
          label,
          style: TextStyle(
              letterSpacing: 1,
              color: secondary,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "volken"),
        ),
      ],
    );
  }
}

