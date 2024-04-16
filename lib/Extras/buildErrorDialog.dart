import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'Const.dart';

okbuildErrorDialog(BuildContext context, String title, String contant,
    {VoidCallback? callback, String? buttonname}) {
  Widget okButton = GestureDetector(
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        // color: Boxbg
      ),
      child: Center(
        child: Text(buttonname ?? 'OK',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'volken',
              letterSpacing: 1,
              decorationColor: Colors.white,
              color: Colors.white,
            )),
      ),
    ),
    onTap: callback,
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 73.w,
          decoration: BoxDecoration(
            color: Boxbg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              (title != "")
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.white,
                              fontFamily: 'volken',
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                      ],
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      contant,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decorationColor: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'volken',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              SizedBox(height: 2.h),
              okButton,
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}

buildErrorDialog(BuildContext context, String title, String contant,
    {VoidCallback? callback, String? buttonname}) {
  Widget okButton = GestureDetector(
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        // color: Boxbg
      ),
      child: Center(
        child: Text(buttonname ?? 'OK',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'volken',
              letterSpacing: 1,
              decorationColor: Colors.white,
              color: Colors.white,
            )),
      ),
    ),
    onTap: () {
      // if (callback == null) {
      Get.back();
      // } else {

      // }
    },
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 73.w,
          decoration: BoxDecoration(
            color: Boxbg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              (title != "")
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.white,
                              fontFamily: 'volken',
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                      ],
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      contant,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decorationColor: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'volken',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              SizedBox(height: 2.h),
              okButton,
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}

buildErrorDialog1(
    BuildContext context, String title, String contant, VoidCallback? callback,
    {String? buttonname}) {
  Widget okButton = GestureDetector(
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        // color: Boxbg
      ),
      child: Center(
        child: Text(buttonname ?? 'OK',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'volken',
              letterSpacing: 1,
              decorationColor: Colors.white,
              color: Colors.white,
            )),
      ),
    ),
    onTap: callback,
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 73.w,
          decoration: BoxDecoration(
            color: Boxbg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              (title != "")
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.white,
                              fontFamily: 'volken',
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                      ],
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    Text(
                      contant,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decorationColor: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'volken',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              SizedBox(height: 2.h),
              okButton,
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}

// buildErrorDialog1(
//     BuildContext context, String title, String contant, VoidCallback? callback,
//     {String? buttonname}) {
//   Widget okButton = GestureDetector(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(20.0),
//           // color: primary
//         ),
//         child: Center(
//           child: Text(buttonname ?? 'OK',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'volken',
//                 letterSpacing: 1,
//                 decorationColor: Colors.white,
//                 color: Colors.white,
//               )),
//         ),
//       ),
//       onTap:
//           // if (callback == null) {
//           callback
//       // } else {
//
//       // }
//
//       );
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         backgroundColor: Colors.transparent,
//         child: Container(
//           width: 73.w,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 3.h,
//               ),
//               (title != "")
//                   ? Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 3.w),
//                           child: Text(
//                             title,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               decorationColor: Colors.white,
//                               fontFamily: 'volken',
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 1.h),
//                       ],
//                     )
//                   : Container(),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 3.w),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 1.h),
//                     Text(
//                       contant,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.normal,
//                         decorationColor: Colors.white,
//                         fontFamily: 'volken',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 2.h),
//               Divider(
//                 height: 1.0,
//                 color: Colors.grey,
//               ),
//               SizedBox(height: 2.h),
//               okButton,
//               SizedBox(
//                 height: 2.h,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

update(
  BuildContext context,
  String title,
  String contant, {
  VoidCallback? callback,
  String? buttonname,
}) {
  Widget okButton = GestureDetector(
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        // color: Boxbg
      ),
      child: Center(
        child: Text(buttonname ?? 'OK',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decorationColor: Colors.white,
              fontFamily: 'volken',
            )),
      ),
    ),
    onTap: callback,
  );

  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            width: 73.w,
            decoration: BoxDecoration(
              color: Boxbg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                (title != "")
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decorationColor: Colors.white,
                                fontFamily: 'volken',
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                        ],
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Text(
                        contant,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          decorationColor: Colors.white,
                          fontFamily: 'volken',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Divider(
                  height: 1.0,
                  color: Colors.black45,
                ),
                SizedBox(height: 2.h),
                okButton,
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  if (Platform.isIOS) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            width: 70.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                (title != "")
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decorationColor: Colors.white,
                                fontFamily: 'volken',
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                        ],
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Text(
                        contant,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          decorationColor: Colors.white,
                          fontFamily: 'volken',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),
                SizedBox(height: 1.h),
                okButton,
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        );
      },
    );
    // CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
    //   title: Text(title,
    //       style: TextStyle(
    //           color: Colors.black,
    //           decorationColor: Colors.black,
    //           fontFamily: 'poppins')),
    //   content: Text(contant,
    //       style: const TextStyle(
    //           color: Colors.black,
    //           decorationColor: Colors.black,
    //           fontFamily: 'poppins')),
    //   actions: [
    //     okButton,
    //   ],
    // );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return cupertinoAlertDialog;
    //   },
    // );
  }
  // show the dialog
}
