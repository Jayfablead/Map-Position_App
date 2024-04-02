import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapposition/Extras/response.dart';
import 'package:http/http.dart' as http;

import '../Extras/CustomExpection.dart';

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

  Future<http.Response> editprofile(Map<String, String> bodyData) async {
    String url = '${apiUrl}update-user-details';
    // const url = 'https://boatposition.fableadtechnolabs.com/wp-json/custom/v1/update-user-details';
    var responseJson;
    if (bodyData['profile_image'] != "") {
      try {
        final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(url));
        imageUploadRequest.headers.addAll(headers);
        if (bodyData['profile_img']?.isNotEmpty ?? false) {
          final file = await http.MultipartFile.fromPath(
              'profile_img', bodyData['profile_img'] ?? '');
          imageUploadRequest.files.add(file);
        }
        imageUploadRequest.fields.addAll(bodyData);
        print(imageUploadRequest.files);
        final streamResponse = await imageUploadRequest.send();
        print(streamResponse.statusCode);
        responseJson =
            responses(await http.Response.fromStream(streamResponse));
        print(responseJson);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    } else {
      print("a helllooo");
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      print(response.statusCode);
      responseJson = responses(response);
      print(responseJson);
      return responseJson;
    }
  }
  Future<http.Response> updatealaramapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}user-subscription-alarm';
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
  Future<http.Response> showallmarkerapi() async {
    String url = '${apiUrl}all_properties';
    print(url);
    var responseJson;
    final response = await http
        .get(Uri.parse(url), headers: headers)
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
  Future<http.Response> showmarker() async {
    String url = 'https://boatposition.fableadtechnolabs.com/wp-json/navly/v1/all_properties';
    print(url);
    var responseJson;
    final response = await http
        .get(Uri.parse(url),)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print("printAlldata${response.body}");
    return responseJson;
  }

  Future<http.Response> addpositionapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}add-anchorage';
    // const url = 'https://boatposition.fableadtechnolabs.com/wp-json/custom/v1/update-user-details';
    var responseJson;
    if (bodyData['upload_pictures'] != "") {
      try {
        final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(url));
        imageUploadRequest.headers.addAll(headers);
        if (bodyData['upload_pictures']?.isNotEmpty ?? false) {
          final file = await http.MultipartFile.fromPath(
              'upload_pictures', bodyData['upload_pictures'] ?? '');
          imageUploadRequest.files.add(file);
        }
        imageUploadRequest.fields.addAll(bodyData);
        print(imageUploadRequest.files);
        final streamResponse = await imageUploadRequest.send();
        print(streamResponse.statusCode);
        responseJson =
            responses(await http.Response.fromStream(streamResponse));
        print(responseJson);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    } else {
      print("a helllooo");
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      print(response.statusCode);
      responseJson = responses(response);
      print(responseJson);
      return responseJson;
    }
  }
}
