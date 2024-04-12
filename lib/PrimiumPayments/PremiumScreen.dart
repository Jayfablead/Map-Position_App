import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart'as http;
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
      bottomNavigationBar: Bottombar(select_tab: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Get.back();
                      },child: Icon(Icons.arrow_back_ios,color: blackback,size: 20.sp,)),
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
                          Text("Navily Premium",style: TextStyle(
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
                  Text("Subscribe To Navily Premium,Unlock",style: TextStyle(
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
                  Text("More features and support Navily!",style: TextStyle(
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
              batan(title: "Subscribe for \$200.00", route: (){
               Get.to(PaymentsScreen());
              }, hight: 6.h, width: 85.w, txtsize: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> makePayment() async {
    try {
      paymentIntentData =
      await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              setupIntentClientSecret: 'sk_test_51NGDspApypsYW3yfXLprQvykRwRaYXamREtHblnecFz181E2Q0tJTplizGRtA4QuIaARyslkqmeyZCTl38POj0UL00Oa34nBFe',
              paymentIntentClientSecret:
              paymentIntentData!['client_secret'],
              //applePay: PaymentSheetApplePay.,
              //googlePay: true,
              //testEnv: true,
              customFlow: true,
              style: ThemeMode.dark,
              // merchantCountryCode: 'US',
              merchantDisplayName: 'Kashif'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
        //       parameters: PresentPaymentSheetParameters(
        // clientSecret: paymentIntentData!['client_secret'],
        // confirmPayment: true,
        // )
      )
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51NGDspApypsYW3yfXLprQvykRwRaYXamREtHblnecFz181E2Q0tJTplizGRtA4QuIaARyslkqmeyZCTl38POj0UL00Oa34nBFe',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}







