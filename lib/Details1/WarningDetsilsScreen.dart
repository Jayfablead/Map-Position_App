import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapposition/Detail/OtherWarningDetailsScreen.dart';
import 'package:mapposition/Detail/ViewOtherDetailsScreeen.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/Headerwidget.dart';
import 'package:mapposition/HomeScreen/HomeScreen.dart';
import 'package:mapposition/Modal/AddNewPositionImageModal.dart';
import 'package:mapposition/Modal/DaywiseWedhterModal.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../LoginSinupScreen/LoginScreen.dart';
import '../Modal/AddFavouritePositionModal.dart';
import '../Modal/AddReviewModal.dart';
import '../Modal/AddViewOtherModal.dart';
import '../Modal/AddviewWarningModal.dart';
import '../Modal/OnwViewPostionModal.dart';
import '../Modal/ReportModal.dart';
import '../PrimiumPayments/positionController.dart';
import '../Provider/Authprovider.dart';


class WarningDetilsScreen extends StatefulWidget {
  String? postid;
  WarningDetilsScreen({super.key,this.postid});

  @override
  State<WarningDetilsScreen> createState() => _WarningDetilsScreenState();
}


class _WarningDetilsScreenState extends State<WarningDetilsScreen> {
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
  final PositionController positionController = Get.put(PositionController());
  TextEditingController _comments = TextEditingController();
  Set<Marker> _markers = {};
  List<MarkerData> _customMarkers = [];
  var latitudeString;
  var longitudeString;

  LatLng _center = LatLng(21.1702, 72.8311); // Default initial position
  CameraPosition _initialCameraPosition =
  CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 10);
  // Position? _currentPosition;
  int? select;
  late LatLng dynamicLatLng;

  late GoogleMapController mapController;
  late LatLng _currentPosition1 = LatLng(double.parse(addviewwarningmodal?.data?.latitude ?? ""),double.parse(addviewwarningmodal?.data?.longitude ?? ""));
  bool _isSatellite = false;
  GoogleMapController? _mapController;
  ImagePicker picker = ImagePicker();
  File? selectedimage = null;





  List<XFile>? resultList;
  List<XFile>? resultList1;
  List<File> selectedImages = [];
  List<String> imagePaths = [];
  List<XFile> imagesList = <XFile>[];
  String _error = 'No Error Dectected';
  List<String> imageNames = [];
  ImagePicker _picker = ImagePicker();
  int maxImageLimit = 9;

  int currentIndex = 0;

  List<String> _imagePaths = [];
  @override

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  MapType _mapType = MapType.normal;

  void _toggleMapType() {
    setState(() {
      _isSatellite = !_isSatellite;
    });
    setState(() {
      _mapType = _isSatellite ? MapType.satellite : MapType.normal;
    });
  }
  String? selectedvalue="--- Select ---";
  DateTime now = DateTime.now();
  DateTime? futureDate;
  double? lat1, lng1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("warning Screen call tha che ho ");
    isLoading =true;
    setState(() {
      isLoading =true;
      futureDate = now.add(Duration(days: 10));
    });  viewposition();

    print("Postidavigayache${widget.postid.toString()}");
  }
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyProductlistpage,
        drawer: drawer1(),
        backgroundColor: bgcolor,
        body:isLoading ? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 4.h,
              ),
              header(
                  text: "Details",
                  callback1: () {
                    _scaffoldKeyProductlistpage.currentState
                        ?.openDrawer();
                  }),
              Container(
                height: 30.h,
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeFactor: 0.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    height: 30.h,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: (addviewwarningmodal
                      ?.data?.thumbnails ??
                      [])
                      .map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: (imagePath).toString(),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Image.asset(""),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  children: [
                    Column(children: [
                      SizedBox(height: 0.5.h),
                      loginmodal?.userId == "" ||
                          loginmodal?.userId == null
                          ? batan(
                          title:
                          "Click to Add More Pictures From This Position",
                          route: () {
                            buildErrorDialog1(
                              context,
                              "",
                              "Please Login To Use This",
                              buttonname: 'Login',
                                  () {
                                Get.offAll(LoginScreen());
                              },
                            );
                          },
                          hight: 6.h,
                          width: MediaQuery.of(context).size.width,
                          txtsize: 8.sp)
                          : batan(
                          title:
                          "Click to Add More Pictures From This Position",
                          route: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                int counter = 0;
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.all(10), // Optional: Adjust padding if needed
                                      content: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 10.w,
                                                    width: 10.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.black,
                                                    ),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 15.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Add More Pictures',
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontFamily: "volken",
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            selectedimage == null
                                                ? Container()
                                                : Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                                                  height: 30.w,
                                                  width: 30.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    border: Border.all(
                                                      color: bgcolor,
                                                      width: 2.sp,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(15),
                                                    child: Image.file(
                                                      selectedimage!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            resultList1 == null
                                                ? Container()
                                                : Column(
                                              children: [
                                                selectedImages.isEmpty
                                                    ? Container()
                                                    : GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                  ),
                                                  itemCount: 9,
                                                  itemBuilder: (context, index) {
                                                    if (index < selectedImages.length &&
                                                        selectedImages[index] != null) {
                                                      return Container(
                                                        margin: EdgeInsets.all(3.w),
                                                        height: 70.h,
                                                        width: 70.w,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                          border: Border.all(color: Colors.grey),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(15),
                                                          child: Image.file(
                                                            selectedImages[index],
                                                            height: 60.h,
                                                            width: 70.w,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          resultList1 = await ImagePicker().pickMultiImage();
                                                          if (resultList1 != null) {
                                                            if (resultList1!.length + selectedImages.length > maxImageLimit) {
                                                              buildErrorDialog(context, "", "You selected more than 9 images");
                                                            } else {
                                                              setState(() {
                                                                selectedImages.addAll(resultList1!.map((XFile file) => File(file.path)).toList());
                                                                imagePaths = resultList1!.map((file) => file.path).toList();
                                                              });
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.all(3.w),
                                                          height: 60.h,
                                                          width: 70.w,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(15),
                                                            border: Border.all(color: Colors.grey),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2.h),
                                            batan(
                                              title: "Select Photo",
                                              route: () async {
                                                resultList1 = await ImagePicker().pickMultiImage();
                                                if (resultList1 != null) {
                                                  if (resultList1!.length + selectedImages.length > maxImageLimit) {
                                                    buildErrorDialog(context, "", "You selected more than 9 images");
                                                  } else {
                                                    setState(() {
                                                      selectedImages.addAll(resultList1!.map((XFile file) => File(file.path)).toList());
                                                      imagePaths = resultList1!.map((file) => file.path).toList();
                                                    });
                                                  }
                                                }
                                              },
                                              hight: 6.h,
                                              width: MediaQuery.of(context).size.width,
                                              txtsize: 15.sp,
                                            ),
                                            SizedBox(height: 2.h),
                                            selectedImages.isNotEmpty
                                                ? batan(
                                              title: "Upload",
                                              route: () {
                                                addnewimageapi();
                                              },
                                              hight: 6.h,
                                              width: MediaQuery.of(context).size.width,
                                              txtsize: 15.sp,
                                            )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );

                          },
                          hight: 6.h,
                          width: MediaQuery.of(context).size.width,
                          txtsize: 8.sp),
                      SizedBox(height: 1.h),


                      Row(
                        children: [
                          SizedBox(
                            width: 90.w,
                            child: Text(
                              addviewwarningmodal?.data?.title==""||addviewwarningmodal?.data?.title==null?"N/A":addviewwarningmodal?.data?.title ?? "",
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
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: Colors.black,size: 15.sp),
                          Text(
                            "${addviewwarningmodal?.data?.latitude==""||addviewwarningmodal?.data?.latitude==null?"N/A":addviewwarningmodal?.data?.latitude}, ${addviewwarningmodal?.data?.longitude==""||addviewwarningmodal?.data?.longitude==null?"N/A":addviewwarningmodal?.data?.longitude} ",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: secondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "volken"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Text(
                            " ⭐️${addviewwarningmodal?.averageRating=="0"||addviewwarningmodal?.averageRating==0||addviewwarningmodal?.averageRating==""||addviewwarningmodal?.averageRating==null?"4.5":addviewwarningmodal?.averageRating ?? ""}[${addviewwarningmodal?.reviews?.length=="0"||addviewwarningmodal?.reviews?.length==""||addviewwarningmodal?.reviews?.length==0||addviewwarningmodal?.reviews?.length==null?"0":addviewwarningmodal?.reviews?.length} reviews]",
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
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              report();
                            },
                            child: Icon(
                              Icons.flag_outlined,
                              color: Colors.black,
                              size: 23.sp,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          InkWell(
                            onTap: (){
                              report();
                            },
                            child: Text("Report",

                                style: TextStyle(
                                    letterSpacing: 1,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Text("Description",
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
                              '${addviewwarningmodal?.data?.content==""||addviewwarningmodal?.data?.content==null?"N/A":addviewwarningmodal?.data?.content ?? ""}',
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
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 95.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: secondary, width: 1.sp),
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Weather",
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: blackback,
                                              fontSize: 15.sp,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontFamily:
                                              "volken")),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height:
                                            20.w,
                                            width:
                                            20.w,

                                            child:
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(0),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: "https://www.navlex.net/wp-content/themes/wpstate-child/img/weather/wind.png",
                                                progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, url, error) => Image.asset(Default_Profile),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2.w,),
                                          Text(
                                            "Wind",
                                            maxLines:
                                            1,
                                            style:
                                            TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 13.sp,
                                              color: secondary,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "volken",
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
                                            child:
                                            Row(
                                              children: [
                                                Container(
                                                  height:
                                                  20.w,
                                                  width:
                                                  20.w,
                                                  child:
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(0),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: "https://www.navlex.net/wp-content/themes/wpstate-child/img/weather/swell.png",
                                                      progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => Image.asset("assets/Mud.jpg",),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 1.w,),
                                                Text(
                                                  "Swell",
                                                  maxLines:
                                                  1,
                                                  style:
                                                  TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 13.sp,
                                                    color: secondary,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "volken",
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height:
                                            20.w,
                                            width:
                                            20.w,

                                            child:
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(0),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: "https://www.navlex.net/wp-content/themes/wpstate-child/img/weather/wind-speed.png",
                                                progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, url, error) => Image.asset(Default_Profile),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2.w,),
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: 25.w,
                                                child: Text(
                                                  "Speed :${daywisewedhtermodal?.days?[0].hours?[0].windspeed==""||daywisewedhtermodal?.days?[0].hours?[0].windspeed==null?"N/A":(daywisewedhtermodal?.days?[0].hours?[0].windspeed).toString()}",
                                                  style:
                                                  TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 13.sp,
                                                    color: secondary,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "volken",

                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "SE(${daywisewedhtermodal?.days?[0].winddir==""||daywisewedhtermodal?.days?[0].winddir==null?"N/A":daywisewedhtermodal?.days?[0].winddir})",
                                                style: TextStyle(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  fontSize: 13.sp,
                                                  color: secondary,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "volken",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
                                            child:
                                            Row(
                                              children: [
                                                Container(
                                                  height:
                                                  20.w,
                                                  width:
                                                  20.w,

                                                  child:
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(0),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: "https://www.navlex.net/wp-content/themes/wpstate-child/img/weather/height.png",
                                                      progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => Image.asset("assets/Mud.jpg",),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Text(
                                                  "Height",
                                                  maxLines:
                                                  1,
                                                  style:
                                                  TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 13.sp,
                                                    color: secondary,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "volken",
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height:
                                            20.w,
                                            width:
                                            20.w,

                                            child:
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(0),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:"https://img.myloview.com/posters/cloud-sun-icon-simple-color-with-outline-vector-elements-of-forecast-icons-for-ui-and-ux-website-or-mobile-application-700-219337463.jpg",
                                                progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, url, error) => Image.asset(Default_Profile),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2.w,),
                                          SizedBox(
                                            width: 25.w,
                                            child: Text(
                                              daywisewedhtermodal?.days?[0].hours?[0].conditions==""||daywisewedhtermodal?.days?[0].hours?[0].conditions==null?"N/A":(daywisewedhtermodal?.days?[0].hours?[0].conditions).toString(),
                                              style:
                                              TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
                                            child:
                                            Row(
                                              children: [
                                                Container(
                                                  height:
                                                  20.w,
                                                  width:
                                                  20.w,

                                                  child:
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(0),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: "https://www.navlex.net/wp-content/themes/wpstate-child/img/weather/wave-line.png",
                                                      progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => Image.asset("assets/Mud.jpg",),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Text(
                                                  "    --",
                                                  maxLines:
                                                  1,
                                                  style:
                                                  TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 13.sp,
                                                    color: secondary,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "volken",
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height:
                                            20.w,
                                            width:
                                            20.w,

                                            child:
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(0),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: "https://www.navlex.net/wp-content/themes/wpstate-child/img/weather/temp.png",
                                                progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, url, error) => Image.asset(Default_Profile),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2.w,),
                                          SizedBox(
                                            width: 25.w,
                                            child: Text(
                                              "${daywisewedhtermodal?.days?[0].temp==""||daywisewedhtermodal?.days?[0].temp==null?"N/A":(daywisewedhtermodal?.days?[0].temp).toString()}°C",
                                              style:
                                              TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13.sp,
                                                color: secondary,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "volken",

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),

                                ],
                              )),
                        ],
                      ),

                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 25.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black12,
                                width: 1.sp)
                        ),
                        child: CustomGoogleMapMarkerBuilder(
                          //screenshotDelay: const Duration(seconds: 4),
                          customMarkers: _customMarkers,
                          builder:
                              (BuildContext context, Set<Marker>? markers) {
                            if (markers == null) {
                              print("online");
                              return GoogleMap(
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _currentPosition1,
                                  // You can set your initial position here
                                  zoom: 12.0,
                                ),
                                mapType: _mapType,
                                markers: _markers,
                                myLocationButtonEnabled: false,
                                myLocationEnabled: true,
                                zoomControlsEnabled: true,
                                compassEnabled: true,
                                scrollGesturesEnabled: true,
                              );
                            }
                            return GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _currentPosition1,
                                // You can set your initial position here
                                zoom: 12.0,
                              ),
                              gestureRecognizers: Set()
                                ..add(Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                )),
                              scrollGesturesEnabled: true,
                              mapToolbarEnabled: true,
                              mapType: _mapType,
                              markers: markers,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              compassEnabled: true,
                            );
                          },
                        ),

                      ),
                      SizedBox(
                        height: 2.h,
                      ),


                      Row(
                        children: [
                          Text("Nearby Similar Positions",
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
                      addviewwarningmodal
                          ?.nearbyPosts?.length==""||addviewwarningmodal
                          ?.nearbyPosts?.length==0||addviewwarningmodal
                          ?.nearbyPosts?.length==null?Container(height: 20.h,alignment: Alignment.center,child: Text("No Nearby Similar Positions Available", style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight:
                          FontWeight.w500,
                          fontFamily:
                          "volken",
                          letterSpacing: 1), ),)
                          :Container(
                        height: 28.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: addviewwarningmodal?.nearbyPosts?.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
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
                                          imageUrl: addviewwarningmodal?.nearbyPosts?[index].thumbnail ?? "" ,
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
                                      // loginmodal?.userId==""||loginmodal?.userId==null?Container():Positioned(
                                      //   top: 0.2.h,
                                      //   left: 34.w,
                                      //   child: InkWell(
                                      //     onTap: (){
                                      //       print("datavalye${addviewwarningmodal?.nearbyPosts?[index].isFavorite}");
                                      //       addfevorite( (addviewwarningmodal?.nearbyPosts?[index].isFavorite)!,(addviewwarningmodal
                                      //           ?.nearbyPosts?[
                                      //       index]
                                      //           .id
                                      //       )
                                      //           ?.toString() ??
                                      //           "");
                                      //       print("abc");
                                      //     },
                                      //     child: Container(
                                      //       height: 9.w,
                                      //       width: 9.w,
                                      //       alignment: Alignment.center,
                                      //       padding: EdgeInsetsDirectional.all(2.2.w),
                                      //       decoration: BoxDecoration(
                                      //         color: blackback,
                                      //         borderRadius: BorderRadius.circular(900),
                                      //       ),
                                      //       child: addviewwarningmodal?.nearbyPosts?[index].isFavorite==true?Icon(
                                      //         CupertinoIcons.heart_fill,
                                      //         color: Colors.white,
                                      //         size: 15.sp,
                                      //       ) :Icon(
                                      //         Icons.favorite_border,
                                      //         color: Colors.white,
                                      //         size: 15.sp,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 25.w,
                                        child: Text(
                                          addviewwarningmodal?.nearbyPosts?[index].title==""|| addviewwarningmodal?.nearbyPosts?[index].title==null?"N/A":(addviewwarningmodal?.nearbyPosts?[index].title).toString(),
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


                                      Get.to(
                                            DetailsWarningDetailsScreen(
                                              postid: (addviewwarningmodal
                                                  ?.nearbyPosts?[
                                              index]
                                                  .id)
                                                  ?.toString() ??
                                                  "",
                                            ));

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text("Review",
                          //     style: TextStyle(
                          //         letterSpacing: 1,
                          //         color: blackback,
                          //         fontSize: 15.sp,
                          //         fontWeight: FontWeight.bold,
                          //         fontFamily: "volken")),
                          loginmodal?.userId==""||loginmodal?.userId==null?buildErrorDialog1(
                            context,
                            "",
                            "Please Login To Use This",
                            buttonname: 'Login',
                                () {
                              Get.offAll(LoginScreen());
                            },
                          ):
                          // loginmodal?.userId == addviewwarningmodal?.data?.authorId ?Container():
                          InkWell(
                            onTap: () {

                              showratingpop1();
                            },
                            child: Text("Write a Review/Add more info",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: blackback,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ),
                        ],
                      ),
                      addviewwarningmodal?.reviews?.length == null ||
                          addviewwarningmodal?.reviews?.length == '' ||
                          addviewwarningmodal?.reviews?.length == 0
                          ?  Container(height: 20.h,alignment: Alignment.center,child: Text("No Review Available", style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight:
                          FontWeight.w500,
                          fontFamily:
                          "volken",
                          letterSpacing: 1), ),)
                          : Column(
                        children: [
                          for (int i = 0; i < (addviewwarningmodal?.reviews?.length ?? 0); i++) ...[
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
                                                  addviewwarningmodal?.reviews?[i].userImg ?? "",
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
                                                      addviewwarningmodal?.reviews?[i].name==""||addviewwarningmodal?.reviews?[i].name==null?"N/A":(addviewwarningmodal?.reviews?[i].name).toString(),
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
                                                    addviewwarningmodal?.reviews?[i].reviewerRating==""||addviewwarningmodal?.reviews?[i].reviewerRating==null?"0":(addviewwarningmodal?.reviews?[i].reviewerRating).toString(),
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
                                                  addviewwarningmodal?.reviews?[i].reviewSummary?.xsReviwSummery==""||addviewwarningmodal?.reviews?[i].reviewSummary?.xsReviwSummery==null?"N/A":(addviewwarningmodal?.reviews?[i].reviewSummary?.xsReviwSummery).toString(),
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
                        ],
                      )
                    ]),
                  ],
                ),
              ),

            ])));
  }


  viewposition() {
    final Map<String, String> data = {};
    data['post_id'] =widget.postid.toString();
    data['user_id'] = (loginmodal?.userId).toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewsinganalpositionviewapi(data).then((response) async {
          addviewwarningmodal =
              AddviewWarningModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && addviewwarningmodal?.success == true) {
            wedther();
            print("warningapicall");
            for (int index = 0;
            index < (shoallmarkermodal?.positions?.length ?? 0);
            index++) {
              print("markerlength${shoallmarkermodal?.positions?.length}");
              var latitudeString = addviewwarningmodal?.data?.latitude;
              var longitudeString = addviewwarningmodal?.data?.longitude;

              if (latitudeString != null && longitudeString != null) {
                // Validate latitude and longitude strings
                if (_isValidDouble(latitudeString) &&
                    _isValidDouble(longitudeString)) {
                  try {
                    double latitude = double.parse(latitudeString);
                    double longitude = double.parse(longitudeString);
                    String imageurl=(shoallmarkermodal
                        ?.positions?[index].properties?.imgURL)
                        .toString();
                    _customMarkers.add(
                      MarkerData(
                        marker: Marker(
                          onTap: () {
                            print(
                                "positiname${shoallmarkermodal?.positions?[index].properties?.title.toString()}");
                            setState(() {
                              select = index;
                            });

                          },
                          markerId: MarkerId(
                              'id-${shoallmarkermodal?.positions?[index].properties?.title.toString()}'),
                          position: LatLng(latitude, longitude),
                        ),
                        child: Image.asset(
                          "assets/otheryellow.png",
                          height: 20.w,
                          width: 20.w,
                          color: Colors.blue,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );

                    // Set _currentPosition1 to the first marker position
                    if (index == 0) {
                      _currentPosition1 = LatLng(latitude, longitude);
                    }
                  } catch (e) {
                    print("Error parsing coordinates: $e");
                  }
                } else {
                  print("Invalid latitude or longitude format");
                }
              } else {
                print("Latitude or longitude is null");
              }
            }
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




  bool _isValidDouble(String value) {
    if (value == null) return false;
    final RegExp regex = RegExp(r'^-?[\d.]+$');
    return regex.hasMatch(value);
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
                                    "Your Rating",
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
            print('warning call');
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

  wedther() {
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().wedtherapi(addviewwarningmodal?.data?.latitude,addviewwarningmodal?.data?.longitude,'${now.year}-${now.month}-${now.day}','${futureDate!.year}-${futureDate!.month}-${futureDate!.day}').then((response) async {
          daywisewedhtermodal = DaywiseWeatherModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 ) {
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


  report() {
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
                                        color: Colors.black),
                                    child: InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
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
                                    "Report Position",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Volkan"),
                                  ),
                                  SizedBox(height: 1.h),

                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text("Category",style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken")),
                              SizedBox(height: 1.h,),
                              Container(
                                height: 5.5.h,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  border: Border.all(width: 1, color: secondary),
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child:DropdownButton(
                                  dropdownColor: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  hint: Text("Please Select Position Category",style: TextStyle(color:secondary,fontFamily: "volken",)),

                                  value: selectedvalue,
                                  onChanged: (val)
                                  {
                                    setState((){
                                      selectedvalue=val!;
                                      print(selectedvalue);
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("--- Select ---",style: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "--- Select ---",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("sexual content",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "sexual-content",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("violent or repulsive content",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "violent-or-repulsive-content",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("hateful or abusive content",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "hateful-or-abusive-content",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("harassment or bullying",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "harassment-or-bullying",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("harmful or dangerous acts",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "harmful-or-dangerous-acts",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Misinformation",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "misinformation",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Child Abuse",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "child-abuse",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Promotes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "promotes",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Spam or Misleading",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "spam-or-misleading",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Legal issue",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "legal-issue",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Captions issue",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "captions-issue",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Other",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,  fontFamily: "volken",)),
                                      value: "other",
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Your Name",
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

                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black),
                                      controller: _name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Your Name ";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(
                                        hintText: "Enter Your Your Name",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Message",
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
                                      controller: _email,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Message ";
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(
                                        hintText: "Enter Your Message",
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
                                  title: "REPORT",
                                  route: () {
                                    reportapifun();
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


  reportapifun() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final Map<String, String> data = {};
      data['post_id'] = widget.postid.toString();
      data['opinion_text'] = selectedvalue.toString();
      data['name'] =_name.text.toString();
      data['message'] = _email.text.toString();
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().reportapi(data).then((response) async {
            reportmodal =
                ReportModal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && reportmodal?.success == true) {
              EasyLoading.showSuccess(reportmodal?.message ?? '');
              Get.back();
              setState(() {});
            } else {
              EasyLoading.showError(reportmodal?.message ?? '');
              setState(() {});
            }
          });
        } else {
          EasyLoading.showError(reportmodal?.message ?? '');
          setState(() {});
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }

  addnewimageapi() async {
    print(selectedimage?.path);
    EasyLoading.show(status: 'Please Wait ...');
    final Map<String, String> data = {};
    data['post_id'] = widget.postid.toString();
    data['upload_file[]'] = jsonEncode(imagePaths);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider()
            .addnewimageviedewtailimage(data, imagePaths)
            .then((response) async {
          addNewPositionimageModal =
              AddNewPositionImageModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              addNewPositionimageModal?.success == true) {
            print("admin chalu karo bhai");
            EasyLoading.showSuccess(addNewPositionimageModal?.message ?? "");
            viewposition();
            Get.back();
            selectedImages = [];
          } else {
            EasyLoading.showError(addNewPositionimageModal?.message ?? "");
            setState(() {});
          }
        });
      } else {
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }


}