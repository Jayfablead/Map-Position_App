import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mapposition/Extras/response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../Extras/CustomExpection.dart';

class authprovider with ChangeNotifier {
  Map<String, String> headers = {
    'Authorization': '01234XYZABCDboatPosition@7890',
  };
  String apiUrl = 'https://www.navlex.net/wp-json/custom/v1/';
  static String Photourl = 'https://www.navlex.net/wp-content/themes/wpstate-child/img/conditions/';


  Future<http.Response> loginApi(Map<String, String> bodyData) async {
    String url = '${apiUrl}login';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
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
    String url = '${apiUrl}add-alarm';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> updatealaramapitwo(Map<String, String> bodyData) async {
    String url = '${apiUrl}update-alarm';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> showmarkerapi(Map<String, String> bodyData) async {
    String url = "${apiUrl}all-properties";
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url),body: bodyData,  headers: headers)
        .timeout(
      const Duration(seconds: 120),
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
    const url = 'https://www.navlex.net/wp-json/custom/v1/all-properties';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }


  //
  // Future<http.Response> addmarinacastomapi(Map<String, String> bodyData, List<File> imgs
  //     ) async {
  //   String url = '${apiUrl}add-custom-position';
  //   var responseJson;
  //   final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
  //   imageUploadRequest.headers.addAll(headers);
  //
  //   for (File image in imgs) {
  //     try {
  //       if (await image.exists()) {
  //         var stream = http.ByteStream(image.openRead());
  //         var length = await image.length();
  //         var multipartFile = http.MultipartFile(
  //           'post_images[]', // Try changing the key here if needed
  //           stream,
  //           length,
  //           filename: path.basename(image.path),
  //         );
  //         imageUploadRequest.files.add(multipartFile);
  //         print("Added file: ${path.basename(image.path)}, size: $length bytes");
  //       } else {
  //         print("File does not exist: ${image.path}");
  //       }
  //     } catch (e) {
  //       print("Error with file: ${image.path}, Error: $e");
  //     }
  //   }
  //
  //   imageUploadRequest.fields.addAll(bodyData);
  //   final streamResponse = await imageUploadRequest.send();
  //   var response = await http.Response.fromStream(streamResponse);
  //   responseJson = responses(response);
  //   // print("responseJson = ${json.decode(responseJson)}");
  //   return responseJson;
  // }



  // Future<http.Response> addmarinacastomapi(Map<String, String> bodyData, List<File> imgs) async {
  //   String url = '${apiUrl}add-custom-position';
  //
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.headers.addAll(headers);
  //
  //   // Printing the request URL and headers
  //   print("Request URL: $url");
  //   print("Headers: $headers");
  //
  //   // Adding and printing body data
  //   request.fields.addAll(bodyData);
  //   print("Body Data:");
  //   bodyData.forEach((key, value) {
  //     print("  $key: $value");
  //   });
  //
  //   // Adding files and preparing a string to print full body details
  //   List<String> filesDetails = [];
  //   for (File image in imgs) {
  //     try {
  //       if (await image.exists()) {
  //         var stream = http.ByteStream(image.openRead());
  //         var length = await image.length();
  //         var multipartFile = http.MultipartFile(
  //           'post_images', // Adjust this key if necessary
  //           stream,
  //           length,
  //           filename: path.basename(image.path),
  //         );
  //         request.files.add(multipartFile);
  //
  //         // Collecting file details for full body print
  //         filesDetails.add("{ Filename: ${path.basename(image.path)}, Size: $length bytes }");
  //       } else {
  //         print("File does not exist: ${image.path}");
  //       }
  //     } catch (e) {
  //       print("Error with file: ${image.path}, Error: $e");
  //     }
  //   }
  //
  //   // Printing full request body data (fields and files)
  //   print("Full Body Data:");
  //   print("{");
  //   bodyData.forEach((key, value) {
  //     print("  $key: $value,");
  //   });
  //   print("  post_images[]: [${filesDetails.join(", ")}]");
  //   print("}");
  //
  //   try {
  //     // Send the request and get the response
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //
  //     // Print the response status code and body
  //     print("Response Status Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //
  //     final responseJson = responses(response);
  //     return responseJson;
  //   } on SocketException {
  //     print("No Internet connection");
  //     throw Exception('No Internet connection');
  //   } catch (e) {
  //     print("An error occurred: $e");
  //     throw Exception('An error occurred');
  //   }
  // }
  Future<http.Response> addmarinacastomapi(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}add-custom-position';
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));

    // Add headers
    imageUploadRequest.headers.addAll(headers);

    // Add images with indexed field names (e.g., upload_file[0], upload_file[1], ...)
    if (imagePaths.isNotEmpty) {
      for (var i = 0; i < imagePaths.length; i++) {
        var file = await http.MultipartFile.fromPath(
          'post_images[$i]',  // Use indexed field names here
          imagePaths[i],
          contentType: MediaType('image', 'jpeg'), // Adjust as needed
        );
        imageUploadRequest.files.add(file);
      }
    }

    // Add body data
    imageUploadRequest.fields.addAll(bodyData);

    // Send request
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    // Check for success or parse response
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to upload images. Status code: ${response.statusCode}');
    }
  }
  // Future<http.Response> addmarinacastomapi(Map<String, String> bodyData, List<File> imgs) async {
  //   String url = '${apiUrl}add-custom-position';
  //
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.headers.addAll(headers);
  //
  //   // Print the request URL and headers for debugging
  //   print("Request URL: $url");
  //   print("Headers: $headers");
  //
  //   // Add body data and print each key-value pair for debugging
  //   request.fields.addAll(bodyData);
  //   print("Body Data:");
  //   bodyData.forEach((key, value) {
  //     print("  $key: $value");
  //   });
  //
  //   // Add each image with an indexed field name and print file details
  //   List<String> filesDetails = [];
  //   for (int i = 0; i < imgs.length; i++) {
  //     File image = imgs[i];
  //     try {
  //       if (await image.exists()) {
  //         var stream = http.ByteStream(image.openRead());
  //         var length = await image.length();
  //         var multipartFile = http.MultipartFile(
  //           'post_images[$i]',  // Indexed field names (e.g., post_images[0], post_images[1], ...)
  //           stream,
  //           length,
  //           filename: path.basename(image.path),
  //           contentType: MediaType('image', 'jpeg'),  // Adjust content type if needed
  //         );
  //         request.files.add(multipartFile);
  //
  //         // Collect file details for full body print
  //         filesDetails.add("{ Filename: ${path.basename(image.path)}, Size: $length bytes }");
  //       } else {
  //         print("File does not exist: ${image.path}");
  //       }
  //     } catch (e) {
  //       print("Error with file: ${image.path}, Error: $e");
  //     }
  //   }
  //
  //   // Print full request body data (fields and files)
  //   print("Full Body Data:");
  //   print("{");
  //   bodyData.forEach((key, value) {
  //     print("  $key: $value,");
  //   });
  //   print("  post_images[]: [${filesDetails.join(", ")}]");
  //   print("}");
  //
  //   try {
  //     // Send the request and get the response
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //
  //     // Print the response status code and body for debugging
  //     print("Response Status Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //
  //     final responseJson = responses(response);
  //     return responseJson;
  //   } on SocketException {
  //     print("No Internet connection");
  //     throw Exception('No Internet connection');
  //   } catch (e) {
  //     print("An error occurred: $e");
  //     throw Exception('An error occurred');
  //   }
  // }


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
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> reportapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}add-report-position';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> climpositiomnapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}claim-marina';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
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
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }
  Future<http.Response> subscriptionplanapi() async {
    String url = '${apiUrl}subscription-plan';
    print("wedtherurl${url}");
    var responseJson;
    final response = await http
        .post(Uri.parse(url),headers: headers)
        .timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }


  Future<http.Response> useralaramapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}user-alarms';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 180),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }


  Future<http.Response> deletealarmapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}delete-alarm';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }


  Future<http.Response> newupdatealaramapi(Map<String, String> bodyData) async {
    String url = '${apiUrl}alarm-details';
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    print(response.body);
    return responseJson;
  }



  Future<http.Response> addnewimageviedewtailimage(Map<String, String> bodyData, List<String> imagePaths) async {
    String url = '${apiUrl}view-position-image';
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));

    // Add headers
    imageUploadRequest.headers.addAll(headers);

    // Add images with indexed field names (e.g., upload_file[0], upload_file[1], ...)
    if (imagePaths.isNotEmpty) {
      for (var i = 0; i < imagePaths.length; i++) {
        var file = await http.MultipartFile.fromPath(
          'upload_file[$i]',  // Use indexed field names here
          imagePaths[i],
          contentType: MediaType('image', 'jpeg'), // Adjust as needed
        );
        imageUploadRequest.files.add(file);
      }
    }

    // Add body data
    imageUploadRequest.fields.addAll(bodyData);

    // Send request
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    // Check for success or parse response
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to upload images. Status code: ${response.statusCode}');
    }
  }


}
