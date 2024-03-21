import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mapposition/Extras/Drwer.dart';
import 'package:sizer/sizer.dart';

import '../Detail/DetailsScreen.dart';
import '../Extras/Const.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/bottombar.dart';

class MyMarinaListScreen extends StatefulWidget {
  const MyMarinaListScreen({super.key});

  @override
  State<MyMarinaListScreen> createState() => _MyMarinaListScreenState();
}

class _MyMarinaListScreenState extends State<MyMarinaListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Bottombar(select_tab: 3),
      backgroundColor: Colors.white,
      drawer: drawer1(),
      key:_scaffoldKeyProductlistpage,
      body: SingleChildScrollView(
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            SizedBox(height: 5.h,),
            header(
                text: "My Marina",
                callback1: () {
                  _scaffoldKeyProductlistpage.currentState?.openDrawer();
                }),
            SizedBox(
              height: 2.h,
            ),
            for (int i = 0; i < 5; i++) ...[

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 0.7.h),
                padding:
                EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: secondary, width: 1.sp)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                'https://t3.ftcdn.net/jpg/03/80/28/28/360_F_380282819_bjauC6fkUfVQN6EFxVyzpkiiZcdVZFC1.jpg',
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, progress) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(Default_Profile),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 0.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 46.w,
                                        child: Text(
                                          'Catamaran boat parties usually last about four hours',
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
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 1.w),
                                      SizedBox(
                                        width: 40.w,
                                        child: Text(
                                          'Surat Gujarat India',
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
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
                                        '4',
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
                                        Get.to(DetailsScreen());
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

            ],
            SizedBox(height: 10.h,),
          ],
        ),
      ),
      ),
    );
  }
}
