import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/Drwer.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Headerwidget.dart';

class AddMarinaScreen extends StatefulWidget {
  const AddMarinaScreen({super.key});

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
  File? selectedimage = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key:_scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body: SingleChildScrollView(
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
                  controller: _pricelebal,
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
              selectedimage == null?Container():SizedBox(height: 1.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                batan(title: "Select Photo", route: ()async{
                  final XFile? photo = await picker.pickImage(
                      source: ImageSource.gallery);
                  setState(() {
                    selectedimage = File(photo!.path);
                    print(selectedimage);
                  });
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
                  keyboardType: TextInputType.text,
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
                  keyboardType: TextInputType.text,
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
                  keyboardType: TextInputType.text,
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
                            SE1 = value!;
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
                  batan(title: "Add Marina", route: (){}, hight: 6.h, width: 70.w, txtsize: 20.sp),
                ],
              ),
              SizedBox(height: 5.h,),


            ],
          ),
        ),
      ),
    );
  }
}
