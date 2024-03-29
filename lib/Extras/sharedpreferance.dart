import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Modal/LoginModal.dart';



class SaveDataLocal {
  static SharedPreferences? prefs;
  static String userData = 'UserData';

  static saveLogInData(LoginModal loginmodal) async {
    prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(loginmodal.toJson());
    await prefs?.setString(userData, json);
    print('dataStoared');
  }

  static getDataFromLocal() async {
    prefs = await SharedPreferences.getInstance();
    String? userString = prefs?.getString(userData);
    if (userString != null) {
      Map<String, dynamic> userMap =
          jsonDecode(userString); // Specify the type here
      LoginModal user = LoginModal.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }

  static clearUserData() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.clear();
  }
}
