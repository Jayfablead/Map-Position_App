import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();

  ImagePicker picker = ImagePicker();
  File? selectedimage = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Boxbg,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  header(
                      text: "Edit Profile",
                      callback1: () {
                        _scaffoldKeyProductlistpage.currentState?.openDrawer();
                      }),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
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
                              ? Image.file(selectedimage!)
                              : CachedNetworkImage(
                                  imageUrl:
                                      'https://i.pinimg.com/originals/51/e0/d5/51e0d5aa27808ce689e3dd5a5cd7685a.png',
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                          CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Default_Profile,
                                          fit: BoxFit.cover),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Henry Matavic",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: primary,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      batan(
                          title: "Upload Photo",
                          route: () async {
                            final XFile? photo = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              selectedimage = File(photo!.path);
                              print(selectedimage);
                            });
                          },
                          hight: 5.h,
                          width: 35.w,
                          txtsize: 12.sp)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
