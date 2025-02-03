import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapposition/Detail/ViewOtherDetailsScreeen.dart';
import 'package:mapposition/Extras/Drwer.dart';
import 'package:sizer/sizer.dart';

import '../Detail/CategorywiseViewScreen.dart';
import '../Detail/DetailsOtherScreen.dart';
import '../Detail/OtherWarningDetailsScreen.dart';
import '../Extras/Const.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/bottombar.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/DeletePositionModal.dart';
import '../Modal/MyMarinaViewModal.dart';
import '../Provider/Authprovider.dart';
import 'AddMarinaScreen.dart';

class MyMarinaListScreen extends StatefulWidget {
  const MyMarinaListScreen({super.key});

  @override
  State<MyMarinaListScreen> createState() => _MyMarinaListScreenState();
}

class _MyMarinaListScreenState extends State<MyMarinaListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();

  bool isLoading = true;
  String htmlString = '';
  String plainText = '';
  late LatLng _currentPosition1 = LatLng(21.1702, 72.8311);
  double? lat1, lng1;

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;
    LatLng location = LatLng(lat, long);
    viewmymarina();
    setState(() {
      _currentPosition1 = location;
      lat1 = lat;
      lng1 = long;
      viewmymarina();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });

    htmlString = '';
    plainText = '';
    getLocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar:
          loginmodal?.userId == "" || loginmodal?.userId == null
              ? Container()
              : isLoading
                  ? Container()
                  : Bottombar(select_tab: 0),
      backgroundColor: Colors.white,
      drawer: drawer1(),
      key: _scaffoldKeyProductlistpage,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    header(
                        show: 1,
                        text: "Mine",
                        callback1: () {
                          _scaffoldKeyProductlistpage.currentState
                              ?.openDrawer();
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    mymarinaviewmodal?.positions?.length == null ||
                            mymarinaviewmodal?.positions?.length == 0
                        ? Center(
                            child: Container(
                              height: 80.h,
                              alignment: Alignment.center,
                              child: Text(
                                "No Positions Available",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "volken",
                                    letterSpacing: 1),
                              ),
                            ),
                          )
                        : Container(
                            height: 78.h,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  mymarinaviewmodal?.positions?.length ?? 0,
                              itemBuilder: (context, i) {
                                String htmlString = (mymarinaviewmodal
                                            ?.positions?[i]
                                            .properties
                                            ?.description)
                                        ?.toString() ??
                                    "";
                                String plainText = removeHtmlTags(htmlString);

                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        mymarinaviewmodal?.positions?[i]
                                                    .properties?.termName ==
                                                "Anchorage"
                                            ? Get.to(CategoryWiseViewScreen(
                                                postid: (mymarinaviewmodal
                                                            ?.positions?[i]
                                                            .properties
                                                            ?.postId)
                                                        ?.toString() ??
                                                    "",
                                              ))
                                            : mymarinaviewmodal?.positions?[i]
                                                        .properties?.termName ==
                                                    "Warning"
                                                ? Get.to(
                                                    DetailsWarningDetailsScreen(
                                                    postid: (mymarinaviewmodal
                                                                ?.positions?[i]
                                                                .properties
                                                                ?.postId)
                                                            ?.toString() ??
                                                        "",
                                                  ))
                                                : mymarinaviewmodal
                                                            ?.positions?[i]
                                                            .properties
                                                            ?.termName ==
                                                        "Marina"
                                                    ? Get.to(DetailsOtherScreen(
                                                        postid: (mymarinaviewmodal
                                                                    ?.positions?[
                                                                        i]
                                                                    .properties
                                                                    ?.postId)
                                                                ?.toString() ??
                                                            "",
                                                      ))
                                                    : Get.to(ViewOterDetailsScreen(
                                                        postid: (mymarinaviewmodal
                                                                    ?.positions?[
                                                                        i]
                                                                    .properties
                                                                    ?.postId)
                                                                ?.toString() ??
                                                            ""));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 0.7.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: secondary, width: 1.sp)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 35.w,
                                                  width: 35.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: CachedNetworkImage(
                                                      imageUrl: (mymarinaviewmodal
                                                                  ?.positions?[
                                                                      i]
                                                                  .properties
                                                                  ?.postImage)
                                                              ?.toString() ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context,
                                                              url, progress) =>
                                                          Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Center(
                                                                  child:
                                                                      CircularProgressIndicator())),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              Default_Profile),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 4.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 0.h),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 46.w,
                                                          child: Text(
                                                            mymarinaviewmodal
                                                                        ?.positions?[
                                                                            i]
                                                                        .properties
                                                                        ?.title
                                                                        ?.isEmpty ??
                                                                    true
                                                                ? "N/A"
                                                                : (mymarinaviewmodal
                                                                        ?.positions?[
                                                                            i]
                                                                        .properties
                                                                        ?.title)
                                                                    .toString(),
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 14.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "volken",
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 0.5.h),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 40.w,
                                                          child: Text(
                                                            mymarinaviewmodal
                                                                        ?.positions?[
                                                                            i]
                                                                        .properties
                                                                        ?.description
                                                                        ?.isEmpty ??
                                                                    true
                                                                ? "N/A"
                                                                : (plainText)
                                                                    .toString(),
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 13.sp,
                                                                color:
                                                                    secondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "volken",
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 0.5.h),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Ratings :',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 13.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "volken",
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),
                                                        Text(
                                                          mymarinaviewmodal
                                                                      ?.positions?[
                                                                          i]
                                                                      .properties
                                                                      ?.onlyAvg ==
                                                                  null
                                                              ? "N/A"
                                                              : (mymarinaviewmodal
                                                                      ?.positions?[
                                                                          i]
                                                                      .properties
                                                                      ?.onlyAvg)
                                                                  .toString(),
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 13.sp,
                                                            color: secondary,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily: "",
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                        SizedBox(width: 0.5.w),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      0.5.h),
                                                          child: Text(
                                                            '⭐️',
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.orange,
                                                              letterSpacing: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 0.5.h),
                                                    batan(
                                                        title: "View Details",
                                                        route: () {
                                                          mymarinaviewmodal
                                                                      ?.positions?[
                                                                          i]
                                                                      .properties
                                                                      ?.termName ==
                                                                  "Anchorage"
                                                              ? Get.to(
                                                                  CategoryWiseViewScreen(
                                                                  postid: (mymarinaviewmodal
                                                                              ?.positions?[i]
                                                                              .properties
                                                                              ?.postId)
                                                                          ?.toString() ??
                                                                      "",
                                                                ))
                                                              : mymarinaviewmodal
                                                                          ?.positions?[
                                                                              i]
                                                                          .properties
                                                                          ?.termName ==
                                                                      "Warning"
                                                                  ? Get.to(
                                                                      DetailsWarningDetailsScreen(
                                                                      postid:
                                                                          (mymarinaviewmodal?.positions?[i].properties?.postId)?.toString() ??
                                                                              "",
                                                                    ))
                                                                  : mymarinaviewmodal
                                                                              ?.positions?[
                                                                                  i]
                                                                              .properties
                                                                              ?.termName ==
                                                                          "Marina"
                                                                      ? Get.to(
                                                                          DetailsOtherScreen(
                                                                          postid:
                                                                              (mymarinaviewmodal?.positions?[i].properties?.postId)?.toString() ?? "",
                                                                        ))
                                                                      : Get.to(ViewOterDetailsScreen(
                                                                          postid:
                                                                              (mymarinaviewmodal?.positions?[i].properties?.postId)?.toString() ?? ""));
                                                        },
                                                        hight: 6.h,
                                                        width: 40.w,
                                                        txtsize: 15.sp)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 84.w,
                                      top: 1.h,
                                      child: InkWell(
                                        onTap: () {
                                          deleteposition((mymarinaviewmodal
                                                      ?.positions?[i]
                                                      .properties
                                                      ?.postId)
                                                  ?.toString() ??
                                              "");
                                        },
                                        child: Container(
                                          width: 10.w,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.black,
                                          ),
                                          child: Icon(Icons.delete,
                                              color: Colors.white, size: 15.sp),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 84.w,
                                      top: 8.h,
                                      child: InkWell(
                                        onTap: () {
                                          // deleteposition((mymarinaviewmodal?.positions?[i].properties ?.postId)?.toString() ?? "");
                                          Get.to(AddMarinaScreen(
                                            lat: lat1.toString(),
                                            lng: lng1.toString(),
                                            postid: (mymarinaviewmodal
                                                        ?.positions?[i]
                                                        .properties
                                                        ?.postId)
                                                    ?.toString() ??
                                                "",
                                          ));
                                        },
                                        child: Container(
                                          width: 10.w,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.black,
                                          ),
                                          child: Icon(Icons.edit,
                                              color: Colors.white, size: 15.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                    //     for (int i = 0; i < (mymarinaviewmodal?.positions?.length ?? 0); i++) ...[
                    // htmlString = (mymarinaviewmodal?.positions?[i].properties?.description).toString();
                    // plainText = removeHtmlTags(htmlString);
                    //       Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         margin: EdgeInsets.symmetric(vertical: 0.7.h),
                    //         padding:
                    //         EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(10),
                    //             border: Border.all(color: secondary, width: 1.sp)),
                    //         child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Container(
                    //                     height: 35.w,
                    //                     width: 35.w,
                    //                     child: ClipRRect(
                    //                       borderRadius: BorderRadius.circular(15),
                    //                       child: CachedNetworkImage(
                    //                         imageUrl:
                    //                         (mymarinaviewmodal?.positions?[i].properties?.postImage).toString() ,
                    //                         fit: BoxFit.cover,
                    //                         progressIndicatorBuilder:
                    //                             (context, url, progress) =>
                    //                             CircularProgressIndicator(),
                    //                         errorWidget: (context, url, error) =>
                    //                             Image.asset(Default_Profile),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     width: 4.w,
                    //                   ),
                    //                   Row(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     mainAxisAlignment: MainAxisAlignment.start,
                    //                     children: [
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                         mainAxisAlignment:
                    //                         MainAxisAlignment.start,
                    //                         children: [
                    //                           SizedBox(
                    //                             height: 0.h,
                    //                           ),
                    //                           Row(
                    //                             mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                             children: [
                    //                               SizedBox(
                    //                                 width: 46.w,
                    //                                 child: Text(
                    //                                   mymarinaviewmodal?.positions?[i].properties?.title==""||mymarinaviewmodal?.positions?[i].properties?.title==null?"N/A":(mymarinaviewmodal?.positions?[i].properties?.title).toString(),
                    //                                   maxLines: 1,
                    //                                   style: TextStyle(
                    //                                       overflow: TextOverflow.ellipsis,
                    //                                       fontSize: 14.sp,
                    //                                       color: Colors.black,
                    //                                       fontWeight: FontWeight.bold,
                    //                                       fontFamily: "volken",
                    //                                       letterSpacing: 1),
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           SizedBox(
                    //                             height: 0.5.h,
                    //                           ),
                    //                           Row(
                    //                             mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                             children: [
                    //                               SizedBox(width: 1.w),
                    //                               SizedBox(
                    //                                 width: 40.w,
                    //                                 child: Text(
                    //                                   mymarinaviewmodal?.positions?[i].properties?.description==""||mymarinaviewmodal?.positions?[i].properties?.description==null?"N/A" :(mymarinaviewmodal?.positions?[i].properties?.description).toString(),
                    //                                   maxLines: 1,
                    //                                   style: TextStyle(
                    //                                       overflow:
                    //                                       TextOverflow.ellipsis,
                    //                                       fontSize: 13.sp,
                    //                                       color: secondary,
                    //                                       fontWeight: FontWeight.w500,
                    //                                       fontFamily: "volken",
                    //                                       letterSpacing: 1),
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           SizedBox(
                    //                             height: 0.5.h,
                    //                           ),
                    //                           Row(
                    //                             mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                             children: [
                    //                               Text(
                    //                                 'Ratings :',
                    //                                 maxLines: 1,
                    //                                 style: TextStyle(
                    //                                   overflow: TextOverflow.ellipsis,
                    //                                   fontSize: 13.sp,
                    //                                   color: Colors.black,
                    //                                   fontWeight: FontWeight.w500,
                    //                                   fontFamily: "volken",
                    //                                   letterSpacing: 1,
                    //                                 ),
                    //                               ),
                    //                               SizedBox(width: 2.w),
                    //                               Text(
                    //                                 mymarinaviewmodal?.positions?[i].properties?.onlyAvg==""||mymarinaviewmodal?.positions?[i].properties?.onlyAvg==null?"N/A" :(mymarinaviewmodal?.positions?[i].properties?.onlyAvg).toString(),
                    //                                 maxLines: 1,
                    //                                 style: TextStyle(
                    //                                   overflow: TextOverflow.ellipsis,
                    //                                   fontSize: 13.sp,
                    //                                   color: secondary,
                    //                                   fontWeight: FontWeight.w500,
                    //                                   fontFamily: "",
                    //                                   letterSpacing: 1,
                    //                                 ),
                    //                               ),
                    //                               SizedBox(width: 0.5.w),
                    //                               Padding(
                    //                                 padding: EdgeInsets.only(
                    //                                     bottom: 0.5.h),
                    //                                 child: Text(
                    //                                   '⭐️',
                    //                                   maxLines: 1,4
                    //                                   style: TextStyle(
                    //                                     overflow:
                    //                                     TextOverflow.ellipsis,
                    //                                     fontSize: 12.sp,
                    //                                     color: Colors.orange,
                    //                                     letterSpacing: 1,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           SizedBox(
                    //                             height: 0.5.h,
                    //                           ),
                    //                           batan(
                    //                               title: "View Details",
                    //                               route: () {
                    //                                 Get.to(DetailsScreen(postid:(mymarinaviewmodal?.positions?[i].properties?.postId).toString() ,));
                    //                               },
                    //                               hight: 6.h,
                    //                               width: 40.w,
                    //                               txtsize: 15.sp)
                    //                         ],
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //
                    //             ]),
                    //       ),
                    //
                    //     ],
                  ],
                ),
              ),
            ),
    );
  }

  viewmymarina() {
    final Map<String, String> data = {};
    data['user_id'] = (loginmodal?.userId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().mymerinaviewapi(data).then((response) async {
          mymarinaviewmodal =
              MyMarinaViewModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && loginmodal?.success == true) {
            setState(() {
              isLoading = false;
              print(plainText);
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }

  String removeHtmlTags(String htmlString) {
    // Use a regular expression to remove HTML tags
    return htmlString.replaceAll(RegExp(r'<[^>]*>|\"'), '');
  }

  deleteposition(String value) {
    EasyLoading.show(status: 'Please Wait ...');
    final Map<String, String> data = {};
    data['post_id'] = value.toString();
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().deletepositionapi(data).then((response) async {
          deletepositionmodal =
              DeletePositionModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              deletepositionmodal?.success == true) {
            EasyLoading.showSuccess(deletepositionmodal?.message ?? '');
            viewmymarina();
            setState(() {
              isLoading = false;
              print(plainText);
            });
          } else {
            EasyLoading.showError(deletepositionmodal?.message ?? '');
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        EasyLoading.showError(deletepositionmodal?.message ?? '');
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
}
