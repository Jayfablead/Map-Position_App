import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Const.dart';

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
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                  onTap: () {},
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
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.home,
                                    size: 22.sp,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Home",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
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
                  onTap: () {},
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
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.category_rounded,
                                    size: 22.sp,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("Categories",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'volken',
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
                              ),
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
                  onTap: () {},
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
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.cart,
                                    size: 25.sp,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "My Cart",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'volken',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
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
                  onTap: () {},
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
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.production_quantity_limits,
                                    size: 25.sp,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "All Products",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'volken',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
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
                  onTap: () {},
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
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.login,
                                    size: 25.sp,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'volken',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
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
                  onTap: () {},
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
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 25.sp,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'volken',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
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
                  color: Boxbg),
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
                              color: primary,
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
                                  color: Colors.white70,
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey)),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontFamily: "volken",
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                        batan(
                            title: "Logout",
                            route: () {
                              // setState(() async {
                              //   await SaveDataLocal.clearUserData();
                              //   loginmodal =
                              //       await SaveDataLocal.getDataFromLocal();
                              //   Get.to(LoginPage());
                              //   databaseHelper.clearCartItems();
                              // });
                              // Navigator.of(context).pop();
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

  TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12.sp,
      fontFamily: 'volken',
      fontWeight: FontWeight.w600);
}
