import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/UpdateProfileModal.dart';
import '../Modal/ViewProfileModal.dart';
import '../Provider/Authprovider.dart';
import 'ViewProfileScreen.dart';

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
  TextEditingController _yourBoat = TextEditingController();
  TextEditingController _length = TextEditingController();
  TextEditingController _type = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  bool secure = false;
  bool visible = true;
  bool visible1 = true;
  bool isLoading = true;

  List<XFile>? resultList;
  List<XFile>? resultList1;
  List<File> selectedImages = [];
  List<String> imagePaths = [];
  List<XFile> imagesList = <XFile>[];
  String _error = 'No Error Dectected';
  List<String> imageNames = [];
  ImagePicker _picker = ImagePicker();
  int maxImageLimit = 9;
  List<String> networkImageUrls = [];

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
    return commanScreen(
        isLoading: isLoading,
        scaffold:Scaffold(
      backgroundColor: bgcolor,
      key: _scaffoldKeyProductlistpage,
      drawer: drawer1(),
      body: Form(
        key: _formKey,
        child: isLoading ? Container():SingleChildScrollView(
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
                                    viewprofilemodal?.userDetails?.profileImage ?? "",
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
                        Text(viewprofilemodal?.userDetails?.userLogin==""||viewprofilemodal?.userDetails?.userLogin==null?"N/A":viewprofilemodal?.userDetails?.userLogin ?? "",
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
                        Text(viewprofilemodal?.userDetails?.userEmail==""||viewprofilemodal?.userDetails?.userEmail==null?"N/A":viewprofilemodal?.userDetails?.userEmail ?? "",
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
                        style: TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black
                        ),
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
                    Text("Your Bot : ",
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
                        style: TextStyle(color: Colors.black
                        ),
                        controller: _yourBoat,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Bot";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                            hintText: "Enter Your Your Bot",
                            icon: Icon(
                              Icons.directions_boat,
                              color: secondary,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("Length : ",
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
                        style: TextStyle(color: Colors.black
                        ),
                        controller: _length,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Length";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                            hintText: "Enter Your Your Length",
                            icon: Icon(
                              Icons.format_size,
                              color: secondary,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("Type : ",
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
                        style: TextStyle(color: Colors.black
                        ),
                        controller: _type,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Type";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                            hintText: "Enter Your Your Type",
                            icon: Icon(
                              Icons.type_specimen,
                              color: secondary,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // Password

                    batan(title: "Save", route: (){
                      EditProfileapp();
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
      ),
        ));
  }

  EditProfileapp() async {
    print(selectedimage?.path);
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['user_id'] = (loginmodal?.userId).toString();
      data['first_name'] = _firstname.text.trim().toString();
      data['last_name'] = _lastname.text.trim().toString();
      data['phone'] = _phone.text.trim().toString();
      data['skype'] ="";
      data['profile_img'] =(selectedimage?.path).toString();
      print("Printapivalue${data}");
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().editprofile1(data).then((response) async {
            updateprofilemodal =
                UpdateProfileModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && updateprofilemodal?.success==true) {
              EasyLoading.showSuccess(updateprofilemodal?.message ?? "");
              Get.to(ViewPRofileScreen());
              setState(() {
                isLoading=false;
              });
            } else {
              EasyLoading.showError(updateprofilemodal?.message ?? "");
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
            _firstname.text=(viewprofilemodal?.userDetails?.userMeta?.firstName).toString();
            _lastname.text=(viewprofilemodal?.userDetails?.userMeta?.lastName).toString();
            _phone.text=(viewprofilemodal?.userDetails?.userMeta?.phone).toString();
            _yourBoat.text="My Boat";
            _length.text="14";
            _type.text="Abc";
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
