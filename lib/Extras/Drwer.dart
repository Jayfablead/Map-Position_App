import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mapposition/AllPosition/AllPositionScreen.dart';
import 'package:mapposition/Extras/sharedpreferance.dart';
import 'package:mapposition/Favourite/FavouriteScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Invoice/MyInvoiceScreen.dart';
import '../Invoice/ViewInvoiceScreen.dart';
import '../LoginSinupScreen/ChangePasswordScreen.dart';
import '../LoginSinupScreen/LoginScreen.dart';
import '../LoginSinupScreen/SinupScreen.dart';
import '../Marina/AddMarinaScreen.dart';
import '../Marina/MyMarinaListScreen.dart';
import '../Modal/ViewProfileModal.dart';
import '../PrimiumPayments/PremiumScreen.dart';
import '../Profile/ProfileScreen.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Provider/Authprovider.dart';
import 'Const.dart';
import 'buildErrorDialog.dart';

class drawer1 extends StatefulWidget {
  const drawer1({Key? key}) : super(key: key);

  @override
  State<drawer1> createState() => _drawer1State();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool isloading = true;

class _drawer1State extends State<drawer1> {
  @override
  bool isLoading = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    Viewprofile();
  }

  Widget build(BuildContext context) {
    bool isPhone = MediaQuery.of(context).size.shortestSide < 600;
    double widthDrawer =
        isPhone ? MediaQuery.of(context).size.width * 0.75 : 150.w;

    return Drawer(
      width: widthDrawer,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: widthDrawer,
        color: bgcolor,
        child: loginmodal?.userId==""||loginmodal?.userId==null?  ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              SizedBox(height:5. h),
                InkWell(
                  onTap: () {
                    Get.offAll(HomeScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      CupertinoIcons.home,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Home",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(LoginScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      Icons.login,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Login",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(SinupScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      Icons.account_box,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Sign Up",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),

                InkWell(
                  onTap: () {
                    Get.offAll(AllPositionScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      Icons.add_location,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("All Marina",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ), SizedBox(
                  height: 2.h,
                ),






              ],
            ),
          ],
        ):isLoading? Container(alignment: Alignment.center,child: Center(child: CircularProgressIndicator(),),):
        ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
                      height: 30.w,
                      width: 30.w,
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
                          viewprofilemodal?.userDetails?.profileImage ?? "",
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, progress) =>
                              Container(alignment: Alignment.center,child: Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) =>
                              Image.asset(Default_Profile,
                                  fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(viewprofilemodal?.userDetails?.userLogin==""||viewprofilemodal?.userDetails?.userLogin==null?"N/A":viewprofilemodal?.userDetails?.userLogin ?? "",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "volken")),

                      ],
                    )
                  ],
                ),
               Divider(color: Colors.grey,thickness: 0.8.sp),
                InkWell(
                  onTap: () {
                    Get.offAll(HomeScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      CupertinoIcons.home,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Home",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(ProfileScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      CupertinoIcons.person,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Profile",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(FavouriteScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      CupertinoIcons.heart,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Favourite",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ), SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(AllPositionScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      Icons.add_location,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("All Marina",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ), SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(AddMarinaScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: blackback,
                                    ),
                                    child: Icon(
                                      Icons.directions_boat,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Add New Marina",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
Get.offAll(ChangePasswordScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    width: 2.w,
                                  ),
                                  Text("Change Password",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(MyMarinaListScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: blackback,
                                    ),
                                    child: Icon(
                                      Icons.directions_boat,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("My Marina",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),

                InkWell(
                  onTap: () {
                    Get.offAll(PremiumScreen());
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    child:  Icon(
                                      Icons.paid,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Premium",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    showbootomsheetremove();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          width: 64.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      Icons.login,
                                      color: bgcolor,
                                      size: 18.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Logout",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color:secondary,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color:blackback,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showbootomsheetremove() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.white),
              height: 15.h,
              width: double.infinity,
              // Customize the bottom sheet content here
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Are You Sure wan't Logout!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontFamily: 'volken'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 5.h,
                              width: 35.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:blackback,
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey)),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                    fontFamily: "volken",
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                        batan(
                            title: "Logout",
                            route: () async{
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              await preferences.clear();
                              setState(() async {
                                await SaveDataLocal.clearUserData();
                                loginmodal =
                                    await SaveDataLocal.getDataFromLocal();
                                Get.to(LoginScreen());

                              });
                              Navigator.of(context).pop();
                            },
                            hight: 5.h,
                            width: 35.w,
                            txtsize: 13.sp)
                      ],
                    ),
                    // Add more options as needed
                  ],
                ),
              ),
            ),
            Positioned(
              right: 1.w,
              child: IconButton(
                  icon: Icon(
                    Icons.highlight_remove,
                    size: 25.sp,
                    color: Colors.grey,
                  ),
                  // Icon to open the menu
                  onPressed: () {
                    Navigator.of(context).pop();
                  } // We set onPressed to null to disable the button
                  ),
            ),
          ],
        );
      },
    );
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
        Get.snackbar(
          'No Internet Connection',
          'Please connect to the internet',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });
  }

  TextStyle textStyle = TextStyle(
      color:blackback,
      fontSize: 12.sp,
      fontFamily: 'volken',
      fontWeight: FontWeight.w600);

}
