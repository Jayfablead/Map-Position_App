import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Detail/CategorywiseViewScreen.dart';
import '../Detail/DetailsOtherScreen.dart';
import '../Detail/DetailsScreen.dart';
import '../Detail/OtherWarningDetailsScreen.dart';
import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/bottombar.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/AddFavouritePositionModal.dart';
import '../Modal/ViewFouriteModal.dart';
import '../Provider/Authprovider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
    GlobalKey<ScaffoldState>();

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isLoading =true;
  String htmlString = '';
  String plainText = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewFavourite();
    htmlString = '';
    plainText = '';
  }
  Widget build(BuildContext context) {
    return commanScreen(
        isLoading: isLoading,
        scaffold:Scaffold(
      extendBody: true,
      bottomNavigationBar:loginmodal?.userId==""||loginmodal?.userId==null? Container():isLoading? Container(): Bottombar(select_tab: 0),
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      backgroundColor: bgcolor,
      body:isLoading?Container(): SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              header(
                show: 1,
                  text: "Favourite",
                  callback1: () {
                    _scaffoldKeyProductlistpage.currentState?.openDrawer();
                  }),
              SizedBox(
                height: 2.h,
              ),

              viewfouritemodal?.positions?.length==0||viewfouritemodal?.positions?.length==null||viewfouritemodal?.positions?.length==""?Container(height: 70.h,child: Center(child: Text("No Favourite Available",style: TextStyle(color:Colors.black,fontSize: 15.sp),)),):Container(
                height: 75.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: viewfouritemodal?.positions?.length ?? 0,
                  itemBuilder: (context, i) {
                    String htmlString = (viewfouritemodal
                        ?.positions?[i]
                        .properties
                        ?.description)
                        ?.toString() ??
                        "";
                    String plainText = removeHtmlTags(htmlString);

                    return  Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 0.7.h),
                          padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: secondary, width: 1.sp)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 35.w,
                                      width: 35.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          viewfouritemodal?.positions?[i].properties?.postImage ?? "",
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                              Container(alignment: Alignment.center,child: Center(child: CircularProgressIndicator())),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(Default_Profile),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            SizedBox(
                                              width: 46.w,
                                              child: Text(
                                                viewfouritemodal?.positions?[i].properties?.title==""||viewfouritemodal?.positions?[i].properties?.title==null?"N/A":viewfouritemodal?.positions?[i].properties?.title ?? "" ,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "volken",
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 1.w),
                                                SizedBox(
                                                  width: 40.w,
                                                  child: Text(
                                                   viewfouritemodal?.positions?[i].properties?.description?.isEmpty ?? true ? "N/A":(plainText).toString(),

                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        fontSize: 13.sp,
                                                        color: secondary,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "volken",
                                                        letterSpacing: 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Ratings :',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "volken",
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                                Text(
                                                  viewfouritemodal?.positions?[i].properties?.onlyAvg==""||viewfouritemodal?.positions?[i].properties?.onlyAvg==null?"N/A":(viewfouritemodal?.positions?[i].properties?.onlyAvg).toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 13.sp,
                                                    color: secondary,
                                                    fontWeight: FontWeight.w500,
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
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      fontSize: 12.sp,
                                                      color: Colors.orange,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            batan(
                                                title: "View Details",
                                                route: () {
                                                  viewfouritemodal?.positions?[i].properties?.termName=="Warning"?Get.to(DetailsWarningDetailsScreen(postid:(viewfouritemodal?.positions?[i].properties ?.postId)?.toString() ?? "" ,)):viewfouritemodal?.positions?[i].properties?.termName=="Other"?Get.to(DetailsOtherScreen(postid:(viewfouritemodal?.positions?[i].properties ?.postId)?.toString() ?? "" ,)):viewfouritemodal?.positions?[i].properties?.termName=="Anchorages"?Get.to(DetailsScreen(
                                                      postid: (viewfouritemodal
                                                          ?.positions?[i].properties ?.postId) ?.toString() ??"")):
                                                  Get.to(CategoryWiseViewScreen(postid:(viewfouritemodal?.positions?[i].properties?.postId) ?.toString() ??""));
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

                              ]),
                        ),
                       Positioned(
                            right: 3.w,
                            top: 1.5.h,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    print("datavalye${addviewothermodal?.nearbyPosts?[i].isFavorite}");
                                    addfevorite(false,viewfouritemodal?.positions?[i].properties?.postId
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
                                    child: Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.white,
                                      size: 15.sp,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(height: 15.h,),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 15.h,),
            ],
          ),
        ),
      ),
        ));
  }
  viewFavourite() {
    final Map<String, String> data = {};

    data['user_id'] = (loginmodal?.userId).toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewfvouriteapi(data).then((response) async {
          viewfouritemodal =
              ViewFouriteModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 ) {
            print("anchioirapicall");
            setState(() {
              isLoading = false;
              print(plainText);
            });
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
    data['isFavorite'] = '0';
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().addfevouriteapi(data).then((response) async {
          addfavouritepositionmodal =
              AddFavouritePositionModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              addfavouritepositionmodal?.success == true) {
            EasyLoading.showSuccess(addfavouritepositionmodal?.message ?? '');
            viewFavourite();
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
