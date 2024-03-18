import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldpassword = TextEditingController();
  TextEditingController _newpassword = TextEditingController();
  TextEditingController _confrompassword = TextEditingController();
  bool secure = false;
  bool visible = true;
  bool visible1 = true;
  bool visible2 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newpassword.clear();
    _oldpassword.clear();
    _confrompassword.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              InkWell(
                onTap: (){
                  Get.back();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color:blackback,
                        size: 25.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35.w,
                    height: 35.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: blackback,
                    ),
                    child: Transform.rotate(
                        angle: pi / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/lagan.png",
                              height: 25.w,
                              width: 25.w,
                              fit: BoxFit.cover,
                              color: bgcolor,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Change Password',
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken")),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 85.w,
                    child: Text('Use Your Old Password To Change Your Password',
                        style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  obscureText: visible,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Old password';
                    }
                    // Password strength validation logic
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  controller: _oldpassword,
                  decoration: inputDecoration(
                      hintText: "Enter Your Old Password",
                      icon: Icon(
                        Icons.lock,
                        color: secondary,
                      ),
                      ico: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                            print(visible);
                          });
                        },
                        icon: visible
                            ? Icon(
                                Icons.visibility,
                                size: 15.sp,
                                color: secondary,
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: 15.sp,
                                color: secondary,
                              ),
                      )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  obscureText: visible1,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter New password';
                    }
                    // Password strength validation logic
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  controller: _newpassword,
                  decoration: inputDecoration(
                      hintText: "Enter Your New Password",
                      icon: Icon(
                        Icons.lock,
                        color: secondary,
                      ),
                      ico: IconButton(
                        onPressed: () {
                          setState(() {
                            visible1 = !visible1;
                            print(visible1);
                          });
                        },
                        icon: visible
                            ? Icon(
                                Icons.visibility,
                                size: 15.sp,
                                color: secondary,
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: 15.sp,
                                color: secondary,
                              ),
                      )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  obscureText: visible2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Conform password';
                    }

                    // Password strength validation logic
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }

                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.white),
                  controller: _confrompassword,
                  decoration: inputDecoration(
                    hintText: "Enter Confirm Password ",
                    icon: Icon(
                      Icons.lock,
                      color: secondary,
                    ),
                    ico: IconButton(
                      onPressed: () {
                        setState(() {
                          visible2 = !visible2;
                          print(visible2);
                        });
                      },
                      icon: visible2
                          ? Icon(
                              Icons.visibility,
                              size: 15.sp,
                              color: secondary,
                            )
                          : Icon(
                              Icons.visibility_off,
                              size: 15.sp,
                              color: secondary,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              // Login
              batan(
                  title: "Change Password",
                  route: () {},
                  hight: 6.h,
                  width: 80.w,
                  txtsize: 15.sp),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
