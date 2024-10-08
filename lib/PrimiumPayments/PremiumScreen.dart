import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:mapposition/Extras/Const.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar:loginmodal?.userId==""||loginmodal?.userId==null? Container(): Bottombar(select_tab: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              SizedBox(  width: 100.w, child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // InkWell(
                  //     onTap: (){
                  //       Get.back();
                  //     },child: Icon(Icons.arrow_back_ios,color: blackback,size: 20.sp,)),
                  InkWell(
                    onTap: (){},
                    child: Text("Need Help?",style: TextStyle(
                        letterSpacing: 1,
                        color:blackback,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: "volken")),
                  ),
                ],
              ),),
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
                          Text("Premium",style: TextStyle(
                              letterSpacing: 1,
                              color:Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                          SizedBox(height: 1.h,),
                          Text("\$200.00/Year",style: TextStyle(
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
                  fontFamily: "volken")):Text("Subscribe To Premium,Unlock",style: TextStyle(
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
                  fontFamily: "volken")):Text("More features and support Marina!",style: TextStyle(
                      letterSpacing: 1,
                      color:blackback,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: "volken")),
                ],
              ),
              SizedBox(
                height: 8.h,
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
                          child: Text("Save entire areas to have access to the map and information on anchorages and marinas even without an internet connecation",style: TextStyle(
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
             batan(title: "Subscribe for \$200.00", route: (){
               Get.to(PaymentsScreen());
              }, hight: 6.h, width: 85.w, txtsize: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

}







