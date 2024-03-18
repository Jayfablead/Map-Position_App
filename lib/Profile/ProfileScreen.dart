import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/Headerwidget.dart';
import 'package:mapposition/LoginSinupScreen/ChangePasswordScreen.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import 'EditProfileScreen.dart';
import 'ViewProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      backgroundColor: bgcolor,
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
                      text: "Profile",
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
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.pinimg.com/originals/51/e0/d5/51e0d5aa27808ce689e3dd5a5cd7685a.png',
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset(Default_Profile, fit: BoxFit.cover),
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
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  InkWell(
                      onTap: (){
                        Get.to(EditProfileScreen());
                      },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primary,
                          border: Border.all(color: primary, width:1.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blackback,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: bgcolor,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("Edit Profile",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken")),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackback,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(ViewPRofileScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primary,
                          border: Border.all(color: primary, width:1.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blackback,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: bgcolor,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("View Profile",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken")),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackback,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary,
                        border: Border.all(color: primary, width:1.sp)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: blackback,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text("My Favourites",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: blackback,
                          size: 18.sp,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                      onTap: (){
                        Get.to(ChangePasswordScreen());
                      },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primary,
                          border: Border.all(color: primary, width:1.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blackback,
                                ),
                                child: Icon(
                                  Icons.password,
                                  color: bgcolor,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("Change Password",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken")),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackback,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary,
                        border: Border.all(color: primary, width:1.sp)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: blackback,
                              ),
                              child: Icon(
                                Icons.paid,
                                color: bgcolor,
                                size: 18.sp,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text("Payment Method",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: blackback,
                          size: 18.sp,
                        )
                      ],
                    ),
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
