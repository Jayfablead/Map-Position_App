import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/Headerwidget.dart';
import 'package:mapposition/LoginSinupScreen/ChangePasswordScreen.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Loader.dart';
import '../Extras/bottombar.dart';
import '../Extras/buildErrorDialog.dart';
import '../Favourite/FavouriteScreen.dart';
import '../Marina/AddMarinaScreen.dart';
import '../Marina/MyMarinaListScreen.dart';
import '../Modal/ViewProfileModal.dart';
import '../PrimiumPayments/PremiumScreen.dart';
import '../Provider/Authprovider.dart';
import 'EditProfileScreen.dart';
import 'SubscriptionAlarmScreen.dart';
import 'UpdateAlarmScreen.dart';
import 'ViewProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Viewprofile();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      backgroundColor: bgcolor,
      body:  isLoading ? Center(child: CircularProgressIndicator(),):  SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade200,
                  border: Border.all(
                    width: 1.sp,
                    color: secondary,
                  )
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  header(
                      show: 1,
                      text: "Profile",
                      callback1: () {
                        _scaffoldKeyProductlistpage.currentState?.openDrawer();
                      }),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        height: 30.w,
                        width: 30.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: secondary, // Border color
                            width: 1.sp, // Border width
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl:
                            viewprofilemodal?.userDetails?.profileImage ?? "",
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.asset(Default_Profile, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(viewprofilemodal?.userDetails?.userLogin==""||viewprofilemodal?.userDetails?.userLogin==null?"N/A":viewprofilemodal?.userDetails?.userLogin ?? "",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken"),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),

                  InkWell(
                    onTap: (){
                      Get.to(ViewPRofileScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bgcolor,
                          border: Border.all(color: secondary, width:1.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blackback,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: bgcolor,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("View Profile",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken")),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackback,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(EditProfileScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bgcolor,
                          border: Border.all(color: secondary, width:1.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blackback,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: bgcolor,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("Edit Profile",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken")),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackback,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Get.to(AddMarinaScreen());
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     padding:
                  //     EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: bgcolor,
                  //         border: Border.all(color: secondary, width:1.sp))
                  //     ,child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Container(
                  //               width: 10.w,
                  //               height: 10.w,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: blackback,
                  //               ),
                  //               child: Icon(
                  //                 Icons.directions_boat,
                  //                 color: bgcolor,
                  //                 size: 18.sp,
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 5.w,
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text("Add Position",
                  //                     style: TextStyle(
                  //                         letterSpacing: 1,
                  //                         color: secondary,
                  //                         fontSize: 15.sp,
                  //                         fontWeight: FontWeight.normal,
                  //                         fontFamily: "volken")),
                  //
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //         Icon(
                  //           Icons.arrow_forward_ios_rounded,
                  //           color: blackback,
                  //           size: 18.sp,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // InkWell(
                  //   onTap: (){
                  //     Get.to(SubscriptionAlarmScreen());
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     padding:
                  //     EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: bgcolor,
                  //         border: Border.all(color: secondary, width:1.sp))
                  //     ,child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Container(
                  //             width: 10.w,
                  //             height: 10.w,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: blackback,
                  //             ),
                  //             child: Icon(
                  //               Icons.alarm,
                  //               color: bgcolor,
                  //               size: 18.sp,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 5.w,
                  //           ),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text("Add Alerts",
                  //                   style: TextStyle(
                  //                       letterSpacing: 1,
                  //                       color: secondary,
                  //                       fontSize: 15.sp,
                  //                       fontWeight: FontWeight.normal,
                  //                       fontFamily: "volken")),
                  //
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Icon(
                  //         Icons.arrow_forward_ios_rounded,
                  //         color: blackback,
                  //         size: 18.sp,
                  //       )
                  //     ],
                  //   ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // InkWell(
                  //   onTap: (){
                  //     Get.to(UpdateAlarmScreen());
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     padding:
                  //     EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: bgcolor,
                  //         border: Border.all(color: secondary, width:1.sp))
                  //     ,child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Container(
                  //             width: 10.w,
                  //             height: 10.w,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: blackback,
                  //             ),
                  //             child: Icon(
                  //               Icons.alarm,
                  //               color: bgcolor,
                  //               size: 18.sp,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 5.w,
                  //           ),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text("Alert",
                  //                   style: TextStyle(
                  //                       letterSpacing: 1,
                  //                       color: secondary,
                  //                       fontSize: 15.sp,
                  //                       fontWeight: FontWeight.normal,
                  //                       fontFamily: "volken")),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Icon(
                  //         Icons.arrow_forward_ios_rounded,
                  //         color: blackback,
                  //         size: 18.sp,
                  //       )
                  //     ],
                  //   ),
                  //   ),
                  // ),
                  // // SizedBox(
                  // //   height: 2.h,
                  // // ),
                  // // InkWell(
                  // // onTap: (){
                  // //   Get.to(FavouriteScreen());
                  // // },
                  // //   child: Container(
                  // //     alignment: Alignment.center,
                  // //     padding:
                  // //         EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  // //     width: MediaQuery.of(context).size.width,
                  // //     decoration: BoxDecoration(
                  // //         borderRadius: BorderRadius.circular(10),
                  // //         color: bgcolor,
                  // //         border: Border.all(color: secondary, width:1.sp))
                  // //     ,child: Row(
                  // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // //       children: [
                  // //         Row(
                  // //           children: [
                  // //             Container(
                  // //               width: 10.w,
                  // //               height: 10.w,
                  // //               decoration: BoxDecoration(
                  // //                 borderRadius: BorderRadius.circular(10),
                  // //                 color: blackback,
                  // //               ),
                  // //               child: Icon(
                  // //                 Icons.favorite,
                  // //                 color: Colors.white,
                  // //                 size: 18.sp,
                  // //               ),
                  // //             ),
                  // //             SizedBox(
                  // //               width: 5.w,
                  // //             ),
                  // //             Text("My Favourites",
                  // //                 style: TextStyle(
                  // //                     letterSpacing: 1,
                  // //                     color: secondary,
                  // //                     fontSize: 15.sp,
                  // //                     fontWeight: FontWeight.normal,
                  // //                     fontFamily: "volken")),
                  // //           ],
                  // //         ),
                  // //         Icon(
                  // //           Icons.arrow_forward_ios_rounded,
                  // //           color: blackback,
                  // //           size: 18.sp,
                  // //         )
                  // //       ],
                  // //     ),
                  // //   ),
                  // // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // InkWell(
                  //   onTap: (){
                  //     Get.to(MyMarinaListScreen());
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     padding:
                  //     EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: bgcolor,
                  //         border: Border.all(color: secondary, width:1.sp))
                  //     ,child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Container(
                  //               width: 10.w,
                  //               height: 10.w,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: blackback,
                  //               ),
                  //               child: Icon(
                  //                 Icons.directions_boat,
                  //                 color: bgcolor,
                  //                 size: 18.sp,
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 5.w,
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text("My Positions",
                  //                     style: TextStyle(
                  //                         letterSpacing: 1,
                  //                         color: secondary,
                  //                         fontSize: 15.sp,
                  //                         fontWeight: FontWeight.normal,
                  //                         fontFamily: "volken")),
                  //
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //         Icon(
                  //           Icons.arrow_forward_ios_rounded,
                  //           color: blackback,
                  //           size: 18.sp,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  InkWell(
                    onTap: (){
                      Get.to(ChangePasswordScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bgcolor,
                          border: Border.all(color: secondary, width:1.sp))
                      ,child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: blackback,
                              ),
                              child: Icon(
                                Icons.password,
                                color: bgcolor,
                                size: 18.sp,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text("ChangePassword",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: blackback,
                          size: 18.sp,
                        )
                      ],
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(PremiumScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bgcolor,
                          border: Border.all(color: secondary, width:1.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blackback,
                                ),
                                child: Icon(
                                  Icons.paid,
                                  color: bgcolor,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("Premium",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "volken")
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackback,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 2.h,),
                  // Row(mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("My Invoice : -",
                  //             style: TextStyle(
                  //                 letterSpacing: 1,
                  //                 color: secondary,
                  //                 fontSize: 15.sp,
                  //                 fontWeight: FontWeight.normal,
                  //                 fontFamily: "volken")),
                  //         SizedBox(height: 2.h,),
                  //         Container(
                  //         alignment: Alignment.center,
                  //
                  //
                  //           height: 12.h,
                  //           width: 95.w,
                  //
                  //           decoration: BoxDecoration(
                  //               border: Border.all(
                  //                   color: secondary,
                  //                   width: 1.sp
                  //               ),
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Colors.white),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Row(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 children: [
                  //                   Container(
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(900),
                  //                       ),
                  //                       height: 12.w,
                  //                       width: 13.w,
                  //                       // padding: EdgeInsets.all(1.w),
                  //                       child:
                  //                       Image.asset("assets/Upload .png")),
                  //                   SizedBox(
                  //                     width: 2.w,
                  //                   ),
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         "Invoice File.pdf",
                  //                         textAlign: TextAlign.start,
                  //                         style: TextStyle(
                  //                           fontFamily: 'pop',
                  //                           color: blackback,
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: 13.sp,
                  //                           letterSpacing: 1,
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 1.h),
                  //                       Text(
                  //                         "Safe Boat",
                  //                         textAlign: TextAlign.start,
                  //                         style: TextStyle(
                  //                           fontFamily: 'pop',
                  //                           color: Colors.black.withOpacity(0.8),
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: 13.sp,
                  //                           letterSpacing: 1,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //
                  //   ],
                  // )
                ],
              ),
            ),
            SizedBox(height: 15.h,),
          ],
        ),
      ),

    );
  } Viewprofile() {
    final Map<String, String> data = {};
    data['id'] = (loginmodal?.userId).toString();

    print("printData${data}");
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewprofileapi(data).then((response) async {
          viewprofilemodal = ViewProfileModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && viewprofilemodal?.success == true) {
            print("Successs123456");
            setState(() {
              isLoading=false;
            });
          } else {

            setState(() {
              isLoading=false;
            });
          }
        });
      } else {
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }

}
