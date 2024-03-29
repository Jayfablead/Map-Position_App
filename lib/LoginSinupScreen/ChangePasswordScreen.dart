import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mapposition/LoginSinupScreen/LoginScreen.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/ChangePasswordModal.dart';
import '../Provider/Authprovider.dart';

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
  final _formKey = GlobalKey<FormState>();
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
                    style: TextStyle(color:secondary),
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
                    style: TextStyle(color:secondary),
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
                    style: TextStyle(color:secondary),
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
                    route: () {
                      if (_formKey.currentState!.validate()) {
                        _newpassword.text == _confrompassword.text
                            ? changepassword() ()
                            : buildErrorDialog(context, 'Error',
                            'Password and Confirm Password Doesn\'t Match');
                      } else {}
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
  changepassword() {
    if (_formKey.currentState!.validate()) {

      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['user_id'] = (loginmodal?.userId).toString();
      data['old_password'] = _oldpassword.text.toString();
      data['new_password'] = _newpassword.text.trim().toString();

      print(data);
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().changepassword(data).then((response) async {
            changepasswordmodal = ChangePasswordModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && changepasswordmodal?.success == true) {
              EasyLoading.showSuccess(changepasswordmodal?.message ?? '');
              Get.offAll(LoginScreen());
              setState(() {
                _oldpassword.clear();
                _newpassword.clear();
                _confrompassword.clear();
              });
            } else {
              EasyLoading.showError(changepasswordmodal?.message ?? '');
              buildErrorDialog(
                  context, "Password Error", (changepasswordmodal?.message ?? ''));
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
}
