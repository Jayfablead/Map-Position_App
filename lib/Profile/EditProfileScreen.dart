import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstname.clear();
    _lastname.clear();
    _email.clear();
    _phone.clear();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.h,
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
                          child: selectedimage != null
                              ? Image.file(selectedimage!,fit: BoxFit.cover,)
                              : CachedNetworkImage(
                                  imageUrl:
                                      'https://i.pinimg.com/originals/51/e0/d5/51e0d5aa27808ce689e3dd5a5cd7685a.png',
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                          CircularProgressIndicator(),
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
                      Text("Henry Matavic",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: secondary,
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
                      Text("Henry@gmail.com",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: secondary,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      batan(
                          title: "Upload Photo",
                          route: () async {
                            final XFile? photo = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              selectedimage = File(photo!.path);
                              print(selectedimage);
                            });
                          },
                          hight: 5.h,
                          width: 35.w,
                          txtsize: 12.sp)
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
                  Text("First Name : ",
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
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      controller: _firstname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter First Name";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your First Name",
                          icon: Icon(
                            Icons.person,
                            color: secondary,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("Last Name : ",
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
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      controller: _lastname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Last Name";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your Last Name",
                          icon: Icon(
                            Icons.person,
                            color: secondary,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  Text("Phone : ",
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
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      controller: _phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Phone";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hintText: "Enter Your Phone",
                          icon: Icon(
                            Icons.phone_android,
                            color: secondary,
                          )),
                    ),
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  // Password

                  batan(title: "Save", route: (){},hight: 6.h,
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
    );
  }
}
