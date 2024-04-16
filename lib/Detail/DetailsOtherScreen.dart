import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/AddFavouritePositionModal.dart';
import '../Modal/AddReviewModal.dart';
import '../Modal/AddViewOtherModal.dart';
import '../Modal/OnwViewPostionModal.dart';
import '../Provider/Authprovider.dart';
import 'CategorywiseViewScreen.dart';
import 'DetailsScreen.dart';
import 'OtherWarningDetailsScreen.dart';

class DetailsOtherScreen extends StatefulWidget {
  String? postid;
  DetailsOtherScreen({super.key,this.postid});

  @override
  State<DetailsOtherScreen> createState() => _DetailsOtherScreenState();
}


class _DetailsOtherScreenState extends State<DetailsOtherScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _review = TextEditingController();
  int _rating = 0;
  bool isLoading =true;
  String htmlString = '';
  String plainText = '';
  final _formKey = GlobalKey<FormState>();
  bool showError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewposition();
    print("Postidavigayache:-${widget.postid.toString()}");
  }
  Widget build(BuildContext context) {
    return commanScreen(
        isLoading: isLoading,
        scaffold:Scaffold(
            key: _scaffoldKeyProductlistpage,
            drawer: drawer1(),
            backgroundColor: bgcolor,
            body:isLoading
                ? Container()
                : SingleChildScrollView(
                child: Column(children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: bgcolor, // Border color
                                width: 2.sp, // Border width
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl:
                                addviewothermodal?.data?.thumbnail ?? "",
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, progress) =>
                                    Container(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(Default_Profile, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 5.h,
                        left: 4.w,
                        right: 3.w,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  IconButton(
                                      onPressed: () {
                                        _scaffoldKeyProductlistpage.currentState
                                            ?.openDrawer();
                                      },
                                      icon: Icon(
                                        Icons.menu_rounded,
                                        color: blackback,
                                        size: 23.sp,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Column(children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 90.w,
                            child: Text(
                              addviewothermodal?.data?.title==""||addviewothermodal?.data?.title==null?"N/A":addviewothermodal?.data?.title ?? "",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: blackback,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Text(
                            " ⭐️ 4.8 [${addviewothermodal?.reviews?.length} reviews]",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "volken"),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          // Icon(
                          //   Icons.add_location,
                          //   color: Colors.black,
                          //   size: 20.sp,
                          // ),
                          // Text(
                          //   "Sleman,Yogyakarta",
                          //   style: TextStyle(
                          //       letterSpacing: 1,
                          //       color: secondary,
                          //       fontSize: 12.sp,
                          //       fontWeight: FontWeight.normal,
                          //       fontFamily: "volken"),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Container(
                      //           margin: EdgeInsets.symmetric(horizontal: 1.w),
                      //           height: 15.w,
                      //           width: 15.w,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(15),
                      //             border: Border.all(
                      //               color: bgcolor, // Border color
                      //               width: 2.sp, // Border width
                      //             ),
                      //           ),
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(15),
                      //             child: CachedNetworkImage(
                      //               imageUrl:
                      //                   'https://i.pinimg.com/originals/51/e0/d5/51e0d5aa27808ce689e3dd5a5cd7685a.png',
                      //               fit: BoxFit.cover,
                      //               progressIndicatorBuilder:
                      //                   (context, url, progress) =>
                      //                       CircularProgressIndicator(),
                      //               errorWidget: (context, url, error) =>
                      //                   Image.asset(Default_Profile, fit: BoxFit.cover),
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           width: 3.w,
                      //         ),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text("Rabert Downerny",
                      //                 style: TextStyle(
                      //                     letterSpacing: 1,
                      //                     color: Colors.black,
                      //                     fontSize: 12.sp,
                      //                     fontWeight: FontWeight.bold,
                      //                     fontFamily: "volken")),
                      //             SizedBox(
                      //               height: 0.5.h,
                      //             ),
                      //             Text("Boat Owner",
                      //                 style: TextStyle(
                      //                     letterSpacing: 1,
                      //                     color: secondary,
                      //                     fontSize: 12.sp,
                      //                     fontWeight: FontWeight.normal,
                      //                     fontFamily: "volken")),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Container(
                      //           height: 12.w,
                      //           width: 12.w,
                      //           alignment: Alignment.center,
                      //           padding: EdgeInsetsDirectional.all(2.2.w),
                      //           decoration: BoxDecoration(
                      //             color: blackback,
                      //             borderRadius: BorderRadius.circular(900),
                      //           ),
                      //           child: Icon(
                      //             Icons.sms,
                      //             color: Colors.white,
                      //             size: 15.sp,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),

                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Text("Description :-",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: blackback,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken"))
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 95.w,
                            padding:
                            EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: secondary, width: 1.sp),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ReadMoreText(
                              '${addviewothermodal?.data?.content==""||addviewothermodal?.data?.content==null?"N/A":addviewothermodal?.data?.content ?? ""}',
                              trimLines: 4,
                              trimLength: 146,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Length,
                              trimCollapsedText: ' Show more',
                              trimExpandedText: ' Show less',
                              moreStyle: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken",
                                  letterSpacing: 1,
                                  color: blackback),
                              lessStyle: TextStyle(
                                  fontSize: 11.sp,
                                  fontFamily: "volken",
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: blackback),
                              style: TextStyle(
                                height: 1.5,
                                color: secondary,
                                fontFamily: "volken",
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),


                      Row(
                        children: [
                          Text("Nearby Listings :-",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: blackback,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken")),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        height: 30.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: addviewothermodal?.nearbyPosts?.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.sp, color: secondary),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: 15.h,
                                          width: 45.w,
                                          imageUrl: addviewothermodal?.nearbyPosts?[index].thumbnail ?? "" ,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (context, url, progress) => Container(
                                              alignment: Alignment.center,
                                              child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                Default_Profile,
                                              ),
                                        ),
                                      ),
                                      loginmodal?.userId==""||loginmodal?.userId==null?Container():Positioned(
                                        top: 0.2.h,
                                        left: 34.w,
                                        child: InkWell(
                                          onTap: (){
                                            print("datavalye${addviewothermodal?.nearbyPosts?[index].isFavorite}");
                                            addfevorite( (addviewothermodal?.nearbyPosts?[index].isFavorite)!,(addviewothermodal
                                                ?.nearbyPosts?[
                                            index]
                                                .id
                                            )
                                                ?.toString() ??
                                                "");
                                            print("abc");
                                          },
                                          child: Container(
                                            height: 9.w,
                                            width: 9.w,
                                            alignment: Alignment.center,
                                            padding: EdgeInsetsDirectional.all(2.2.w),
                                            decoration: BoxDecoration(
                                              color: blackback,
                                              borderRadius: BorderRadius.circular(900),
                                            ),
                                            child: addviewothermodal?.nearbyPosts?[index].isFavorite==true?Icon(
                                              CupertinoIcons.heart_fill,
                                              color: Colors.white,
                                              size: 15.sp,
                                            ) :Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                              size: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 42.w,
                                        child: Text(
                                          addviewothermodal?.nearbyPosts?[index].title==""|| addviewothermodal?.nearbyPosts?[index].title==null?"N/A":(addviewothermodal?.nearbyPosts?[index].title).toString(),
                                         maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: "Volkan",
                                            letterSpacing: 1.2,
                                            color: secondary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  batan(
                                      title: "View Details",
                                      route: () {
                                        if (addviewothermodal
                                            ?.nearbyPosts?[index]
                                            .postCategory ==
                                            "Warning") {
                                          Get.back();
                                          Get.to(DetailsWarningDetailsScreen(
                                            postid: (addviewothermodal
                                                ?.nearbyPosts?[index]
                                                .id)
                                                ?.toString() ??
                                                "",
                                          ));
                                        } else if (addviewothermodal
                                            ?.nearbyPosts?[index]
                                            .postCategory ==
                                            "Other") {
                                          Get.back();
                                          Get.to(DetailsOtherScreen(
                                            postid: (addviewothermodal
                                                ?.nearbyPosts?[index]
                                                .id)
                                                ?.toString() ??
                                                "",
                                          ));
                                        } else if (addviewothermodal
                                            ?.nearbyPosts?[index]
                                            .postCategory ==
                                            "Anchorages") {
                                          Get.back();
                                          Get.to(DetailsScreen(
                                              postid: (addviewothermodal
                                                  ?.nearbyPosts?[
                                              index]
                                                  .id)
                                                  ?.toString() ??
                                                  ""));
                                        } else
                                              () {
                                            Get.back();
                                            Get.to(CategoryWiseViewScreen(
                                                postid: (addviewothermodal
                                                    ?.nearbyPosts?[
                                                index]
                                                    .id)
                                                    ?.toString() ??
                                                    ""));
                                          };

                                      },
                                      hight: 5.h,
                                      width: 30.w,
                                      txtsize: 12.sp)
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Review",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: blackback,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken")),
                          loginmodal?.userId==""||loginmodal?.userId==null?Container():InkWell(
                            onTap: () {

                              showratingpop1();
                            },
                            child: Text("Add Review",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: blackback,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ),
                        ],
                      ),
                      for (int i = 0; i < (addviewothermodal?.reviews?.length ?? 0); i++) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 0.5.h),
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey.shade400, width: 0.5),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                                Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20.w,
                                        width: 20.w,
                                        padding: EdgeInsets.all(1.w),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(90),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                              addviewothermodal?.reviews?[i].userImg ?? "",
                                              progressIndicatorBuilder:
                                                  (context, url, progress) => Center(
                                                  child:
                                                  CircularProgressIndicator()),
                                              errorWidget: (context, url, error) =>
                                                  Icon(
                                                    Icons.person,
                                                    size: 15.w,
                                                    color: Colors.white,
                                                  )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 60.w,
                                                child: Text(
                                                  addviewothermodal?.reviews?[i].name==""||addviewothermodal?.reviews?[i].name==null?"N/A":(addviewothermodal?.reviews?[i].name).toString(),
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: "volken",
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 14.sp,
                                              ),
                                              Text(
                                                addviewothermodal?.reviews?[i].reviewerRating==""||addviewothermodal?.reviews?[i].reviewerRating==null?"0":(addviewothermodal?.reviews?[i].reviewerRating).toString(),
                                                style: TextStyle(
                                                  fontFamily: "volken",
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5,
                                                  color: secondary.withOpacity(0.45),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          SizedBox(
                                            width: 65.w,
                                            child: Text(
                                              addviewothermodal?.reviews?[i].reviewSummary?.xsReviwSummery==""||addviewothermodal?.reviews?[i].reviewSummary?.xsReviwSummery==null?"N/A":(addviewothermodal?.reviews?[i].reviewSummary?.xsReviwSummery).toString(),
                                              style: TextStyle(
                                                fontFamily: "volken",
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                                color: secondary.withOpacity(0.45),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        )
                      ]
                    ]),
                  )
                ]))));
  }


  viewposition() {
    final Map<String, String> data = {};
    data['post_id'] =widget.postid.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewsinganalpositionviewapi(data).then((response) async {
          addviewothermodal =
              AddViewOtherModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && addviewothermodal?.success == true) {

            print("otherwiseapicall");
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
  addreview() {
    if (_formKey.currentState!.validate()){
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['post_id'] = widget.postid.toString();
      data['user_id'] = (loginmodal?.userId).toString();
      data['rating'] = _rating.toString();
      data['review_summary'] = _review.text.trim().toString();
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().addreviewapi(data).then((response) async {
            addreviewmodal =
                AddReviewModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && addreviewmodal?.success == true) {
              EasyLoading.showSuccess(addreviewmodal?.message ?? '');
              viewposition();
              setState(() {

              });
            } else {
              EasyLoading.showError(addreviewmodal?.message ?? '');
              setState(() {

              });
            }
          });
        } else {
          EasyLoading.showError(addreviewmodal?.message ?? '');
          setState(() {

          });
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
  showratingpop1() {
    setState(() {
      _review.clear();
      _rating = 0;
      showError = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // backgroundColor: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          // height:  MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bgcolor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 7.w,
                                    width: 7.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        color: primary),
                                    child: InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 15.sp,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Rating :-",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Volkan"),
                                  ),
                                  SizedBox(height: 1.h),
                                  RatingBar.builder(
                                    itemSize: 25,
                                    initialRating: _rating.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    glow: false,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    unratedColor: Colors.amber,
                                    itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, index) {
                                      if (index < _rating.floor()) {
                                        return Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        );
                                      } else {
                                        return Icon(
                                          Icons.star_border,
                                          color: Colors.amber,
                                        );
                                      }
                                    },
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        _rating = rating.toInt();
                                        showError = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              if (showError)
                                SizedBox(
                                  height: 2.h,
                                ),
                              if (showError)
                                Center(
                                  child: Text(
                                    '* Please Select Rating *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Volkan",
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Review  : ",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Volkan")),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    width: 85.w,
                                    child: TextFormField(
                                      maxLines: 4,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black),
                                      controller: _review,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Your Review ";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(
                                        hintText: "Enter Your Review",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              batan(
                                  title: "Add Review",
                                  route: () {
                                    if (_rating == 0) {
                                      setState(() {
                                        showError = true;
                                      });
                                    } else {
                                      Get.back();
                                      addreview();
                                    }

                                  },
                                  hight: 6.h,
                                  width: 85.w,
                                  txtsize: 15.sp),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
  addfevorite(bool value,id) {

    EasyLoading.show(status: 'Please Wait ...');
    final Map<String, String> data = {};
    data['post_id'] = id.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    data['isFavorite'] =value?'0':'1' ;
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().addfevouriteapi(data).then((response) async {
          addfavouritepositionmodal =
              AddFavouritePositionModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && addfavouritepositionmodal?.success == true) {
            EasyLoading.showSuccess(addfavouritepositionmodal?.message ?? '');
            // viewposition();
            viewposition();
            print('very good');
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
