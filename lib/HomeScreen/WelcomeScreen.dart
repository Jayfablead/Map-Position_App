import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapposition/HomeScreen/HomeScreen.dart';
import 'package:mapposition/LoginSinupScreen/LoginScreen.dart';
import 'package:sizer/sizer.dart';
import '../Extras/Const.dart';
import '../Extras/sharedpreferance.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    Timer(
      Duration(seconds: 5),
          () =>
      (loginmodal == null) ? Get.offAll(HomeScreen()) : Get.offAll(HomeScreen()),
    );
    super.initState();
  }

  getdata() async {
    loginmodal = await SaveDataLocal.getDataFromLocal();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body:   Center(
        child: Container(

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
      ),
    );
  }
}
