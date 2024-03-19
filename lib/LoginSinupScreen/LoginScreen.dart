import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/HomeScreen/HomeScreen.dart';
import 'package:sizer/sizer.dart';

import 'ForgotPasswordScreen.dart';
import 'SinupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool secure = false;
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _email.clear();
      _password.clear();
    });
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
                  Text("Login",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "volken")),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Welcome Back!Please Enter Your Details",
                      style: TextStyle(
                          letterSpacing: 2,
                          color: secondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w100,
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
                    height: 2.h,
                  ),
                  // Password
                  Text("Password : ",
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
                      obscureText: visible,
                      style: TextStyle(color:secondary),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        // Password strength validation logic
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      controller: _password,
                      decoration: inputDecoration(
                          hintText: "Enter Your Password",
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
                  // Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ForgotPasswordScreen());
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: blackback,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "volken")),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  // Login
                  batan(
                      title: "Login",
                      route: () {
                        Get.to(HomeScreen());
                      },
                      hight: 6.h,
                      width: MediaQuery.of(context).size.width,
                      txtsize: 18.sp),
                  SizedBox(
                    height: 3.h,
                  ),
                  // Dont'have account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont'have account?",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.grey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken"),
                      ),
                      // Sign Up button
                      InkWell(
                        onTap: () {
                          Get.to(SinupScreen());
                        },
                        child: Text(
                          " Sign Up",
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
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        batan(
                            title: "Go to MainPage",
                            route: () {},
                            hight: 4.h,
                            width: 45.w,
                            txtsize: 12.sp),
                      ],
                    ),
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
