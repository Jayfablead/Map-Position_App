import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';


class ViewInvoiveScreen extends StatefulWidget {
  const ViewInvoiveScreen({super.key});

  @override
  State<ViewInvoiveScreen> createState() => _ViewInvoiveScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey16 = GlobalKey<ScaffoldState>();
bool isLoading = true;
File? _pickedFile;

class _ViewInvoiveScreenState extends State<ViewInvoiveScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey16,
        drawer: drawer1(),
        body: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            header(
                text: "Itinerary",
                callback1: () {
                  scaffoldKey16.currentState?.openDrawer();
                }),
            SizedBox(height: 1.h),

            Container(
              height: 83.h,
              child: InkWell(
                onTap: () {
                  addcheklistdialog();
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/Upload .png',
                          height: 27.h, color: Colors.blue),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 2.7.w),
                          Text(
                            'Upload Your File / Image',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15.5.sp,
                                fontFamily: 'sofi',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),

          ],
        ),
      );
 
  }

  addcheklistdialog() {
    bool isPhone = MediaQuery.of(context).size.shortestSide < 600;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.grey.shade100,
          child: Stack(
            children: [
              Container(
                  width: 80.w,
                  // height: 70.h,
                  child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                'Add Itinerary File / Image',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontFamily: 'sofi',
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    height: 0.17.h,
                                    letterSpacing: 1),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                    if (result != null) {
                                      setState(() {
                                        _pickedFile = File(result
                                            .files.single.path
                                            .toString());
                                       
                                        Get.back();
                                      });
                                    } else {}
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2.5.w),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                        BorderRadius.circular(25)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.add,
                                          size: 17.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          'Add Your File / Image',
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontFamily: 'sofi',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      ))),
              Positioned(
                  right:isPhone?0:2.w,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(CupertinoIcons.clear_circled_solid,size: 15.sp,)))
            ],
          ),
        );
      },
    );
  }





  
}