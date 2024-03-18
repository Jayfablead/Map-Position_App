import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                              'https://thumbs.dreamstime.com/z/tourist-shopping-street-botting-dock-famous-giethoorn-village-netherlands-popular-car-free-eurpoe-may-288426256.jpg',
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              CircularProgressIndicator(),
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
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
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
                            IconButton(
                                onPressed: () {
                                  _scaffoldKeyProductlistpage.currentState?.openDrawer();
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
            SizedBox(height: 2.h,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Tony Stark's Dream Mansion", style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "volken"),),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Row(
                    children: [
                      Text(" ⭐️ 4.8 [320 reviews]", style: TextStyle(
                          letterSpacing: 1,
                          color: secondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken"),),
                      SizedBox(width: 3.w,),
                      Icon(Icons.add_location,color: Colors.black,size: 20.sp,),
                      Text("Sleman,Yogyakarta", style: TextStyle(
                          letterSpacing: 1,
                          color: secondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken"),),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     Row(
                       children: [
                         Container(
                           margin: EdgeInsets.symmetric(horizontal: 1.w),
                           height: 15.w,
                           width: 15.w,
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
                               'https://i.pinimg.com/originals/51/e0/d5/51e0d5aa27808ce689e3dd5a5cd7685a.png',
                               fit: BoxFit.cover,
                               progressIndicatorBuilder:
                                   (context, url, progress) =>
                                   CircularProgressIndicator(),
                               errorWidget: (context, url, error) =>
                                   Image.asset(Default_Profile, fit: BoxFit.cover),
                             ),
                           ),
                         ),
                         SizedBox(width: 3.w,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Rabert Downerny",style: TextStyle(
                                 letterSpacing: 1,
                                 color: Colors.black,
                                 fontSize: 12.sp,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: "volken")),
                             SizedBox(height: 0.5.h,),
                             Text("Boat Owner",style: TextStyle(
                                 letterSpacing: 1,
                                 color: secondary,
                                 fontSize: 12.sp,
                                 fontWeight: FontWeight.normal,
                                 fontFamily: "volken")),
                           ],
                         ),
                       ],
                     ),
                      Row(
                        children: [
                          Container(
                            height: 12.w,
                            width: 12.w,
                            alignment: Alignment.center,
                            padding: EdgeInsetsDirectional.all(2.2.w),
                            decoration: BoxDecoration(
                              color: blackback,
                              borderRadius: BorderRadius.circular(900),
                            ),
                            child: Icon(
                              Icons.sms,
                              color: Colors.white,
                              size: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Row(
                    children: [
                      Text("Facilities Nearby :-",style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "volken")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.start ,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 18.w,
                        width: 18.w,
                        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),

                        child: ClipRRect(
                         borderRadius: BorderRadius.circular(15),
                         child: CachedNetworkImage(
                           imageUrl:
                           '',
                           fit: BoxFit.cover,
                           progressIndicatorBuilder:
                               (context, url, progress) =>
                               CircularProgressIndicator(),
                           errorWidget: (context, url, error) =>
                               Image.asset(Default_Profile, fit: BoxFit.cover),
                         ),
                            ),
                      )
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
