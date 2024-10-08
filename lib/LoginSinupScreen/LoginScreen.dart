import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/HomeScreen/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Extras/buildErrorDialog.dart';
import '../Extras/sharedpreferance.dart';
import '../Modal/LoginModal.dart';
import '../Provider/Authprovider.dart';
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
      body: Form(
        key:_formKey,
        child: Padding(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/welcomelogo.png",
                            height: 34.w,
                            width: 34.w,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome Back",
                        style: TextStyle(
                            letterSpacing: 2,
                            color: secondary,
                            fontSize: 15.sp,
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          LoginApi();
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          batan(
                              title: "Go to MainPage",
                              route: () {
                                Get.offAll(HomeScreen());
                              },
                              hight: 5.h,
                              width: 45.w,
                              txtsize: 14.sp),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  LoginApi() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['email'] = _email.text.trim().toString();
      data['password'] = _password.text.trim().toString();
      print(data);
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().loginApi(data).then((response) async {
            loginmodal = LoginModal.fromJson(json.decode(response.body));
            String? planEndDate = loginmodal?.planEndDate;
            if (response.statusCode == 200 && loginmodal?.success == true) {
              SaveDataLocal.saveLogInData(loginmodal!);
              if (planEndDate != null) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('stripeSuccess', planEndDate);
                storedPlanEndDate = prefs.getString('stripeSuccess');
                print("plan date${storedPlanEndDate}");
              }
              EasyLoading.showSuccess(loginmodal?.message ?? '');
              Get.offAll(HomeScreen());

              setState(() {
                _email.clear();
                _password.clear();
              });
            } else {
              EasyLoading.showError(loginmodal?.message ?? '');

            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
}
