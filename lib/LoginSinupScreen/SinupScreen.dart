import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';

import 'LoginScreen.dart';
import 'SinupScreen2.dart';

class SinupScreen extends StatefulWidget {
  const SinupScreen({super.key});

  @override
  State<SinupScreen> createState() => _SinupScreenState();
}

class _SinupScreenState extends State<SinupScreen> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  bool secure = false;
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstname.clear();
    _lastname.clear();
    _email.clear();
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
                      color:blackback,
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
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Create An Account",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "volken")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Welcome! Please Enter Your Details",
                      style: TextStyle(
                          letterSpacing: 2,
                          color: secondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "volken")),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black54,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45.w,
                          height: 1.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey,
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("First Name : ",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken")),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(color:secondary),
                      controller: _firstname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter First Name";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your First Name",
                          icon: Icon(
                            Icons.person,
                            color: secondary,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("Last Name : ",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken")),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: secondary),
                      controller: _lastname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Last Name";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your Last Name",
                          icon: Icon(
                            Icons.person,
                            color: secondary,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("Email : ",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken")),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: secondary),
                      controller: _email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter email";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your Email",
                          icon: Icon(
                            Icons.email,
                            color: secondary,
                          )),
                    ),
                  ),

                  SizedBox(
                    height: 3.5.h,
                  ),
                  // Login
                  batan(
                      title: "Next",
                      route: () {
                        Get.to(SinupScreen2());
                      },
                      hight: 6.h,
                      width: MediaQuery.of(context).size.width,
                      txtsize: 18.sp),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Already have account?",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.grey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken"),
                        ),
                      ),
                      // Login button
                      InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: blackback,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
