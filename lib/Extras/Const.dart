import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';

import '../Modal/AddFavouritePositionModal.dart';
import '../Modal/AddOtherPositionModal.dart';
import '../Modal/AddPositionModal.dart';
import '../Modal/AddReviewModal.dart';
import '../Modal/AddViewOtherModal.dart';
import '../Modal/AddWaringmodal.dart';
import '../Modal/AddviewWarningModal.dart';
import '../Modal/CastomPositionMarinaModal.dart';
import '../Modal/ChangePasswordModal.dart';
import '../Modal/DeletePositionModal.dart';
import '../Modal/EditCasotamMarinaModal.dart';
import '../Modal/ForgotPasswordModal.dart';
import '../Modal/LoginModal.dart';
import '../Modal/MyMarinaViewModal.dart';
import '../Modal/OnwViewPostionModal.dart';
import '../Modal/ShoAllMarkerModal.dart';
import '../Modal/SinupModal.dart';
import '../Modal/StripePaymentsModal.dart';
import '../Modal/UpdateAlaramModal.dart';
import '../Modal/UpdateOtherPositionModal.dart';
import '../Modal/UpdateProfileModal.dart';
import '../Modal/UpdateWarningModal.dart';
import '../Modal/UpdateanchorgeModal.dart';
import '../Modal/ViewCategoryWiseviewDetailModal.dart';
import '../Modal/ViewFouriteModal.dart';
import '../Modal/ViewProfileModal.dart';
import '../Modal/postionModel.dart';
// ************  Base url ************** //

const String baseUrl = 'https://hassan-mart.com/';

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

// for all Background color Use this
Color bgcolor =Color(0xffffffff);


// for all Primary color Use this
Color primary = Colors.grey.withOpacity(0.06);
Color blackback = Color(0xff000000);

// for all Secondary color Use this
Color secondary = Color(0xff808080);

// for all button color Use this
Color btn = Color(0xffffd45f);

// for all BoxBg color Use this
Color Boxbg = Color(0xff353535);
const String Default_Profile = 'assets/defaultprofile.png';


SinupModal? sinupmodal;
LoginModal? loginmodal;
ChangePasswordModal? changepasswordmodal;
ForgotPasswordModal? forgotpasswordmodal;
ViewProfileModal? viewprofilemodal;
UpdateProfileModal? updateprofilemodal;
UpdateAlaramModal? updatealarammodal;
ShoAllMarkerModal? shoallmarkermodal;
AddPositionModal? addpositionmodal;
AddWaringmodal? addwaringmodal;
AddOtherPositionModal? addotherpositionmodal;
MyMarinaViewModal? mymarinaviewmodal;
DeletePositionModal? deletepositionmodal;
CastomPositionMarinaModal? castompositionmarinamodal;
EditCasotamMarinaModal? editcasotammarinamodal;
UpdateanchorgeModal? updateanchorgemodal;
UpdateWarningModal? updatewarningmodal;
UpdateOtherPositionModal? updateotherpositionmodal;
OnwViewPostionModal? onwViewpostionmodal;
AddReviewModal? addreviewmodal;
AddViewOtherModal? addviewothermodal;
AddviewWarningModal? addviewwarningmodal;
ViewCategoryWiseviewDetailModal? viewcategorywisevieweetailmodal;
AddFavouritePositionModal? addfavouritepositionmodal;
ViewFouriteModal? viewfouritemodal;
StripePaymentsModal? stripepaymentsmodal;
PostionModel? position;

// Custom Button
InkWell batan({
  required String? title,
  required Callback? route,
  required double? hight,
  required double? width,
  required double? txtsize,
}) {
  return InkWell(
    onTap: route,
    child: Container(
      alignment: Alignment.center,
      height: hight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: blackback,
      ),
      child: Text(
        title.toString(),
        style: TextStyle(
          fontSize: txtsize,
          color: Colors.white,
          fontWeight: FontWeight.w100,
          fontFamily: "volken",
        ),
      ),
    ),
  );
}

// Custom Button
InkWell bandhbatan({
  required String? title,
  required Callback? route,
  required double? hight,
  required double? width,
  required double? txtsize,
}) {
  return InkWell(
    onTap: route,
    child: Container(
      alignment: Alignment.center,
      height: hight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Text(
        title.toString(),
        style: TextStyle(
          fontSize: txtsize,
          color: Colors.white,
          fontFamily: "volken",
        ),
      ),
    ),
  );
}

// Custom Button
InkWell loadbatn({
  required double? hight,
  required double? width,
}) {
  return InkWell(
    child: Container(
      alignment: Alignment.center,
      height: hight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: CircularProgressIndicator(),
    ),
  );
}

InputDecoration inputDecoration({
  required String hintText,
  Icon? icon,
  IconButton? ico,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
    suffixIcon: ico,
    hintText: hintText,
    prefixIcon: icon,
    errorStyle: TextStyle(
        fontFamily: 'volken',
        color: Colors.red,
        fontWeight: FontWeight.w500,
        fontSize: 11.sp,
        letterSpacing: 1),
    hintStyle: TextStyle(
        fontFamily: 'volken',
        color: secondary,
        fontWeight: FontWeight.w500,
        fontSize: 12.5.sp,
        letterSpacing: 1),
    fillColor: bgcolor,
    filled: true,
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondary),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondary),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondary),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: secondary),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

// For Fonts Use FontFamily : volken

// this down below is example

// TextStyle _exmpletxt = TextStyle(
//   fontSize: 12.sp,
//   fontFamily: 'volken',
//   letterSpacing: 1,
// );
