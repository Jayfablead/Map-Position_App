import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Modal/StripePaymentsModal.dart';
import '../Modal/postionModel.dart';


class PositionController extends GetxController {
  RxBool isLoading = false.obs;
  PostionModel? position;
  late StreamSubscription<InternetConnectionStatus> _internetSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchPositionData();
    // Start monitoring internet connectivity
    _internetSubscription = InternetConnectionChecker().onStatusChange.listen(
          (status) {
        if (status == InternetConnectionStatus.connected) {
          // Get.snackbar(
          //   'Internet Connected',
          //   'Internet connection is restored.',
          //   snackPosition: SnackPosition.BOTTOM,
          //   backgroundColor: Colors.green,
          //   colorText: Colors.white,
          // );
          fetchPositionData(); // Fetch data when internet is connected
        }
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    // Cancel the internet subscription when the controller is closed
    _internetSubscription.cancel();
  }

  Future<void> fetchPositionData() async {
    bool isConnected = await checkInternetConnectivity();

    if (isConnected) {
      try {
        final response = await http.post(
          Uri.parse(
            'https://boatposition.fableadtechnolabs.com/wp-json/custom/v1/all-properties',
          ),
          headers: {"Authorization": "01234XYZABCDboatPosition@7890"},
        );

        if (response.statusCode == 200) {
          // Handle success response
          isLoading.value = true;
          print('Success: ${response.body}');
          position = postionModelFromJson(response.body);
          print(" it is my position  ${position?.positions.length}");

          // Store data in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('positionData', response.body);
        } else {
          // Handle error response
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        // Handle exceptions
        print('Exception: $e');
      }
    } else {
      Get.snackbar(
        'No Internet Connection',
        'Please connect to the internet',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // If no internet, retrieve data from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonData = prefs.getString('positionData');
      if (jsonData != null) {
        position = postionModelFromJson(jsonData);
        print(" it is my position  ${position?.positions.length}");
        isLoading.value = true;
      }
    }
  }

  Future<bool> checkInternetConnectivity() async {
    try {
      var isDeviceConnected = await InternetConnectionChecker().hasConnection;
      return isDeviceConnected;
    } catch (e) {
      return false;
    }
  }
}
