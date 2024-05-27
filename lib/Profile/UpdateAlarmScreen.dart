import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../Extras/Const.dart';
import '../Extras/Drwer.dart';
import '../Extras/Headerwidget.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation().then((_) {
      setState(() async {
        _markers.add(Marker(
          markerId: MarkerId('Current Location'),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
                devicePixelRatio: 2.5, size: Size(1000.sp, 1000.sp)),
            'assets/morning.png',
          ),
          position: _currentPosition1,
        ));
      });
    });
    print("livelocation:-${_currentPosition1}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      key: _scaffoldKeyProductlistpage1,
      drawer: drawer1(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                header(
                    text: "Update Alarm",
                    callback1: () {
                      _scaffoldKeyProductlistpage1.currentState?.openDrawer();
                    }),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Location",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "volken")),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40.h,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition1,
                      // You can set your initial position here
                      zoom: 12.0,
                    ),
                    mapType: _isSatellite ? MapType.satellite : MapType.normal,
                    markers: _markers,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    compassEnabled: true,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                              Text("Alarm",
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
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 25.sp,
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green.shade100),
                                child: Text("Active",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.green,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "volken")),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red.shade200,
                                size: 25.sp,
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
                          Text("Anchorage",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: secondary,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "volken")),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                              Text("Alarm1",
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
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 25.sp,
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green.shade100),
                                child: Text("Active",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.green,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "volken")),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red.shade200,
                                size: 25.sp,
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
                          Text("Marinas",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: secondary,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "volken")),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                              Text("Alarm1",
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
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 25.sp,
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
                              Container(
                               padding: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red.shade100),
                                child: Text("InActive",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.red,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "volken")),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red.shade200,
                                size: 25.sp,
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
                          Text("Other",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: secondary,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "volken")),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                              Text("Mumbai",
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
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 25.sp,
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green.shade100),
                                child: Text("Active",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.green,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "volken")),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red.shade200,
                                size: 25.sp,
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
                          Text("All",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: secondary,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "volken")),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
