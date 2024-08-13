import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../Detail/CategorywiseViewScreen.dart';
import '../Detail/DetailsOtherScreen.dart';
import '../Detail/DetailsScreen.dart';
import '../Detail/OtherWarningDetailsScreen.dart';
import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/AddFavouritePositionModal.dart';
import '../Modal/ShoAllMarkerModal.dart';
import '../Provider/Authprovider.dart';

class AllPositionScreen extends StatefulWidget {
  const AllPositionScreen({super.key});

  @override
  State<AllPositionScreen> createState() => _AllPositionScreenState();
}

class _AllPositionScreenState extends State<AllPositionScreen> {
  bool isLoading =true;
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage1 =GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showmarker();
  }
  Widget build(BuildContext context) {
    return commanScreen(
        isLoading: isLoading,
        scaffold:Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          key: _scaffoldKeyProductlistpage1,
          backgroundColor: Colors.white,
          drawer: drawer1(),
      body: isLoading?Container():SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),

              header(
                  text: "Position",
                  callback1: () {
                    _scaffoldKeyProductlistpage1.currentState?.openDrawer();
                  }),
              SizedBox(
                height: 2.h,
              ),
              shoallmarkermodal?.positions?.length==null||shoallmarkermodal?.positions?.length==0?Center(
                child: Container(height: 80.h,alignment: Alignment.center,child: Text("No Position Available", style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight:
                    FontWeight.w500,
                    fontFamily:
                    "volken",
                    letterSpacing: 1), ),),
              ):Container(
                height: 85.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: shoallmarkermodal?.positions?.length ?? 0,
                  itemBuilder: (context, i) {
                    String htmlString = (shoallmarkermodal
                        ?.positions?[i]
                        .properties
                        ?.description)
                        ?.toString() ??
                        "";
                    String plainText = removeHtmlTags(htmlString);

                    return Stack(
                      children: [
                        InkWell(
                          onTap: (){
                            shoallmarkermodal?.positions?[i].properties?.termName=="Warning"?Get.to(DetailsWarningDetailsScreen(postid:(shoallmarkermodal?.positions?[i].properties ?.postId)?.toString() ?? "" ,)):shoallmarkermodal?.positions?[i].properties?.termName=="Other"?Get.to(DetailsOtherScreen(postid:(shoallmarkermodal?.positions?[i].properties ?.postId)?.toString() ?? "" ,)):shoallmarkermodal?.positions?[i].properties?.termName=="Anchorages"?Get.to(DetailsScreen(
                                postid: (shoallmarkermodal
                                    ?.positions?[
                                i]
                                    .properties
                                    ?.postId)
                                    ?.toString() ??
                                    "")):Get.to(CategoryWiseViewScreen(
                                postid: (shoallmarkermodal
                                    ?.positions?[
                                i]
                                    .properties
                                    ?.postId)
                                    ?.toString() ??
                                    ""));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin:
                            EdgeInsets.symmetric(vertical: 0.7.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
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
                                        BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: (shoallmarkermodal
                                              ?.positions?[i]
                                              .properties
                                              ?.postImage)
                                              ?.toString() ??
                                              "",
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (context, url,
                                              progress) =>
                                              Container(alignment: Alignment.center,child: Center(child: CircularProgressIndicator())),
                                          errorWidget:
                                              (context, url, error) =>
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
                                          MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 46.w,
                                              child: Text(
                                                shoallmarkermodal
                                                    ?.positions?[
                                                i]
                                                    .properties
                                                    ?.title
                                                    ?.isEmpty ??
                                                    true
                                                    ? "N/A"
                                                    : (shoallmarkermodal
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
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontFamily:
                                                    "volken",
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            // SizedBox(
                                            //   width: 40.w,
                                            //   child: Text(
                                            //     shoallmarkermodal
                                            //         ?.positions?[
                                            //     i]
                                            //         .properties
                                            //         ?.description
                                            //         ?.isEmpty ??
                                            //         true
                                            //         ? "N/A"
                                            //         : (plainText)
                                            //         .toString(),
                                            //     maxLines: 1,
                                            //     style: TextStyle(
                                            //         overflow:
                                            //         TextOverflow
                                            //             .ellipsis,
                                            //         fontSize: 13.sp,
                                            //         color: secondary,
                                            //         fontWeight:
                                            //         FontWeight.w500,
                                            //         fontFamily:
                                            //         "volken",
                                            //         letterSpacing: 1),
                                            //   ),
                                            // ),
                                            Container(
                                              height: 6.5.h,
                                              width: 10.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl: (shoallmarkermodal
                                                      ?.positions?[i]
                                                      .properties
                                                      ?.imgURL)
                                                      ?.toString() ??
                                                      "",
                                                  fit: BoxFit.fill,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                      progress) =>
                                                      Container(alignment: Alignment.center,child: Center(child: CircularProgressIndicator())),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(Default_Profile),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ratings :',
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                fontSize: 13.sp,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontFamily: "volken",
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            Text(
                                              shoallmarkermodal
                                                  ?.positions?[
                                              i]
                                                  .properties
                                                  ?.onlyAvg ==
                                                  null
                                                  ? "N/A"
                                                  : (shoallmarkermodal
                                                  ?.positions?[
                                              i]
                                                  .properties
                                                  ?.onlyAvg)
                                                  .toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                overflow: TextOverflow
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
                                              padding: EdgeInsets.only(
                                                  bottom: 0.5.h),
                                              child: Text(
                                                '⭐️',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  fontSize: 12.sp,
                                                  color: Colors.orange,
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
                                             Get.to(CategoryWiseViewScreen(
                                                  postid: (shoallmarkermodal
                                                      ?.positions?[
                                                  i]
                                                      .properties
                                                      ?.postId)
                                                      ?.toString() ??
                                                      ""));


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


                      ],
                    );
                  },
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
  showmarker() {
    print("dtadone");
    final Map<String, String> data = {};
    data['s'] = "";
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().showmarkerapi(data).then((response) async {
          shoallmarkermodal = ShoAllMarkerModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200) {
            print("api calling done");
            setState(() {
              isLoading = false;
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
  addfevorite(bool value, id) {
    EasyLoading.show(status: 'Please Wait ...');
    final Map<String, String> data = {};
    data['post_id'] = id.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    data['isFavorite'] = value ? '0' : '1';
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().addfevouriteapi(data).then((response) async {
          addfavouritepositionmodal =
              AddFavouritePositionModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              addfavouritepositionmodal?.success == true) {
            EasyLoading.showSuccess(addfavouritepositionmodal?.message ?? '');

            showmarker();
            print('details screen api call');
            setState(() {});
          } else {
            EasyLoading.showError(addreviewmodal?.message ?? '');
            setState(() {});
          }
        });
      } else {
        EasyLoading.showError(addreviewmodal?.message ?? '');
        setState(() {});
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
}
