import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import 'LoginScreen.dart';

class SinupScreen2 extends StatefulWidget {
  String? firstname;
  String? lastname;
  String? email;

  SinupScreen2({super.key, this.email, this.firstname, this.lastname});

  @override
  State<SinupScreen2> createState() => _SinupScreen2State();
}

class _SinupScreen2State extends State<SinupScreen2> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confrompassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool secure = false;
  bool visible = true;
  bool visible1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phone.clear();
    _password.clear();
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
                height: 20.h,
              ),
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
                          width: 85.w,
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
                  Text("Phone : ",
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
                      style: TextStyle(color: Colors.white),
                      controller: _phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Phone";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your Phone",
                          icon: Icon(
                            Icons.phone_android,
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
                      style: TextStyle(color: Colors.white),
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
                  Text("Confirm Password : ",
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
                      obscureText: visible1,
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
                              visible1 = !visible1;
                              print(visible1);
                            });
                          },
                          icon: visible1
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
                      title: "Sign Up",
                      route: () {},
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
                          "Login",
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
