import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  String? services;
  String? gas;
  String? TransientStorage;
  String? longtermstorage;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    text: "AddMarina",
                    callback1: () {
                      _scaffoldKeyProductlistpage.currentState?.openDrawer();
                    }),
             SizedBox(height: 2.h,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Marina Description",style: TextStyle(
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
                        return "Please Enter Title";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Title",
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Description";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Description",
                    ),
                  ),
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Marina Price",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                  ],
                ),
                SizedBox(height: 2.h,),
                Text("Price in \$  :-",style: TextStyle(
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
                    controller: _priceindoller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Price";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Price",
                        icon: Icon(
                          Icons.payment,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 2.h,),
                Text("After Price Label :-",style: TextStyle(
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
                    controller: _pricelebal,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter After Price Label";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your After Price Label",
                        icon: Icon(
                          Icons.price_check,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 2.h,),
                Text("Before Price Label :-",style: TextStyle(
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
                    controller: _pricelebal1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Before Price Label";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Before Price Label",
                        icon: Icon(
                          Icons.price_check,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 2.h,),
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
                          child: Text("Selecting a category will make it easier for users to find you Marina in search results.",style: TextStyle(
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
                    hint: Text("Please Select Marina Category",style: TextStyle(color:secondary,fontFamily: "volken",)),

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
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Listing Location",style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "volken")),
                  ],
                ),
                SizedBox(height: 1.h,),
                Text("Address :-",style: TextStyle(
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
                    controller: _address,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Address";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Address",
                        icon: Icon(
                          Icons.home,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("City :-",style: TextStyle(
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
                    controller: _city,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter City";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your City",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Neighborhood :-",style: TextStyle(
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
                    controller: _neighborthood,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Neighborhood";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Neighborhood",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Zipcode :-",style: TextStyle(
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
                    controller: _zipcode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Zipcode";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Zipcode",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("State :-",style: TextStyle(
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
                    controller: _state,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter State";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your State",
                        icon: Icon(
                          Icons.location_city_sharp,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text("Country :-",style: TextStyle(
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
                    controller: _country,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Country";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Enter Your Country",
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Slips";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Minimum Approach Depth";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Minimum Approach Depth";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Minimum Channel Depth";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Mean High Water Clearance";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Max. Vessel LOA";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Max. Slip Length";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Max. Slip Width";
                      }
                      return null;
                    },
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Wind Rose",style: TextStyle(
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
                Text("North (N) : -",style: TextStyle(
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
                        Text("N1",style: TextStyle(
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
                        Text("N2",style: TextStyle(
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
                        Text("N3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),
                SizedBox(height: 1.h,),
                Text("Northeast (NE) : -",style: TextStyle(
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
                        Text("NE1",style: TextStyle(
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
                        Text("NE2",style: TextStyle(
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
                        Text("NE3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),
                SizedBox(height: 1.h,),
                Text("East (E) : -",style: TextStyle(
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
                        Text("E1",style: TextStyle(
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
                        Text("E2",style: TextStyle(
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
                        Text("E3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),SizedBox(height: 1.h,),
                Text("Southeast (SE): -",style: TextStyle(
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
                        Text("SE1",style: TextStyle(
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
                        Text("SE2",style: TextStyle(
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
                        Text("SE3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),SizedBox(height: 1.h,),
                Text("South (S): -",style: TextStyle(
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
                              S1 = value!;
                            });
                          },
                        ),
                        Text("S1",style: TextStyle(
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
                        Text("S2",style: TextStyle(
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
                        Text("S3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),SizedBox(height: 1.h,),
                Text("Southwest (SW): -",style: TextStyle(
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
                        Text("SW1",style: TextStyle(
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
                        Text("SW2",style: TextStyle(
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
                        Text("SW3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),SizedBox(height: 1.h,),
                Text("West (W): -",style: TextStyle(
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
                        Text("W1",style: TextStyle(
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
                        Text("W2",style: TextStyle(
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
                          value: W3,
                          onChanged: (bool? value) {
                            setState(() {
                              W3 = value!;
                            });
                          },
                        ),
                        Text("W3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),SizedBox(height: 1.h,),
                Text("Northwest (NW): -",style: TextStyle(
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
                        Text("NW1",style: TextStyle(
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
                        Text("NW2",style: TextStyle(
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
                        Text("NW3",style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),


                  ],
                ),
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
                    Text("Use your own anchor's",style: TextStyle(
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
                    Text("Fixed Buoys are available",style: TextStyle(
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
                    Text("Fixed mountain wedges available",style: TextStyle(
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
                    Text("Use your own lines ashore",style: TextStyle(
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

                      ],
                    ),

                  ],
                ),
                SizedBox(height: 3.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    batan(title: "Add Marina", route: (){
                      widget.postid==null?castommapposition():updatecasotammarina();
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
        "property_latitude": widget.lat==null?lat1.toString():widget.lat.toString(),
        "property_longitude": widget.lng==null?lng1.toString():widget.lng.toString(),
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
        "property_latitude": widget.lat==null?lat1.toString():widget.lat.toString(),
        "property_longitude": widget.lng==null?lng1.toString():widget.lng.toString(),
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

}

