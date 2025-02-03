import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/Drwer.dart';
import 'package:mapposition/Extras/Headerwidget.dart';
import 'package:mapposition/Extras/buildErrorDialog.dart';
import 'package:mapposition/Modal/PremiumModal.dart';
import 'package:mapposition/Provider/Authprovider.dart';
import 'package:sizer/sizer.dart';

import '../Extras/bottombar.dart';
import '../Payments/PaymentsScreen.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  Map<String, dynamic>? paymentIntentData;
  final GlobalKey<ScaffoldState> _scaffoldKeyprmiyam =
  GlobalKey<ScaffoldState>();
bool isLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading=true;
    });
    premimum();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      drawer: drawer1(),
      key: _scaffoldKeyprmiyam,
      bottomNavigationBar:loginmodal?.userId==""||loginmodal?.userId==null? Container(): Bottombar(select_tab: 1),
      body:isLoading ?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              header(
                  show: 1,
                  text: "Premium",
                  callback1: () {
                    _scaffoldKeyprmiyam.currentState
                        ?.openDrawer();
                  }),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackback
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blackback,
                        border: Border.all(
                          width: 1.sp,
                          color: secondary
                        )
                      ),
                      child: Column(
                        children: [
                          Text("Get Premium",style: TextStyle(
                              letterSpacing: 1,
                              color:Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                          SizedBox(height: 1.h,),
                          Text("\$${premiummodal?.plan?.subscriptionAmount}/Year",style: TextStyle(
                              letterSpacing: 1,
                              color:Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "volken")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loginmodal?.paymentStatus=="succeeded"?Text("You Have All Ready Subscribed",style: TextStyle(
                  letterSpacing: 1,
                  color:blackback,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: "volken")):Text("Unlock Offline Mode",style: TextStyle(
                      letterSpacing: 1,
                      color:blackback,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: "volken")),
                ],
              ),
              SizedBox(height: 1.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loginmodal?.paymentStatus=="succeeded"?Text("To Premium",style: TextStyle(
                  letterSpacing: 1,
                  color:blackback,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: "volken")):Text("And support our work",style: TextStyle(
                      letterSpacing: 1,
                      color:blackback,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: "volken")),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1.sp,color: secondary)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15.w,
                      width: 15.w,
                      alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black

                        ),
                        child: Icon(Icons.wifi_off,size: 20.sp,color: Colors.white,)),
                    SizedBox(width: 3.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Offline Mode",style: TextStyle(
                            letterSpacing: 1,
                            color:blackback,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                        SizedBox(height: 1.h,),
                        SizedBox(
                          width: 73.w,
                          child: Text("Save entire areas to have access to the map and information on anchorages and marinas, warnings, etc. even without an internet"
                              ,style: TextStyle(
                              letterSpacing: 1,
                              color:secondary,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.h,),
             loginmodal?.paymentStatus=="succeeded"?Container():
             batan(title: "Subscribe for \$${premiummodal?.plan?.subscriptionAmount}", route: (){
               Get.to(PaymentsScreen(amont: premiummodal?.plan?.subscriptionAmount,));
              }, hight: 6.h, width: 85.w, txtsize: 20.sp),
              SizedBox(height:10.h ,),
            ],
          ),
        ),
      ),
    );
  }
  premimum() {
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().subscriptionplanapi().then((response) async {
          premiummodal = PremiumModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200&& premiummodal?.success == true ) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
}







