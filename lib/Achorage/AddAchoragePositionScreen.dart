import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/HomeScreen/HomeScreen.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/AddPositionModal.dart';
import '../Modal/MyMarinaViewModal.dart';
import '../Modal/OnwViewPostionModal.dart';
import '../Modal/UpdateanchorgeModal.dart';
import '../Provider/Authprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:sizer/sizer.dart';

class AddAchoragePositionScreen extends StatefulWidget {
  String? lat;
  String? lng;
  String? postid;

  AddAchoragePositionScreen(
      {super.key, required this.lat, required this.lng, this.postid});

  @override
  State<AddAchoragePositionScreen> createState() =>
      _AddAchoragePositionScreenState();
}

class _AddAchoragePositionScreenState extends State<AddAchoragePositionScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _latitude1 = TextEditingController();

  TextEditingController _comments = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();
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
  bool pontoon = false;
  bool shop = false;
  bool water = false;
  bool beach = false;
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
  List<List<int>> data = [
    [0, 0, 0, 0, 0, 0, 0, 0],
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
  String? thumbnail;
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};

  // void _onMapCreated(GoogleMapController controller) {
  //   _controller = controller;
  // }
  Marker? _marker;
  GoogleMapController? _mapController; // Add this line
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

  void _onTap(LatLng location) {
    setState(() {
      _lastLatitude = location.latitude;
      _lastLongitude = location.longitude;
      _latitude.text = _lastLatitude.toString();
      _latitude1.text = _lastLongitude.toString();
      _marker = Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: 'New Marker',
          snippet:
              'This is a new marker at ${_lastLatitude}, ${_lastLongitude}',
        ),
      );

      // Move the camera to the new marker position
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(location),
      );
    });
  }

  late LatLng _currentPosition1 = LatLng(21.1702, 72.8311);
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
  // List<RadarEntry> getRadarEntries() {
  //   List<RadarEntry> entries = [];
  //
  //   if (NE1) entries.add(RadarEntry(value: 1));
  //   if (NE2) entries.add(RadarEntry(value: 2));
  //   if (NE3) entries.add(RadarEntry(value: 3));
  //   if (N1) entries.add(RadarEntry(value: 4));
  //   if (N2) entries.add(RadarEntry(value: 5));
  //   if (N3) entries.add(RadarEntry(value: 6));
  //   if (E1) entries.add(RadarEntry(value: 7));
  //   if (E2) entries.add(RadarEntry(value: 8));
  //   if (E3) entries.add(RadarEntry(value: 9));
  //   if (SE1) entries.add(RadarEntry(value: 10));
  //   if (SE2) entries.add(RadarEntry(value: 11));
  //   if (SE3) entries.add(RadarEntry(value: 12));
  //   if (S1) entries.add(RadarEntry(value: 13));
  //   if (S2) entries.add(RadarEntry(value: 14));
  //   if (S3) entries.add(RadarEntry(value: 15));
  //   if (SW1) entries.add(RadarEntry(value: 16));
  //   if (SW2) entries.add(RadarEntry(value: 17));
  //   if (SW3) entries.add(RadarEntry(value: 18));
  //   if (W1) entries.add(RadarEntry(value: 19));
  //   if (W2) entries.add(RadarEntry(value: 20));
  //   if (W3) entries.add(RadarEntry(value: 21));
  //   if (NW1) entries.add(RadarEntry(value: 22));
  //   if (NW2) entries.add(RadarEntry(value: 23));
  //   if (NW3) entries.add(RadarEntry(value: 24));
  //
  //   // Ensure there are at least 3 entries
  //   while (entries.length < 3) {
  //     entries.add(RadarEntry(value: 0)); // Adding default 0 values if less than 3
  //   }
  //
  //   return entries;
  // }

  Color getColor(String direction) {
    if (direction == "NE") {
      print("Surat${"NE"}");
      if (NE3) return Color(0xffe69500);
      if (NE2) return Color(0xfff7f700);
      if (NE1) return Color(0xff35ce77);
    }
    if (direction == "N") {
      if (N3) return Color(0xffe69500);
      if (N2) return Color(0xfff7f700);
      if (N1) return Color(0xff35ce77);
    }
    if (direction == "E") {
      if (E3) return Color(0xffe69500);
      if (E2) return Color(0xfff7f700);
      if (E1) return Color(0xff35ce77);
    }
    if (direction == "SE") {
      if (E3) return Color(0xffe69500);
      if (E2) return Color(0xfff7f700);
      if (E1) return Color(0xff35ce77);
    }
    if (direction == "S") {
      print("Surat${"S"}");
      if (E3) return Color(0xffe69500);
      if (E2) return Color(0xfff7f700);
      if (E1) return Color(0xff35ce77);
    }
    if (direction == "SW") {
      if (E3) return Colors.green;
      if (E2) return Color(0xfff7f700);
      if (E1) return Color(0xff35ce77);
    }
    if (direction == "W") {
      if (E3) return Color(0xffe69500);
      if (E2) return Color(0xfff7f700);
      if (E1) return Color(0xff35ce77);
    }
    if (direction == "NW") {
      if (E3) return Color(0xffe69500);
      if (E2) return Color(0xfff7f700);
      if (E1) return Color(0xff35ce77);
    }
    return Color(0xfff7f700);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    anchor = false;
    buoys = false;
    mountain = false;
    ownlines = false;
    sand = false;
    coral = false;
    rocks = false;
    clay = false;
    pano = false;
    groceries = false;
    pharmacy = false;
    alcohol = false;
    restaurant = false;
    pontoon = false;
    shop = false;
    water = false;
    beach = false;
    N1 = false;
    N2 = false;
    N3 = false;
    NE1 = false;
    NE2 = false;
    NE3 = false;
    E1 = false;
    E2 = false;
    E3 = false;
    SE1 = false;
    SE2 = false;
    SE3 = false;
    S1 = false;
    S2 = false;
    S3 = false;
    SW1 = false;
    SW2 = false;
    SW3 = false;
    W1 = false;
    W2 = false;
    W3 = false;
    NW1 = false;
    NW2 = false;
    NW3 = false;
    _latitude.clear();
    _comments.clear();
    _name.clear();
    selectedimage == null;
    getLocation();
    print("widget.postid${widget.postid}");
    widget.postid == null ? "" : viewposition();
    thumbnail = onwViewpostionmodal?.data?.thumbnail?.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(children: [
              SizedBox(
                height: 5.h,
              ),
              header(
                  text: "Anchor",
                  callback1: () {
                    _scaffoldKeyProductlistpage.currentState?.openDrawer();
                  }),
              SizedBox(
                height: 2.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: secondary),
                      controller: _name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter name";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your name",
                          icon: Icon(
                            Icons.email,
                            color: secondary,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text("Listing Location :-",
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
                children: [
                  Container(
                    height: 45.h,
                    width: MediaQuery.of(context).size.width * .95,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12, width: 1.sp)),
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
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>{
                        // Example: Disable all gestures
                        Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer()),
                      }.toSet(),
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
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text("Protection : -",
                      style: TextStyle(
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
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', N2, (val) {
                      setState(() {
                        N2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', N3, (val) {
                      setState(() {
                        N3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  buildCheckboxRow('Northeast (NE)', [
                    buildCheckbox('Some protection', NE1, (val) {
                      setState(() {
                        NE1 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', NE2, (val) {
                      setState(() {
                        NE2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', NE3, (val) {
                      setState(() {
                        NE3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  buildCheckboxRow('East (E)', [
                    buildCheckbox('Some protection', E1, (val) {
                      setState(() {
                        E1 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', E2, (val) {
                      setState(() {
                        E2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', E3, (val) {
                      setState(() {
                        E3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  buildCheckboxRow('Southeast (SE)', [
                    buildCheckbox('Some protection', SE1, (val) {
                      setState(() {
                        SE1 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', SE2, (val) {
                      setState(() {
                        SE2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', SE3, (val) {
                      setState(() {
                        SE3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  buildCheckboxRow('South (S)', [
                    buildCheckbox('Some protection', S1, (val) {
                      setState(() {
                        S1 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', S2, (val) {
                      setState(() {
                        S2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', S3, (val) {
                      setState(() {
                        S3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  buildCheckboxRow('Southwest (SW)', [
                    buildCheckbox('Some protection', SW1, (val) {
                      setState(() {
                        SW1 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', SW2, (val) {
                      setState(() {
                        SW2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', SW3, (val) {
                      setState(() {
                        SW3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  buildCheckboxRow('West (W)', [
                    buildCheckbox('Some protection', W1, (val) {
                      setState(() {
                        W1 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', W2, (val) {
                      setState(() {
                        W2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', W3, (val) {
                      setState(() {
                        W3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  buildCheckboxRow('West (W)', [
                    buildCheckbox('Some protection', NW1, (val) {
                      setState(() {
                        NW1 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Average protection', NW2, (val) {
                      setState(() {
                        NW2 = val;
                        updateData();
                      });
                    }),
                    buildCheckbox('Completely protected', NW3, (val) {
                      setState(() {
                        NW3 = val;
                        updateData();
                      });
                    }),
                  ]),
                  // Repeat for other directions...
                ],
              ),
              // Column(children: [
              //
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("North (N) : -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: N1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 N1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: N2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 N2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: N3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 N3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),
              //   SizedBox(height: 1.h,),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("Northeast (NE) : -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: NE1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 NE1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: NE2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 NE2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: NE3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 NE3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),
              //   SizedBox(height: 1.h,),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("East (E) : -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: E1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 E1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: E2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 E2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: E3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 E3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),SizedBox(height: 1.h,),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("Southeast (SE): -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: SE1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 SE1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: SE2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 SE2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: SE3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 SE3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),SizedBox(height: 1.h,),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("South (S): -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: S1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 S1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: S2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 S2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: S3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 S3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),SizedBox(height: 1.h,),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("Southwest (SW): -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: SW1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 SW1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: SW2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 SW2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: SW3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 SW3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),SizedBox(height: 1.h,),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("West (W): -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: W1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 W1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: W2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 W2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: W3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 W3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),SizedBox(height: 1.h,),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("Northwest (NW): -",style: TextStyle(
              //           letterSpacing: 1,
              //           color: Colors.black,
              //           fontSize: 15.sp,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "volken")),
              //     ],
              //   ),
              //   Column(
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: NW1,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 NW1 = value!;
              //               });
              //             },
              //           ),
              //           Text("Some protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: NW2,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 NW2 = value!;
              //               });
              //             },
              //           ),
              //           Text("Average protection",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: NW3,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 NW3 = value!;
              //               });
              //             },
              //           ),
              //           Text("Completely protected",style: TextStyle(
              //               letterSpacing: 1,
              //               color: secondary,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "volken")),
              //         ],
              //       ),
              //     ],
              //   ),
              //
              // ]),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Features:- ",
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
              InkWell(
                onTap: () {
                  setState(() {
                    anchor = !anchor; // Change to any color you desire
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: anchor ? Colors.black : Colors.white,
                      border: Border.all(color: secondary1, width: 1.sp)),
                  child: Row(
                    children: [
                      Container(
                        height: 15.w,
                        width: 15.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/anchor.jpg",
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.asset(Default_Profile),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
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
                    buoys = !buoys; // Change to any color you desire
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: buoys ? Colors.black : Colors.white,
                      border: Border.all(color: secondary2, width: 1.sp)),
                  child: Row(
                    children: [
                      Container(
                        height: 15.w,
                        width: 15.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/buoys.jpg",
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    Center(child: CircularProgressIndicator()),
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
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mountain ? Colors.black : Colors.white,
                      border: Border.all(color: secondary3, width: 1.sp)),
                  child: Row(
                    children: [
                      Container(
                        height: 15.w,
                        width: 15.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/mountain.png",
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.asset(Default_Profile),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      SizedBox(
                        width: 75.w,
                        child: Text(
                          "Fixed Mountain Wedges available",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: mountain ? Colors.white : secondary,
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
                    ownlines = !ownlines; // Change to any color you desire
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ownlines ? Colors.black : Colors.white,
                      border: Border.all(color: secondary4, width: 1.sp)),
                  child: Row(
                    children: [
                      Container(
                        height: 15.w,
                        width: 15.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/ashore.jpg",
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.asset(Default_Profile),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Use Your Own Lines Ashore",
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13.sp,
                          color: ownlines ? Colors.white : secondary,
                          fontWeight: FontWeight.w500,
                          fontFamily: "volken",
                          letterSpacing: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Conditions:- ",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                    ],
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: sand ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Sand.jpg",
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Sand",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: sand ? Colors.white : secondary,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: pano ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Mud.jpg",
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Mud",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: pano ? Colors.white : secondary,
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
                                clay = !clay; // Change to any color you desire
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clay ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Clay.jpg",
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Clay",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: clay ? Colors.white : secondary,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: coral ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Coral.png",
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Coral",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: coral ? Colors.white : secondary,
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
                        width: 7.w,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: rocks ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/themes/wpstate-child/img/conditions/Rocks.jpg",
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Rocks",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: rocks ? Colors.white : secondary,
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
                height: 2.h,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Facilities:- ",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                    ],
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      groceries ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-groceries-100.png",
                                        color: groceries
                                            ? Colors.white
                                            : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Groceries",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: groceries
                                          ? Colors.white
                                          : Colors.black,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: pharmacy ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-pharmacy-100.png",
                                        color: pharmacy
                                            ? Colors.white
                                            : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Pharmacy",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: pharmacy
                                          ? Colors.white
                                          : Colors.black,
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
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                alcohol = !alcohol;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: alcohol ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-alcohol-100.png",
                                        color: alcohol
                                            ? Colors.white
                                            : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Alcohol",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color:
                                          alcohol ? Colors.white : Colors.black,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      restaurant ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-restaurant-100.png",
                                        color: restaurant
                                            ? Colors.white
                                            : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Restaurant",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color:
                                          restaurant ? Colors.white : secondary,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: water ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/03/icons8-water-100.png",
                                        color:
                                            water ? Colors.white : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Water",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: water ? Colors.white : secondary,
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
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                beach =
                                    !beach; // Change to any color you desire
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: beach ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/04/icons8-beach-100.png",
                                        color:
                                            beach ? Colors.white : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Beach",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: beach ? Colors.white : secondary,
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
                                pontoon = !pontoon;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: pontoon ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/04/icons8-pontoon-100.png",
                                        color: pontoon
                                            ? Colors.white
                                            : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Pontoon",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color:
                                          pontoon ? Colors.white : Colors.black,
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
                        width: 7.w,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                shop = !shop; // Change to any color you desire
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: shop ? Colors.black : Colors.white,
                                  border: Border.all(
                                      color: secondary1, width: 1.sp)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.w,
                                    width: 25.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(00),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://boatposition.fableadtechnolabs.com/wp-content/uploads/2024/04/icons8-shop-100.png",
                                        color:
                                            shop ? Colors.white : Colors.black,
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
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Shop",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      color: shop ? Colors.white : secondary,
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

              Column(children: [
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      width: MediaQuery.of(context).size.width,
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
              ]),
              Column(children: [
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    resultList1 == null || resultList1 == ""
                        ? Container()
                        : Column(
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
                                                  imagePaths.addAll(resultList!
                                                      .map((file) => file.path)
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
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image.file(
                                                          selectedImages[index],
                                                          height: 60.h,
                                                          width: 70.w,
                                                          fit: BoxFit.cover))),
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
                                              resultList1 = await ImagePicker()
                                                  .pickMultiImage();
                                              if (resultList1 != null) {
                                                if (resultList1!.length +
                                                        selectedImages.length >
                                                    maxImageLimit) {
                                                  // Handle maximum image limit exceeded
                                                  buildErrorDialog(context, "",
                                                      "You selected more than 9 images");
                                                } else {
                                                  setState(() {
                                                    print(selectedImages);
                                                    selectedImages.addAll(
                                                        resultList1!
                                                            .map((XFile file) =>
                                                                File(file.path))
                                                            .toList());
                                                    imagePaths = resultList1!
                                                        .map(
                                                            (file) => file.path)
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
                                                      BorderRadius.circular(15),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                batan(
                                    title: "Selcted Photo",
                                    route: () async {
                                      resultList1 =
                                          await ImagePicker().pickMultiImage();
                                      if (resultList1 != null) {
                                        if (resultList1!.length +
                                                selectedImages.length >
                                            maxImageLimit) {
                                          // Handle maximum image limit exceeded
                                          buildErrorDialog(context, "",
                                              "You selected more than 9 images");
                                        } else {
                                          setState(() {
                                            print(selectedImages);
                                            selectedImages.addAll(resultList1!
                                                .map((XFile file) =>
                                                    File(file.path))
                                                .toList());
                                            imagePaths = resultList1!
                                                .map((file) => file.path)
                                                .toList();
                                          });
                                        }
                                      }
                                      // final XFile? photo =
                                      // await picker.pickImage(
                                      //     source: ImageSource.gallery);
                                      // setState(() {
                                      //   selectedimage = File(photo!.path);
                                      //   print(selectedimage);
                                      // });
                                    },
                                    hight: 6.h,
                                    width: 40.w,
                                    txtsize: 15.sp),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]),

              SizedBox(
                height: 3.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  batan(
                      title: "Submit",
                      route: () {
                        widget.postid == null
                            ? addanchorage()
                            : updateancorage();
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
        ),
      ),
    );
  }

  //AddAncregenewposition
  addanchorage() async {
    if (_formKey.currentState!.validate()) {
      print(selectedimage?.path);
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['user_id'] = (loginmodal?.userId).toString();
      data['positionName'] = _name.text.trim().toString();
      data['comment'] = _comments.text.trim().toString();
      data['m_lat'] = _latitude.text.toString();
      data['m_lng'] = _latitude1.text.toString();
      data['n1'] = N1.toString();
      data['n2'] = N2.toString();
      data['n3'] = N3.toString();
      data['ne1'] = NE1.toString();
      data['ne2'] = NE2.toString();
      data['ne3'] = NE3.toString();
      data['e1'] = E1.toString();
      data['e2'] = E2.toString();
      data['e3'] = E3.toString();
      data['se1'] = SE1.toString();
      data['se2'] = SE2.toString();
      data['se3'] = SE3.toString();
      data['s1'] = S1.toString();
      data['s2'] = S2.toString();
      data['s3'] = S3.toString();
      data['sw1'] = SW1.toString();
      data['sw2'] = SW2.toString();
      data['sw3'] = SW3.toString();
      data['w1'] = W1.toString();
      data['w2'] = W2.toString();
      data['w3'] = W3.toString();
      data['nw1'] = NW1.toString();
      data['nw2'] = NW2.toString();
      data['nw3'] = NW3.toString();
      data['own_anchor'] = anchor.toString();
      data['buoys'] = buoys.toString();
      data['mountain_wedges'] = mountain.toString();
      data['own_lines'] = ownlines.toString();
      data['sand'] = sand.toString();
      data['mud'] = pano.toString();
      data['clay'] = clay.toString();
      data['coral'] = coral.toString();
      data['rocks'] = rocks.toString();
      data['groceries'] = groceries.toString();
      data['water'] = water.toString();
      data['alcohol'] = alcohol.toString();
      data['pharmacy'] = pharmacy.toString();
      data['restaurant'] = restaurant.toString();
      data['beach'] = beach.toString();
      data['pontoon'] = pontoon.toString();
      data['shop'] = shop.toString();
      print(imagePaths);
      data['upload_pictures[]'] = jsonEncode(imagePaths);
      print("Printapivalue${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider()
              .maltiplephotoaddapi(data, imagePaths)
              .then((response) async {
            addpositionmodal =
                AddPositionModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 &&
                addpositionmodal?.success == true) {

              print("admin chalu karo bhai");
              EasyLoading.showSuccess(addpositionmodal?.message ?? "");
              Get.to(HomeScreen());
              ;
            } else {
              EasyLoading.showError(addpositionmodal?.message ?? "");
              setState(() {});
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }

  //updateAncregenewposition
  updateancorage() async {
    if (_formKey.currentState!.validate()) {
      print(selectedimage?.path);
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['post_id'] = widget.postid.toString();
      data['positionName'] =
          _name.text == null ? "" : _name.text.trim().toString();
      data['comment'] =
          _comments.text == null ? "" : _comments.text.trim().toString();
      data['m_lat'] = _latitude.text.toString();
      data['m_lng'] = _latitude1.text.toString();
      data['n1'] = N1.toString();
      data['n2'] = N2.toString();
      data['n3'] = N3.toString();
      data['ne1'] = NE1.toString();
      data['ne2'] = NE2.toString();
      data['ne3'] = NE3.toString();
      data['e1'] = E1.toString();
      data['e2'] = E2.toString();
      data['e3'] = E3.toString();
      data['se1'] = SE1.toString();
      data['se2'] = SE2.toString();
      data['se3'] = SE3.toString();
      data['s1'] = S1.toString();
      data['s2'] = S2.toString();
      data['s3'] = S3.toString();
      data['sw1'] = SW1.toString();
      data['sw2'] = SW2.toString();
      data['sw3'] = SW3.toString();
      data['w1'] = W1.toString();
      data['w2'] = W2.toString();
      data['w3'] = W3.toString();
      data['nw1'] = NW1.toString();
      data['nw2'] = NW2.toString();
      data['nw3'] = NW3.toString();
      data['own_anchor'] = anchor.toString();
      data['buoys'] = buoys.toString();
      data['mountain_wedges'] = mountain.toString();
      data['own_lines'] = ownlines.toString();
      data['sand'] = sand.toString();
      data['mud'] = pano.toString();
      data['clay'] = clay.toString();
      data['coral'] = coral.toString();
      data['rocks'] = rocks.toString();
      data['groceries'] = groceries.toString();
      data['water'] = water.toString();
      data['alcohol'] = alcohol.toString();
      data['pharmacy'] = pharmacy.toString();
      data['restaurant'] = restaurant.toString();
      print(imagePaths);
      data['upload_pictures[]'] = jsonEncode(imagePaths);
      print("Printapivalue${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider()
              .maltiplephotoaddapi(data, imagePaths)
              .then((response) async {
            updateanchorgemodal =
                UpdateanchorgeModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 &&
                updateanchorgemodal?.success == true) {
              print("admin chalu karo bhai");
              EasyLoading.showSuccess(updateanchorgemodal?.message ?? "");
              Get.to(HomeScreen());
            } else {
              EasyLoading.showError(updateanchorgemodal?.message ?? "");
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
          onwViewpostionmodal =
              OnwViewPostionModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              onwViewpostionmodal?.success == true) {
            print("anchioirapicall");
            setState(() {
              _name.text = onwViewpostionmodal?.data?.title == "" ||
                      onwViewpostionmodal?.data?.title == null
                  ? ""
                  : (onwViewpostionmodal?.data?.title).toString();
              _comments.text = onwViewpostionmodal?.data?.content == "" ||
                      onwViewpostionmodal?.data?.content == null
                  ? ""
                  : (onwViewpostionmodal?.data?.content).toString();
              _latitude1.text = onwViewpostionmodal?.data?.longitude == "" ||
                      onwViewpostionmodal?.data?.longitude == null
                  ? ""
                  : (onwViewpostionmodal?.data?.longitude).toString();
              _latitude.text = onwViewpostionmodal?.data?.latitude == "" ||
                      onwViewpostionmodal?.data?.latitude == null
                  ? ""
                  : (onwViewpostionmodal?.data?.latitude).toString();

              dynamic waterValue = onwViewpostionmodal?.data?.metaFields?.water;
              if (waterValue != null && waterValue is bool) {
                setState(() {
                  water = waterValue;
                });
              } else {
                water = false;
              }
              dynamic rocksvalue = onwViewpostionmodal?.data?.metaFields?.rocks;
              if (rocksvalue != null && rocksvalue is bool) {
                setState(() {
                  rocks = rocksvalue;
                });
              } else {
                rocks = false;
              }
              dynamic coralvalue = onwViewpostionmodal?.data?.metaFields?.coral;
              if (coralvalue != null && coralvalue is bool) {
                setState(() {
                  coral = coralvalue;
                });
              } else {
                coral = false;
              }
              dynamic clayvalue = onwViewpostionmodal?.data?.metaFields?.clay;
              if (clayvalue != null && clayvalue is bool) {
                setState(() {
                  clay = clayvalue;
                });
              } else {
                clay = false;
              }
              dynamic sandvalue = onwViewpostionmodal?.data?.metaFields?.sand;
              if (sandvalue != null && sandvalue is bool) {
                setState(() {
                  sand = sandvalue;
                });
              } else {
                sand = false;
              }
              dynamic buoysvalue = onwViewpostionmodal?.data?.metaFields?.buoys;
              if (buoysvalue != null && buoysvalue is bool) {
                setState(() {
                  buoys = buoysvalue;
                });
              } else {
                buoys = false;
              }
              dynamic restaurantsvalue =
                  onwViewpostionmodal?.data?.metaFields?.restaurant;
              if (restaurantsvalue != null && restaurantsvalue is bool) {
                setState(() {
                  restaurant = restaurantsvalue;
                });
              } else {
                restaurant = false;
              }
              dynamic alcoholvalue =
                  onwViewpostionmodal?.data?.metaFields?.alcohol;
              if (alcoholvalue != null && alcoholvalue is bool) {
                setState(() {
                  alcohol = alcoholvalue;
                });
              } else {
                alcohol = false;
              }
              dynamic pharmacyvalue =
                  onwViewpostionmodal?.data?.metaFields?.pharmacy;
              if (pharmacyvalue != null && pharmacyvalue is bool) {
                setState(() {
                  pharmacy = pharmacyvalue;
                });
              } else {
                pharmacy = false;
              }
              dynamic groceriesvalue =
                  onwViewpostionmodal?.data?.metaFields?.groceries;
              if (groceriesvalue != null && groceriesvalue is bool) {
                setState(() {
                  groceries = groceriesvalue;
                });
              } else {
                groceries = false;
              }
              dynamic mountainvalue =
                  onwViewpostionmodal?.data?.metaFields?.mountainWedges;
              if (mountainvalue != null && mountainvalue is bool) {
                setState(() {
                  mountain = mountainvalue;
                });
              } else {
                mountain = false;
              }
              dynamic NW3value = onwViewpostionmodal?.data?.metaFields?.nw3;
              if (NW3value != null && NW3value is bool) {
                setState(() {
                  NW3 = NW3value;
                  updateData();
                });
              } else {
                NW3 = false;
              }
              dynamic NW1value = onwViewpostionmodal?.data?.metaFields?.nw1;
              if (NW1value != null && NW1value is bool) {
                setState(() {
                  NW1 = NW1value;
                  updateData();
                });
              } else {
                NW1 = false;
              }
              dynamic NW2value = onwViewpostionmodal?.data?.metaFields?.nw2;
              if (NW2value != null && NW2value is bool) {
                setState(() {
                  NW2 = NW1value;
                  updateData();
                });
              } else {
                NW2 = false;
              }
              dynamic N1value = onwViewpostionmodal?.data?.metaFields?.n1;
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
              }
              dynamic N3value = onwViewpostionmodal?.data?.metaFields?.n3;
              if (N3value != null && N3value is bool) {
                setState(() {
                  N3 = N3value;
                  updateData();
                });
              } else {
                N3 = false;
              }
              dynamic E1value = onwViewpostionmodal?.data?.metaFields?.e1;
              if (E1value != null && E1value is bool) {
                setState(() {
                  E1 = E1value;
                  updateData();
                });
              } else {
                E1 = false;
              }
              dynamic E2value = onwViewpostionmodal?.data?.metaFields?.e2;
              if (E2value != null && E2value is bool) {
                setState(() {
                  E2 = E2value;
                  updateData();
                });
              } else {
                E2 = false;
              }
              dynamic E3value = onwViewpostionmodal?.data?.metaFields?.e3;
              if (E3value != null && E3value is bool) {
                setState(() {
                  E3 = E3value;
                  updateData();
                });
              } else {
                E3 = false;
              }
              dynamic W1value = onwViewpostionmodal?.data?.metaFields?.w1;
              if (W1value != null && W1value is bool) {
                setState(() {
                  W1 = W1value;
                  updateData();
                });
              } else {
                W1 = false;
              }
              dynamic W2value = onwViewpostionmodal?.data?.metaFields?.w2;
              if (W2value != null && W2value is bool) {
                setState(() {
                  W2 = W2value;
                  updateData();
                });
              } else {
                W2 = false;
              }
              dynamic W3value = onwViewpostionmodal?.data?.metaFields?.w3;
              if (W3value != null && W3value is bool) {
                setState(() {
                  W3 = W3value;
                  updateData();
                });
              } else {
                W3 = false;
              }
              dynamic SW1value = onwViewpostionmodal?.data?.metaFields?.sw1;
              if (SW1value != null && SW1value is bool) {
                setState(() {
                  SW1 = SW1value;
                  updateData();
                });
              } else {
                SW1 = false;
              }
              dynamic SW2value = onwViewpostionmodal?.data?.metaFields?.sw2;
              if (SW2value != null && SW2value is bool) {
                setState(() {
                  SW2 = SW2value;
                  updateData();
                });
              } else {
                SW2 = false;
              }
              dynamic SW3value = onwViewpostionmodal?.data?.metaFields?.sw3;
              if (SW3value != null && SW3value is bool) {
                setState(() {
                  SW3 = SW3value;
                  updateData();
                });
              } else {
                SW3 = false;
              }
            });
          } else {
            setState(() {});
          }
        });
      } else {
        setState(() {});
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }

  void updateData() {
    data[0] = [
      (N1 ? 3 : 0) + (N2 ? 3 : 0) + (N3 ? 4 : 0),
      (NE1 ? 3 : 0) + (NE2 ? 3 : 0) + (NE3 ? 4 : 0),
      (E1 ? 3 : 0) + (E2 ? 3 : 0) + (E3 ? 4 : 0),
      (SE1 ? 3 : 0) + (SE2 ? 3 : 0) + (SE3 ? 4 : 0),
      (S1 ? 3 : 0) + (S2 ? 3 : 0) + (S3 ? 4 : 0),
      (SW1 ? 3 : 0) + (SW2 ? 3 : 0) + (SW3 ? 4 : 0),
      (W1 ? 3 : 0) + (W2 ? 3 : 0) + (W3 ? 4 : 0),
      (NW1 ? 3 : 0) + (NW2 ? 3 : 0) + (NW3 ? 4 : 0),
    ];
  }

  Widget buildCheckboxRow(String label, List<Widget> checkboxes) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$label: -",
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

  Widget buildCheckbox(String label, bool value, Function(bool) onChanged) {
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
