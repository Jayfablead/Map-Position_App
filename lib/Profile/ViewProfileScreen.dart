import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/ViewProfileModal.dart';
import '../Provider/Authprovider.dart';
import 'EditProfileScreen.dart';

class ViewPRofileScreen extends StatefulWidget {
  const ViewPRofileScreen({super.key});

  @override
  State<ViewPRofileScreen> createState() => _ViewPRofileScreenState();
}

class _ViewPRofileScreenState extends State<ViewPRofileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
  GlobalKey<ScaffoldState>();

  ImagePicker picker = ImagePicker();
  File? selectedimage = null;
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool secure = false;
  bool visible = true;
  bool visible1 = true;

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstname.clear();
    _lastname.clear();
    _email.clear();
    _phone.clear();
    Viewprofile();
  }


  Widget build(BuildContext context) {
    return  commanScreen(
        isLoading: isLoading,
        scaffold:Scaffold(
      backgroundColor: bgcolor,
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body:  isLoading
    ? Container()
        :SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,

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
                          child:CachedNetworkImage(
                            imageUrl:
                            viewprofilemodal?.userDetails?.profileImage ?? "",
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.asset(Default_Profile,
                                    fit: BoxFit.cover),
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
                              color:secondary,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(viewprofilemodal?.userDetails?.userEmail==""||viewprofilemodal?.userDetails?.userEmail==null?"N/A":viewprofilemodal?.userDetails?.userEmail ?? "",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: secondary,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("Username : ",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken")),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
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
                            Icon(
                              Icons.person,
                              color: secondary,
                              size: 18.sp,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(viewprofilemodal?.userDetails?.userLogin==""||viewprofilemodal?.userDetails?.userLogin==null?"N/A":viewprofilemodal?.userDetails?.userLogin ?? "",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Text("Last Name : ",
                  //     style: TextStyle(
                  //         letterSpacing: 1,
                  //         color: blackback,
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.normal,
                  //         fontFamily: "volken")),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   padding:
                  //   EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: bgcolor,
                  //       border: Border.all(color: secondary, width:1.sp)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.person,
                  //             color: secondary,
                  //             size: 18.sp,
                  //           ),
                  //           SizedBox(
                  //             width: 5.w,
                  //           ),
                  //           Text(viewprofilemodal?.userDetails?.userMeta?.lastName ==""||viewprofilemodal?.userDetails?.userMeta?.lastName ==null?"N/A":viewprofilemodal?.userDetails?.userMeta?.lastName ?? "",
                  //               style: TextStyle(
                  //                   letterSpacing: 1,
                  //                   color: secondary,
                  //                   fontSize: 15.sp,
                  //                   fontWeight: FontWeight.normal,
                  //                   fontFamily: "volken")),
                  //         ],
                  //       ),
                  //
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // Text("Phone : ",
                  //     style: TextStyle(
                  //         letterSpacing: 1,
                  //         color: blackback,
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.normal,
                  //         fontFamily: "volken")),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   padding:
                  //   EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: bgcolor,
                  //       border: Border.all(color: secondary, width:1.sp)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.phone,
                  //             color: secondary,
                  //             size: 18.sp,
                  //           ),
                  //           SizedBox(
                  //             width: 5.w,
                  //           ),
                  //           Text(viewprofilemodal?.userDetails?.userMeta?.phone ==""||viewprofilemodal?.userDetails?.userMeta?.phone ==null?"N/A":viewprofilemodal?.userDetails?.userMeta?.phone ?? "",
                  //               style: TextStyle(
                  //                   letterSpacing: 1,
                  //                   color: secondary,
                  //                   fontSize: 15.sp,
                  //                   fontWeight: FontWeight.normal,
                  //                   fontFamily: "volken")),
                  //         ],
                  //       ),
                  //
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),

                  Text("Describe your Boat : ",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "volken")),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
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
                            Icon(
                              Icons.directions_boat,
                              color: secondary,
                              size: 18.sp,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(viewprofilemodal?.userDetails?.userMeta?.userboat==""||viewprofilemodal?.userDetails?.userMeta?.userboat==null?"N/A":viewprofilemodal?.userDetails?.userMeta?.userboat ?? "",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "volken")),
                          ],
                        ),

                      ],
                    ),
                  ),


                  SizedBox(
                    height: 3.5.h,
                  ),
                  // Password

                  batan(title: "Edit Profile", route: (){
                    Get.to(EditProfileScreen());
                  },hight: 6.h,
                      width: MediaQuery.of(context).size.width,
                      txtsize: 18.sp),
                  SizedBox(
                    height: 3.5.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
  Viewprofile() {
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
