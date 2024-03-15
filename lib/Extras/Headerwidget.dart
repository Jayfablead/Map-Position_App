import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import 'Databasehandler.dart';

DatabaseHelper databaseHelper = DatabaseHelper();

Widget header({
  required String text,
  required VoidCallback callback1,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: 23.sp),
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'sofi',
          letterSpacing: 1,
          color: Colors.white,
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
                    color: Colors.white,
                    size: 23.sp,
                  )),
            ],
          ),
        ],
      ),
    ],
  );
}
