import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/HomeScreen/HomeScreen.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/AddPositionModal.dart';
import '../Provider/Authprovider.dart';

class AddAchoragePositionScreen extends StatefulWidget {
  String? lat;
  String? lng;
  AddAchoragePositionScreen({super.key,required this.lat,required this.lng});

  @override
  State<AddAchoragePositionScreen> createState() => _AddAchoragePositionScreenState();
}

class _AddAchoragePositionScreenState extends State<AddAchoragePositionScreen> {
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
  List<XFile> imagesList = <XFile>[];
  String _error = 'No Error Dectected';
  List<String> imageNames = [];
  ImagePicker _picker = ImagePicker();
  int maxImageLimit = 9;
  File? selectedimage;
  List<String> networkImageUrls = [];
  final _formKey = GlobalKey<FormState>();
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
            padding:EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
                children: [
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
                        anchor=!anchor;// Change to any color you desire
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: anchor
                              ? Colors.black
                              : Colors.white,
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

                              color: anchor
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
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        buoys=!buoys; // Change to any color you desire
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buoys
                              ? Colors.black
                              : Colors.white,
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
                              color: buoys
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
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        mountain=!mountain;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: mountain
                              ? Colors.black
                              : Colors.white,
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
                                color: mountain
                                    ? Colors.white
                                    : secondary,
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
                        ownlines=!ownlines; // Change to any color you desire
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ownlines
                              ? Colors.black
                              : Colors.white,
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
                              color: ownlines
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
                                    sand=!sand;
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
                                    pano=!pano;
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
                                    clay=!clay; // Change to any color you desire
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
                                    coral=!coral;
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
                            width:10.w,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    rocks=!rocks;
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
                                    groceries=!groceries; // Change to any color you desire
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color:groceries
                                          ? Colors.black
                                          : Colors.white ,
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
                                    pharmacy=!pharmacy; // Change to any color you desire
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color:pharmacy
                                          ? Colors.black
                                          : Colors.white ,
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
                                    alcohol=!alcohol;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color:alcohol
                                          ? Colors.black
                                          : Colors.white ,
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
                                    restaurant=!restaurant;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color:restaurant
                                          ? Colors.black
                                          : Colors.white ,
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
                            width: 9.5.w,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    water=!water; // Change to any color you desire
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color:water
                                          ? Colors.black
                                          : Colors.white ,
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
                  Column(children: [
                    SizedBox(
                      height: 2.h,
                    ),




                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("North (N) : -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Northeast (NE) : -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("East (E) : -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Southeast (SE): -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("South (S): -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Southwest (SW): -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("West (W): -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Northwest (NW): -",style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                      ],
                    ),
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
                      title: "Save Next",
                      route: () {
                        addanchorage();
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
  addanchorage() async {
    if (_formKey.currentState!.validate()) {
      print(selectedimage?.path);
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['user_id'] = (loginmodal?.userId).toString();
      data['positionName'] = _name.text.trim().toString();
      data['comment'] = _comments.text.trim().toString();
      data['m_lat'] = widget.lat.toString();
      data['m_lng'] = widget.lng.toString();
      data['n1'] =N1.toString();
      data['n2'] =N2.toString();
      data['n3'] =N3.toString();
      data['ne1'] =NE1.toString();
      data['ne2'] =NE2.toString();
      data['ne3'] =NE3.toString();
      data['e1'] =E1.toString();
      data['e2'] =E2.toString();
      data['e3'] =E3.toString();
      data['se1'] =SE1.toString();
      data['se2'] =SE2.toString();
      data['se3'] =SE3.toString();
      data['s1'] =S1.toString();
      data['s2'] =S2.toString();
      data['s3'] =S3.toString();
      data['sw1'] =SW1.toString();
      data['sw2'] =SW2.toString();
      data['sw3'] =SW3.toString();
      data['w1'] =W1.toString();
      data['w2'] =W2.toString();
      data['w3'] =W3.toString();
      data['nw1'] =NW1.toString();
      data['nw2'] =NW2.toString();
      data['nw3'] =NW3.toString();
      data['own_anchor'] =anchor.toString();
      data['buoys'] =buoys.toString();
      data['mountain_wedges'] =mountain.toString();
      data['own_lines'] = ownlines.toString();
      data['sand'] =sand.toString();
      data['mud'] =pano.toString();
      data['clay'] =clay.toString();
      data['coral'] =coral.toString();
      data['rocks'] =rocks.toString();
      data['groceries'] =groceries.toString();
      data['water'] =water.toString();
      data['alcohol'] =alcohol.toString();
      data['pharmacy'] =pharmacy.toString();
      data['restaurant'] =restaurant.toString();
      print(imagePaths);
      data['upload_pictures[]'] =jsonEncode(imagePaths);
      print("Printapivalue${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().maltiplephotoaddapi(data,imagePaths).then((response) async {
            addpositionmodal =
                AddPositionModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && addpositionmodal?.success==true) {
              print("admin chalu karo bhai");
              EasyLoading.showSuccess(addpositionmodal?.message ?? "");
              Get.to(HomeScreen());
              ;
            } else {
              EasyLoading.showError(addpositionmodal?.message ?? "");
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

  }
  // Scessfully() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //           insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           // backgroundColor: Colors.transparent,
  //           child: SingleChildScrollView(
  //             child: Column(mainAxisSize: MainAxisSize.min, children: [
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                 // height:  MediaQuery.of(context).size.height,
  //                 width: MediaQuery.of(context).size.width,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   color: bgcolor,
  //                 ),
  //                 child: Column(children: [
  //                   SizedBox(
  //                     height: 2.h,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                         height: 7.w,
  //                         width: 7.w,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(100),
  //                             color: blackback),
  //                         child: InkWell(
  //                             onTap: () {
  //                               Get.back();
  //                             },
  //                             child: Icon(
  //                               Icons.close,
  //                               color: Colors.white,
  //                               size: 17.sp,
  //                             )),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 2.h,
  //                   ),
  //                   Column(
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Container(
  //                             width: 20.w,
  //                             height: 20.w,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(100),
  //                               color: Colors.black,
  //                             ),
  //                             child: Icon(
  //                               Icons.check_circle,
  //                               color: Colors.white,
  //                               size: 20.sp,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 2.h,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text("Well Done!",
  //                               style: TextStyle(
  //                                   letterSpacing: 1,
  //                                   color: Colors.black,
  //                                   fontSize: 15.sp,
  //                                   fontWeight: FontWeight.bold,
  //                                   fontFamily: "volken")),
  //                           SizedBox(
  //                             height: 2.h,
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 1.h,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text("Position Successfully Save Nextd",
  //                               style: TextStyle(
  //                                   letterSpacing: 1,
  //                                   color: Colors.black,
  //                                   fontSize: 15.sp,
  //                                   fontWeight: FontWeight.normal,
  //                                   fontFamily: "volken")),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 3.h,
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       batan(
  //                           title: "Save Next",
  //                           route: () {
  //                             Get.back();
  //                           },
  //                           hight: 6.h,
  //                           width: 40.w,
  //                           txtsize: 15.sp),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 3.h,
  //                   ),
  //                 ]),
  //               ),
  //             ]),
  //           ));
  //     },
  //   );
  // }


