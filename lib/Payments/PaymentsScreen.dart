import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Const.dart';
import '../Extras/buildErrorDialog.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Invoice/ViewInvoiceScreen.dart';
import '../LoginSinupScreen/LoginScreen.dart';
import '../Modal/StripePaymentsModal.dart';
import '../Provider/Authprovider.dart';
String? storedPlanEndDate;
class PaymentsScreen extends StatefulWidget {
  String? amont;
  PaymentsScreen({super.key,required this.amont});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String? planEndDate;
  String? storedPlanEndDate;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _num =TextEditingController();
  TextEditingController _name =TextEditingController();
  TextEditingController _cvv =TextEditingController();
  TextEditingController _ed =TextEditingController();
  TextEditingController _ey =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 2.w),
        child: SingleChildScrollView(
          child:   Form(
            key: _formKey,
            child: Column(
              children: [
               SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                        child: Icon(Icons.arrow_back_ios,size: 20.sp,color: Colors.black,)),
                    Text("Payment",style: TextStyle(
                        letterSpacing: 1,
                        color:blackback,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: "volken")),
                    Icon(null),
                  ],
                ),
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
                SizedBox(height: 5.h,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: secondary),
                    controller: _num,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the Card Number";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Please enter the Card Number",
                        icon: Icon(
                          Icons.credit_card,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: secondary),
                    controller: _name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Name Of Card";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Please enter Name Of Card",
                        icon: Icon(
                          Icons.credit_card,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: secondary),
                    controller: _cvv,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Cvv";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hintText: "Please enter Cvv",
                        icon: Icon(
                          Icons.password,
                          color: secondary,
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 37.w,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: secondary),
                        controller: _ed,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Month";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                            hintText: "Month",
                           ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Container(
                      width: 37.w,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: secondary),
                        controller: _ey,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Year";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hintText: "Year",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                batan(title: "Pay Now", route: (){
                  if (_formKey.currentState!.validate()) {
                    int.parse(_ed.text) <= 12
                    ? stripepaymetsapi()
                    : buildErrorDialog(context, 'Month Error',
                    'Please Use Valid Month');
                  }

                }, hight: 6.h, width: 85.w, txtsize: 18.sp),

              ],
            ),
          ),
        ),
      ),
    );
  }


  stripepaymetsapi() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['user_id'] = (loginmodal?.userId).toString();
      data['name_on_card'] = _name.text.trim().toString();
      data['card_number'] = _num.text.trim().toString();
      data['expiry_month'] = _ed.text.trim().toString();
      data['expiry_year'] = _ey.text.trim().toString();
      data['cvv'] = _cvv.text.trim().toString();
      data['amount'] = widget.amont ?? "";
      print(data);
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().stripeapi(data).then((response) async {

            stripepaymentsmodal = StripePaymentsModal.fromJson(json.decode(response.body));
            String? planEndDate = stripepaymentsmodal?.data?.planEndDate;
            if (response.statusCode == 200 && stripepaymentsmodal?.success == true) {
              print(response);
              EasyLoading.showSuccess(stripepaymentsmodal?.message ?? '');
              if (planEndDate != null) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('stripeSuccess', planEndDate);
                storedPlanEndDate = prefs.getString('stripeSuccess');
                print("plan date${storedPlanEndDate}");
              }
              Get.offAll(HomeScreen());
              setState(() {
                _name.clear();
                _cvv.clear();
                _ey.clear();
                _ed.clear();
                _num.clear();
              });
            } else {
              EasyLoading.showError(stripepaymentsmodal?.message ?? '');
              buildErrorDialog(
                  context, "Payment Error", (stripepaymentsmodal?.message ?? ''));
            }
          });
        } else {
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
}
