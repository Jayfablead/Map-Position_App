
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mapposition/PrimiumPayments/stripedModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PositionController extends GetxController {
  RxBool isLoading = false.obs;
  StripedModel? stripedModel;
  late StreamSubscription<InternetConnectionStatus> _internetSubscription;

  @override
  void onInit() {
    super.onInit();
    stripeddata();
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
          stripeddata(); // Fetch data when internet is connected
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

  Future<void> stripeddata(
      Map<String, String> bodyData
      ) async {
    bool isConnected = await checkInternetConnectivity();

    if (isConnected) {
      try {
        final response = await http.post(
          Uri.parse(
            'https://boatposition.fableadtechnolabs.com/wp-json/custom/v1/process-payment',
          ),
          body: bodyData,
          headers: {"Authorization": "01234XYZABCDboatPosition@7890"},
        );

        if (response.statusCode == 200) {
          // Handle success response
          isLoading.value = true;
          print('Success: ${response.body}');
          stripedModel = stripedModelFromJson(response.body);
          // print(" it is my position  ${stripedModel?.positions.length}");

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
        stripedModel = stripedModelFromJson(jsonData);
        // print(" it is my position  ${stripedModel?.positions.length}");
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
