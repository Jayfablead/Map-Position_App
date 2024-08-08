import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
import '../Extras/Loader.dart';
import '../Extras/buildErrorDialog.dart';
import '../Modal/DeleteAlaramModal.dart';
import '../Modal/UserAlaramModal.dart';
import '../Provider/Authprovider.dart';
import 'UpdatealramScreen2.dart';
class UpdateAlarmScreen extends StatefulWidget {
  const UpdateAlarmScreen({super.key});
  @override
  State<UpdateAlarmScreen> createState() => _UpdateAlarmScreenState();
}
class _UpdateAlarmScreenState extends State<UpdateAlarmScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage1 =
      GlobalKey<ScaffoldState>();
  double? lat1, lng1;
  TextEditingController _position = TextEditingController();
  TextEditingController _title = TextEditingController();
  Set<Marker> _markers = {};
  LatLng _center = LatLng(21.1702, 72.8311); // Default initial position
  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 10);
  Position? _currentPosition;
  int? select;
  late LatLng dynamicLatLng;
  late GoogleMapController mapController;
  late LatLng _currentPosition1 = LatLng(21.1702, 72.8311);
  bool _isSatellite = false;
  GoogleMapController? _mapController;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // searchController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('Tapped Location'),
        position: latLng,
      ));
    });
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;
    LatLng location = LatLng(lat, long);
    setState(() {
      _currentPosition1 = location;
      lat1 = lat;
      lng1 = long;
    });
  }

  String? selectedvalue = "All Categories";
  String? selectedvalue1 = "Active";
  MapType _mapType = MapType.satellite;
  bool isLoading =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ViewAlaram();
    getLocation().then((_) {
      setState((){
        _markers.add(Marker(
          markerId: MarkerId('Current Location'),
          // icon: await BitmapDescriptor.fromAssetImage(
          //   ImageConfiguration(
          //       devicePixelRatio: 2.5, size: Size(1000.sp, 1000.sp)),
          //   'assets/morning.png',
          // ),
          position: _currentPosition1,
        ));
      });
    });
    print("livelocation:-${_currentPosition1}");
  }

  Widget build(BuildContext context) {
    return commanScreen(
      isLoading: isLoading,
      scaffold: Scaffold(
        backgroundColor: bgcolor,
        key: _scaffoldKeyProductlistpage1,
        drawer: drawer1(),
        body: isLoading?Container():SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                header(
                    text: "My Alarm",
                    callback1: () {
                      _scaffoldKeyProductlistpage1.currentState?.openDrawer();
                    }),
                SizedBox(
                  height: 2.h,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text("Location",
                //         style: TextStyle(
                //             letterSpacing: 1,
                //             color: Colors.black,
                //             fontSize: 17.sp,
                //             fontWeight: FontWeight.normal,
                //             fontFamily: "volken")),
                //   ],
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 40.h,
                //   child: GoogleMap(
                //     onMapCreated: _onMapCreated,
                //     initialCameraPosition: CameraPosition(
                //       target: _currentPosition1,
                //       // You can set your initial position here
                //       zoom: 12.0,
                //     ),
                //     mapType: _isSatellite ? MapType.satellite : MapType.normal,
                //     markers: _markers,
                //     myLocationButtonEnabled: false,
                //     myLocationEnabled: true,
                //     zoomControlsEnabled: true,
                //     compassEnabled: true,
                //   ),
                // ),
                // SizedBox(
                //   height: 2.h,
                // ),
                useralarammodal?.alarms?.length==null||useralarammodal?.alarms?.length==0?Center(
                  child: Container(height: 80.h,alignment: Alignment.center,child: Text("No Alarm Available", style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight:
                      FontWeight.w500,
                      fontFamily:
                      "volken",
                      letterSpacing: 1), ),),
                ):
Column(
  children: [
    for (int index = 0;
    index < (useralarammodal?.alarms?.length ?? 0);
    index++)...[
        Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: secondary)),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Title:-",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: blackback,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                    Text(useralarammodal?.alarms?[index].location==""||useralarammodal?.alarms?[index].location==null?"N/A":(useralarammodal?.alarms?[index].location).toString(),
                        style: TextStyle(
                            letterSpacing: 1,
                            color: secondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(UpdatealramScreenTwo(id: (useralarammodal?.alarms?[index].id).toString(),));
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 25.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: secondary,
              thickness: 0.1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Status :- ",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: blackback,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                    useralarammodal?.alarms?[index].status=="1"?Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.shade100
                      ),
                      child: Text("Active",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.green,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                    ):Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.shade100
                      ),
                      child: Text("InActive",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.red,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "volken")),
                    )
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        deletealarama(useralarammodal?.alarms?[index].id ?? "");
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red.shade200,
                        size: 25.sp,
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
              children: [
                Text("Category :- ",
                    style: TextStyle(
                        letterSpacing: 1,
                        color: blackback,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: "volken")),
                Text(useralarammodal?.alarms?[index].name==""||useralarammodal?.alarms?[index].name==null?"N/A":useralarammodal?.alarms?[index].name ?? "",
                    textAlign: TextAlign.center,
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
    ]


  ],
),


              ],
            ),
          ),
        ),
      ),
    );
  }
  ViewAlaram() {
    final Map<String, String> data = {};
    data['user_id'] = (loginmodal?.userId).toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().useralaramapi(data).then((response) async {
          useralarammodal =
              UserAlaramModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 ) {
            print("anchioirapicall");
            setState(() {
              isLoading = false;

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
  deletealarama(id) {
    EasyLoading.show(status: 'Please Wait ...');
    final Map<String, String> data = {};
    data['id'] =id.toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().deletealarmapi(data).then((response) async {
          deletealarammodal =
              DeleteAlaramModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 ) {
            EasyLoading.showSuccess(deletealarammodal?.message ?? '');
            ViewAlaram();
            print("anchioirapicall");
            setState(() {
              isLoading = false;

            });
            setState(() {
              isLoading = false;

            });
          } else {
            EasyLoading.showError(deletealarammodal?.message ?? '');
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

}
