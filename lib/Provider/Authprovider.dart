import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
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
  Future<http.Response> editprofile(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}update-user-details';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'upload_pictures',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }
  Future<http.Response> editprofile1(Map<String, String> bodyData) async {
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
  Future<http.Response> showmarkerapi(Map<String, String> bodyData) async {
    String url = "https://boatposition.fableadtechnolabs.com/wp-json/custom/v1/all-properties";
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url),body: bodyData,  headers: headers)
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



  Future<http.Response> maltiplephotoaddapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}add-anchorage';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'upload_pictures',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }
  Future<http.Response> addwaringaapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}add-warning';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'upload_pictures',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }
  Future<http.Response> addotherpositionapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}add-other';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'upload_pictures',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }
  Future<http.Response> updateotherapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}update-other-position';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'upload_pictures',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }

  Future<http.Response> mymerinaviewapi(Map<String, String> bodyData) async {
    const url = 'https://boatposition.fableadtechnolabs.com/wp-json/custom/v1/all-properties';
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
  Future<http.Response> deletepositionapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}delete-position';
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



  Future<http.Response> addmarinacastomapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}add-custom-position';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'post_images',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }
  Future<http.Response> updatecastompostionapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}update-custom-position';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'post_images',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }


  Future<http.Response> updateanchorageapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}update-anchorage-position';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'post_images',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }


  Future<http.Response> updatawarnignapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}update-warning-position';
    var responseJson;
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    imageUploadRequest.headers.addAll(headers);
    if (imagePaths.isNotEmpty) {
      for (var imagePath in imagePaths) {
        var file = await http.MultipartFile.fromPath(
          'post_images',
          imagePath!,
          contentType: MediaType('image', 'jpg,png'),
        );
        imageUploadRequest.files.add(file);
      }
    }
    imageUploadRequest.fields.addAll(bodyData);
    final streamResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamResponse);
    responseJson = responses(response);
    // print("responseJson = ${json.decode(responseJson)}");
    return responseJson;
  }


  Future<http.Response> viewsinganalpositionviewapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}view-position';
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




  Future<http.Response> addreviewapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}add-review';
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



  Future<http.Response> addfevouriteapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}add-remove-fav';
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



  Future<http.Response> viewfvouriteapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}my-fav-positions';
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
  Future<http.Response> stripeapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}process-payment';
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
  Future<http.Response> wedtherapi(latitude1,longitude2,carrentdate,tendays) async {
    String url = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${latitude1},${longitude2}/${carrentdate}/${tendays}/?key=5ZPYVKDXPN3D8K4MYRV7W78KZ';
    print("wedtherurl${url}");
    var responseJson;
    final response = await http
        .get(Uri.parse(url))
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
