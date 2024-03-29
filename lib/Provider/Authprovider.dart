import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapposition/Extras/response.dart';
import 'package:http/http.dart' as http;

class authprovider with ChangeNotifier {
  Map<String, String> headers = {
    'Authorization': '01234XYZABCDboatPosition@7890',
  };
  String apiUrl = 'https://boatposition.fableadtechnolabs.com/wp-json/custom/v1/';


  Future<http.Response> loginApi(Map<String, String> bodyData) async {
    String url = '${apiUrl}login';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> sinupapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}register';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> changepassword(Map<String, String> bodyData) async {
    String url = '${apiUrl}change-password';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> forgotpasswordapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}forgot-password';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> viewprofileapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}user-details';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
}
