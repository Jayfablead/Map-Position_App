import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import 'Const.dart';
import 'Databasehandler.dart';

DatabaseHelper databaseHelper = DatabaseHelper();

Widget header({
  required String text,
  required VoidCallback callback1,
  int? show
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    show==1?IconButton(
  onPressed: () {
    Get.back();
  },
  icon: Icon(null,
  color: blackback, size: 23.sp),
  ) :  IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.keyboard_arrow_left,
            color: blackback, size: 23.sp),
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'sofi',
          letterSpacing: 1,
          color: blackback,
          fontWeight: FontWeight.bold,
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: callback1,
                  icon: Icon(
                    Icons.menu_rounded,
                    color: blackback,
                    size: 23.sp,
                  )),
            ],
          ),
        ],
      ),
    ],
  );
}
