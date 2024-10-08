import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/buildErrorDialog.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Modal/AddOtherPositionModal.dart';
import '../Modal/AddViewOtherModal.dart';
import '../Modal/UpdateOtherPositionModal.dart';
import '../Provider/Authprovider.dart';

class AddOtherPositionScreen extends StatefulWidget {
  String? lat;
  String? lng;
  String? postid;
  AddOtherPositionScreen({super.key,required this.lat,required this.lng,this.postid});

  @override
  State<AddOtherPositionScreen> createState() => _AddOtherPositionScreenState();
}

class _AddOtherPositionScreenState extends State<AddOtherPositionScreen> {
  TextEditingController  _name =TextEditingController();
  TextEditingController  _comments =TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =GlobalKey<ScaffoldState>();
  double? lat1,lng1;
  Color secondary1 = Color(0xff808080); // Initial color for the first InkWell
  Color secondary2 = Color(0xff808080);
  Color secondary3 = Color(0xff808080);
  Color secondary4 = Color(0xff808080);
  bool anchor=false;
  bool buoys=false;
  bool mountain=false;
  bool ownlines=false;
  bool sand=false;
  bool coral=false;
  bool rocks=false;
  bool clay=false;
  bool pano=false;
  bool groceries=false;
  bool pharmacy=false;
  bool alcohol=false;
  bool restaurant=false;
  bool water=false;
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
  ImagePicker picker = ImagePicker();
  List<XFile>? resultList;
  List<XFile>? resultList1;
  List<File> selectedImages = [];
  List<String> imagePaths = [];
  // List<XFile> imagesList = <XFile>[];
  String _error = 'No Error Dectected';
  List<String> imageNames = [];
  ImagePicker _picker = ImagePicker();
  int maxImageLimit = 9;
  File? selectedimage;
  List<String> networkImageUrls = [];
  final _formKey = GlobalKey<FormState>();
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
      lat1=lat;
      lng1=long;

    });
  }
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
    anchor=false;
    buoys=false;
    mountain=false;
    ownlines=false;
    sand=false;
    coral=false;
    rocks=false;
    clay=false;
    pano=false;
    groceries=false;
    pharmacy=false;
    alcohol=false;
    restaurant=false;
    water=false;
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
    _name.clear();
    _comments.clear();
    selectedImages == null;
    selectedimage == null;
    _latitude.clear();
    _latitude1.clear();
    getLocation();
    print("widget.postid${widget.postid}");
    widget.postid==null?"":viewposition();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body:Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  header(
                      text: "Other",
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

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Text("Description :- ",
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
                          maxLines: 8,
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
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                // InkWell(
                                //   onTap: () async {
                                //     resultList1 =
                                //     await ImagePicker()
                                //         .pickMultiImage();
                                //     if (resultList1 != null) {
                                //       if (resultList1!.length +
                                //           selectedImages
                                //               .length >
                                //           maxImageLimit) {
                                //         // Handle maximum image limit exceeded
                                //         buildErrorDialog(context,
                                //             "", "You selected more than 9 images");
                                //       } else {
                                //         setState(() {
                                //           print(selectedImages);
                                //           selectedImages.addAll(
                                //               resultList1!
                                //                   .map((XFile
                                //               file) =>
                                //                   File(file
                                //                       .path))
                                //                   .toList());
                                //           imagePaths = resultList1!
                                //               .map((file) =>
                                //           file.path)
                                //               .toList();
                                //         });
                                //       }
                                //     }
                                //     // final XFile? photo =
                                //     // await picker.pickImage(
                                //     //     source: ImageSource.gallery);
                                //     // setState(() {
                                //     //   selectedimage = File(photo!.path);
                                //     //   print(selectedimage);
                                //     // });
                                //   },
                                //   child: Container(
                                //     width: 18.w,
                                //     height: 18.w,
                                //     decoration: BoxDecoration(
                                //         borderRadius:
                                //         BorderRadius.circular(100),
                                //         color: Colors.black),
                                //     child:  Text("Selcted Photo",
                                //         style: TextStyle(
                                //             letterSpacing: 1,
                                //             color: blackback,
                                //             fontSize: 14.sp,
                                //             fontWeight: FontWeight.normal,
                                //             fontFamily: "volken"))
                                //   ),
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    batan(
                                        title: "Selcted Photo",
                                        route: () async{
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
                            // Column(
                            //   children: [
                            //     InkWell(
                            //       onTap: () async {
                            //
                            //         final XFile? photo =
                            //         await picker.pickImage(
                            //             source: ImageSource.camera);
                            //         setState(() {
                            //           selectedimage = File(photo!.path);
                            //           print(selectedimage);
                            //         });
                            //       },
                            //       child: Container(
                            //         width: 18.w,
                            //         height: 18.w,
                            //         decoration: BoxDecoration(
                            //             borderRadius:
                            //             BorderRadius.circular(100),
                            //             color: Colors.black),
                            //         child: Icon(
                            //           Icons.camera_alt,
                            //           size: 20.sp,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 1.h,
                            //     ),
                            //     Text("Camera",
                            //         style: TextStyle(
                            //             letterSpacing: 1,
                            //             color: blackback,
                            //             fontSize: 14.sp,
                            //             fontWeight: FontWeight.normal,
                            //             fontFamily: "volken"))
                            //   ],
                            // )
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
                            widget.postid==null?addother(): updatepositionother();
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
  //newaddotherpostion
  addother() async {
    if (_formKey.currentState!.validate()) {
      print(selectedimage?.path);
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['user_id'] = (loginmodal?.userId).toString();
      data['positionName'] = _name.text.trim().toString();
      data['comment'] = _comments.text.trim().toString();
      data['m_lat'] =_latitude.text.toString();
      data['m_lng'] =_latitude1.text.toString();
      data['category'] = "Other";
      print(imagePaths);
      data['upload_pictures'] =jsonEncode(imagePaths);
      print("Printapivalue${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().addotherpositionapi(data,imagePaths).then((response) async {
            addotherpositionmodal =
                AddOtherPositionModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && addotherpositionmodal?.success==true) {
              print("admin chalu karo bhai");
              EasyLoading.showSuccess(addotherpositionmodal?.message ?? "");
              Get.to(HomeScreen());
              ;
            } else {
              EasyLoading.showError(addotherpositionmodal?.message ?? "");
              setState(() {
              });
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
  //updateotherposition
  updatepositionother() async {
    if (_formKey.currentState!.validate()) {
      print(selectedimage?.path);
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['post_id'] = widget.postid.toString();
      data['positionName'] = _name.text.trim().toString();
      data['comment'] = _comments.text.trim().toString();
      data['m_lat'] = _latitude.text.toString();
      data['m_lng'] = _latitude1.text.toString();
      data['category'] = "Other";
      print(imagePaths);
      data['upload_pictures[]'] =jsonEncode(imagePaths);
      print("Printapivalue${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().updateotherapi(data,imagePaths).then((response) async {
            updateotherpositionmodal =
                UpdateOtherPositionModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && updateotherpositionmodal?.success==true) {
              print("admin chalu karo bhai");
              EasyLoading.showSuccess(updateotherpositionmodal?.message ?? "");
              Get.to(HomeScreen());
              ;
            } else {
              EasyLoading.showError(updateotherpositionmodal?.message ?? "");
              setState(() {
              });
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
    data['post_id'] =widget.postid.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewsinganalpositionviewapi(data).then((response) async {
          addviewothermodal =
              AddViewOtherModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && addviewothermodal?.success == true) {
            _name.text=addviewothermodal?.data?.title==""||addviewothermodal?.data?.title==null?"":addviewothermodal?.data?.title ?? "";
            _comments.text=addviewothermodal?.data?.content==""||addviewothermodal?.data?.content==null?"":addviewothermodal?.data?.content ?? "";
            _latitude1.text=addviewothermodal?.data?.longitude==""||addviewothermodal?.data?.longitude==null?"":addviewothermodal?.data?.longitude ?? "";
            _latitude.text=addviewothermodal?.data?.latitude==""||addviewothermodal?.data?.latitude==null?"":addviewothermodal?.data?.latitude ?? "";

            print("warningapicall");

            setState(() {

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
}
