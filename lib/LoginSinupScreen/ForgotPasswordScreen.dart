import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/LoginSinupScreen/LoginScreen.dart';
import 'package:sizer/sizer.dart';

import '../Extras/buildErrorDialog.dart';
import '../Modal/ForgotPasswordModal.dart';
import '../Provider/Authprovider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                  onTap: (){Get.back();},
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: blackback,
                          size: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
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
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Forgot Password',
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
                      child: Text(
                          'You need a valid email address to reset you password.',
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                  ],
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                // Login
                batan(
                    title: "Send Email",
                    route: () {
                      forgotpassword();
                    },
                    hight: 6.h,
                    width: 80.w,
                    txtsize: 15.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
  forgotpassword() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['email'] = _email.text.trim().toString();

      print(data);
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().forgotpasswordapi(data).then((response) async {
            forgotpasswordmodal = ForgotPasswordModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && forgotpasswordmodal?.success == true) {
              EasyLoading.showSuccess(forgotpasswordmodal?.message ?? '');
              Get.offAll(LoginScreen());

              setState(() {
                _email.clear();
              });
            } else {
              EasyLoading.showError(forgotpasswordmodal?.message ?? '');
              buildErrorDialog(
                  context, "Login Error", (forgotpasswordmodal?.message ?? ''));
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
}
