// import 'dart:convert';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:chet/Modal/Experincemodal.dart';
// import 'package:chet/Modal/IdeaListModal.dart';
// import 'package:chet/Modal/MapExplorationModal.dart';
// import 'package:chet/Modal/collectionModal.dart';
// import 'package:chet/provider/ideaprovider.dart';
// import 'package:chet/screens/10.dart';
// import 'package:chet/screens/4.dart';
// import 'package:chet/widgets/botamnavbar.dart';
// import 'package:chet/widgets/buildErrorDialog.dart';
// import 'package:chet/widgets/const.dart';
// import 'package:chet/widgets/load.dart';
// import 'package:custom_map_markers/custom_map_markers.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class Eight extends StatefulWidget {
//   const Eight({Key? key}) : super(key: key);
//
//   @override
//   State<Eight> createState() => _EightState();
// }
//
// class _EightState extends State<Eight> {
//   final List<LatLng> locations = [
//     // LatLng(21.1959, 72.7933),
//     // LatLng(21.1901, 72.8139),
//     // LatLng(21.2266, 72.8312),
//     // LatLng(21.2510, 72.7954),
//     // LatLng(21.2021, 72.8673),
//   ];
//   List<String> img = [
//     // "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
//     // "https://cdn.statusqueen.com/dpimages/thumbnail/dp_images_8-1279.jpg",
//     // "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     // "https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     // "https://as1.ftcdn.net/v2/jpg/04/15/47/46/1000_F_415474633_0Q1hAKF0U1Xiots9CXgzpttuIlJVHGS7.jpg",
//   ];
//   // static final CameraPosition _kGoogle = const CameraPosition(
//   //   target: LatLng( dynamicLatLng,), //location to show in map
//   //   zoom: 14,
//   // );
//
//   // late List<MarkerData> _customMarkers;
//   List<MarkerData> _customMarkers = [];
//   Position? _currentPosition;
//   int? select;
//   late LatLng dynamicLatLng;
//   late GoogleMapController mapController;
//   late LatLng _currentPosition1;
//
//
//   @override
//   bool isLoading = true;
//
//   getLocation() async {
//
//     LocationPermission permission;
//     permission = await Geolocator.requestPermission();
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     double lat = position.latitude;
//     double long = position.longitude;
//     LatLng location = LatLng(lat, long);
//     setState(() {
//       _currentPosition1 = location;
//       isLoading=false;
//
//
//     }); await mapexpo();
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//   castommarker()async{
//     await mapexpo();
//   }
//   int? sel = 0;
//   int? COLLSEL = 0;
//   void initState() {
//     super.initState();
//     getLocation();
//     // castommarker();
//     mapexpo();
//     print("map");
//     print(locations);
//     // _customMarkers = [
//     //   for(int index =1;index < locations.length ;index ++)...[
//     //
//     //     MarkerData(
//     //         marker: Marker(
//     //             onTap: () {
//     //               print("jdkc");
//     //               alert();
//     //             },
//     //             markerId: const MarkerId('id-1'),
//     //             position: locations[index]),
//     //         child: _customMarker(img[index], Colors.blue))
//     //   ]
//     //   // MarkerData(
//     //   //     marker: Marker(
//     //   //         onTap: () {
//     //   //           print("jdkc");
//     //   //           alert();
//     //   //         },
//     //   //         markerId: const MarkerId('id-2'),
//     //   //         position: locations[0]),
//     //   //     child: _customMarker(img[0], Colors.red)),
//     //   // MarkerData(
//     //   //     marker: Marker(
//     //   //         onTap: () {
//     //   //           print("jdkc");
//     //   //           alert();
//     //   //         },
//     //   //         markerId: const MarkerId('id-2'),
//     //   //         position: locations[1]),
//     //   //     child: _customMarker(img[1], Colors.red)),
//     //   // MarkerData(
//     //   //     marker: Marker(
//     //   //         onTap: () {
//     //   //           print("jdkc");
//     //   //           alert();
//     //   //         },
//     //   //         markerId: const MarkerId('id-2'),
//     //   //         position: locations[1]),
//     //   //     child: _customMarker(img[1], Colors.red)),
//     //   // MarkerData(
//     //   //     marker: Marker(
//     //   //         onTap: () {
//     //   //           print("jdkc");
//     //   //           alert();
//     //   //         },
//     //   //         markerId: const MarkerId('id-3'),
//     //   //         position: locations[2]),
//     //   //     child: _customMarker(img[2], Colors.green)),
//     //   // MarkerData(
//     //   //     marker: Marker(
//     //   //         onTap: () {
//     //   //           print("jdkc");
//     //   //           alert();
//     //   //         },
//     //   //         markerId: const MarkerId('id-4'),
//     //   //         position: locations[3]),
//     //   //     child: _customMarker(img[3], Colors.purple)),
//     //   // MarkerData(
//     //   //     marker: Marker(
//     //   //         onTap: () {
//     //   //           print("jdkc");
//     //   //           alert();
//     //   //         },
//     //   //         markerId: const MarkerId('id-5'),
//     //   //         position: locations[4]),
//     //   //     child: _customMarker(img[4], Colors.blue)),
//     // ];
//   }
//
//
//   marker() {}
//
//   @override
//   Widget build(BuildContext context) {
//     return commanScreen(
//         isLoading:isLoading,
//         scaffold: Scaffold(
//           bottomNavigationBar: Bottomnavbar(sel: 1),
//           extendBodyBehindAppBar: true,
//           body: isLoading ? Container():Stack(
//             children: [
//               // mapexplorationmodal?.data?.length == 0
//               //     ? Container(
//               //     height: MediaQuery.of(context).size.height,
//               //     width: MediaQuery.of(context).size.width,
//               //     child: Text("No Event in Near 20 km area"))
//               //     :
//
//               CustomGoogleMapMarkerBuilder(
//                 //screenshotDelay: const Duration(seconds: 4),
//                 customMarkers: _customMarkers,
//                 builder: (BuildContext context, Set<Marker>? markers) {
//                   if (markers == null) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   return GoogleMap(
//                     onMapCreated: _onMapCreated,
//                     initialCameraPosition: CameraPosition(
//                       target: _currentPosition1,
//                       zoom: 12.0,
//
//                     ),gestureRecognizers: Set()
//                     ..add(Factory<OneSequenceGestureRecognizer>(
//                           () => EagerGestureRecognizer(),
//                     )),
//                     scrollGesturesEnabled: true,
//
//                     // initialCameraPosition: _currentPosition != null
//                     //     ? CameraPosition(
//                     //   target: LatLng(
//                     //     _currentPosition!.latitude,
//                     //     _currentPosition!.longitude,
//                     //   ),
//                     //   zoom: 12.0,
//                     // )
//                     //     : CameraPosition(
//                     //   target: LatLng(0, 0),
//                     //   zoom: 1.0,
//                     // ),
//                     // onMapCreated: (GoogleMapController controller) {
//                     //   setState(() {
//                     //     mapController = controller;
//                     //   });
//                     // },
//                     mapToolbarEnabled: true,
//                     mapType: MapType.normal,
//                     markers: markers,
//                     myLocationButtonEnabled: false,
//                     myLocationEnabled: true,
//                     zoomControlsEnabled: false,
//
//                     compassEnabled: true,
//                   );
//                 },
//               ),
//               Positioned(
//                   top: 590.h,
//                   left: 300.w,
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           mapController.animateCamera(
//                             CameraUpdate.newCameraPosition(CameraPosition(target: _currentPosition1,zoom:12 )),
//                           );
//                         },
//                         child: Container(
//                             alignment: Alignment.center,
//                             height: 50.h,
//                             width: 50.h,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle, color: Colors.blueAccent),
//                             child: Icon(
//                               Icons.my_location,
//                               color: Colors.white,
//                             )),
//                       ),
//
//                     ],
//                   ))
//             ],
//           ),
//         )
//     );
//   }
//
//   _customMarker(String symbol, Color color) {
//     return Stack(
//       children: [
//         Container(
//           height: 50,
//           width: 50,
//           decoration:
//           BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
//         ),
//         Positioned(
//           left: 5,
//           top: 22,
//           child: Icon(
//             Icons.location_on,
//             color: Colors.grey.shade900,
//             size: 30,
//           ),
//         ),
//         Positioned(
//           left: 0,
//           top: 0,
//           child: (symbol == "")
//               ? CircleAvatar(
//               radius: 20, backgroundImage: AssetImage('assets/user.png'))
//               :CircleAvatar(
//             radius: 20,
//             child:  ClipRRect(borderRadius: BorderRadius.circular(500),
//               child: CachedNetworkImage(
//                 imageUrl:
//                 symbol,
//                 imageBuilder: (context, imageProvider) => Container(
//                   decoration: BoxDecoration(
//
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 placeholder: (context, url) =>
//                     CircularProgressIndicator(),
//                 errorWidget: (context, url, error) =>
//                     Icon(Icons.error),
//               ),
//             ),
//           ),
//           // CircleAvatar(
//           //         radius: 20,
//           //         backgroundImage: CachedNetworkImage(
//           //           imageUrl:    symbol,
//           //
//           //
//           //           placeholder: (context, url) =>
//           //               CircularProgressIndicator(),
//           //           errorWidget: (context, url, error) =>
//           //               Icon(Icons.error),
//           //         ),
//           //         // NetworkImage(symbol),
//           //       )
//         )
//       ],
//     );
//   }
//
//   alert() {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: EdgeInsets.all(15),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           backgroundColor: Colors.black.withOpacity(0.4),
//           child: GestureDetector(
//             onTap: () {
//               // Get.to(Tenth(
//               //   id: mapexplorationmodal?.data?[select!].ideaId,
//               // ));
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.4),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 3.h,
//                   ),
//                   InkWell(onTap: (){
//                     Get.to(Tenth(
//                       id: mapexplorationmodal?.data?[select!].ideaId,
//                     ));
//                   },
//                     child: Text(
//                       mapexplorationmodal?.data?[select!].eventTitle == "" ||
//                           mapexplorationmodal?.data?[select!].eventTitle ==
//                               null
//                           ? "N/A"
//                           : (mapexplorationmodal?.data?[select!].eventTitle)
//                           .toString(),
//                       style: TextStyle(
//                         fontFamily: "simsan",
//                         color: Colors.white,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Text(
//                     "已体验：" +
//                         (mapexplorationmodal?.data?[select!].noOfExperienced)
//                             .toString() +
//                         "| 已收藏：" +
//                         (mapexplorationmodal?.data?[select!].noOfCollected)
//                             .toString(),
//                     style: TextStyle(
//                       fontFamily: "simsan",
//                       color: Colors.white,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                               height: 30.0,
//                               width: 30.0,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white,
//                               ),
//                               child: Icon(
//                                 Icons.currency_yen,
//                                 color: Colors.black,
//                               )),
//                           SizedBox(
//                             width: 3.h,
//                           ),
//                           Text(
//                             mapexplorationmodal?.data?[select!].eventFees ==
//                                 null ||
//                                 mapexplorationmodal
//                                     ?.data?[select!].eventFees ==
//                                     ""
//                                 ? "N/A"
//                                 : (mapexplorationmodal
//                                 ?.data?[select!].eventFees)
//                                 .toString(),
//                             style: TextStyle(
//                               fontFamily: "simsan",
//                               color: Colors.white,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Row(
//                       //   crossAxisAlignment: CrossAxisAlignment.start,
//                       //   children: [
//                       //     InkWell(
//                       //       onTap: (){
//                       //         Navigator.of(context).pop();
//                       //         print("1111111111111111111111111111111");
//                       //         alert1();
//                       //       },
//                       //       child:Icon(
//                       //         Icons.check_circle_outline,
//                       //         color: Colors.grey,
//                       //       )
//                       //     ),
//                       //     SizedBox(
//                       //       width: 3.h,
//                       //     ),
//                       //     Text(
//                       //       "已休验",
//                       //       style: TextStyle(
//                       //         fontFamily: "simsan",
//                       //         color: Color(0xffbA8A8A8),
//                       //         fontSize: 14.sp,
//                       //         fontWeight: FontWeight.normal,
//                       //       ),
//                       //     ),
//                       //     SizedBox(
//                       //       width: 10.h,
//                       //     ),
//                       //     InkWell(
//                       //       onTap: (){
//                       //         Navigator.of(context).pop();
//                       //         print("22222222222222222222222222222222");
//                       //         alert2();
//                       //       },
//                       //       child:Icon(
//                       //         Icons.favorite,
//                       //         color: Colors.red.shade900,
//                       //       ),
//                       //     ),
//                       //     SizedBox(
//                       //       width: 3.h,
//                       //     ),
//                       //     Text(
//                       //       "收藏",
//                       //       style: TextStyle(
//                       //         fontFamily: "simsan",
//                       //         color: Color(0xffbA8A8A8),
//                       //         fontSize: 14.sp,
//                       //         fontWeight: FontWeight.normal,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//
//                               setState(
//                                       () {
//
//                                     sel =
//                                         select;
//                                   });
//                               Navigator.of(context).pop();
//                               // print("1111111111111");
//                               // alert1();
//                             },
//                             child: (mapexplorationmodal?.data?[select!].buttonExperience.toString() ==
//                                 "1")
//                                 ? GestureDetector(
//                               onTap:
//                                   () {
//                                 mapexplorationmodal?.data?[select!].ideaId.toString();
//                               },
//                               child:
//                               Icon(
//                                 Icons.check_circle_rounded,
//                                 color: Color(0xffbEBEAEA),
//
//                               ),
//                             )
//                                 : GestureDetector(
//                               onTap:
//                                   () {
//                                 experincebuttonap(mapexplorationmodal?.data?[select!].ideaId.toString());
//                               },
//                               child:
//                               Icon(
//                                 Icons.check_circle_outline,
//                                 color: Color(0xffb777777),
//
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5.w,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(
//                                       () {
//                                     sel =
//                                         select;
//                                   });
//                               experincebuttonap(mapexplorationmodal?.data?[select!].ideaId.toString());
//                             },
//                             child: Text(
//                               "已体验",
//                               style:
//                               TextStyle(
//                                 color: Color(
//                                     0xffbA8A8A8),
//                                 fontSize: 14.sp,
//
//                                 fontFamily:
//                                 "simsan",
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5.w,
//                           ),
//                           GestureDetector(
//                               onTap:
//                                   () async{
//                                 setState(
//                                         () {
//                                       COLLSEL =
//                                           select;
//                                     });
//                                 // Navigator.of(context).pop();
//                                 // print("222222222");
//                                 // alert2();
//                               },
//                               child: mapexplorationmodal?.data?[select!].buttonCollected ==
//                                   "1"
//                                   ? GestureDetector(
//                                 onTap: () {
//                                   collectedbuttonap(mapexplorationmodal?.data?[select!].ideaId);
//                                 },
//                                 child: Icon(
//                                   Icons.favorite,
//                                   color: Color(0xffbD05454),
//
//                                 ),
//                               )
//                                   : GestureDetector(
//                                 onTap: () {
//                                   collectedbuttonap(mapexplorationmodal?.data?[select!].ideaId);
//                                 },
//                                 child: Icon(
//                                   Icons.favorite_border,
//                                   color: Color(0xffb777777),
//
//                                 ),
//                               )),
//                           SizedBox(
//                             width: 5.w,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(
//                                       () {
//                                     COLLSEL =
//                                         select;
//                                   });
//                               collectedbuttonap(mapexplorationmodal?.data?[select!].ideaId);
//                             },
//                             child: Text(
//                               "收藏",
//                               style:
//                               TextStyle(
//                                 color: Color(
//                                     0xffbA8A8A8),
//                                 fontSize: 14.sp,
//
//                                 fontFamily:
//                                 "simsan",
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         // height: 30.0,
//                         // width: 30.0,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.watch_later,
//                             color: Colors.white,
//                           )),
//                       SizedBox(
//                         width: 3.h,
//                       ),
//                       Text(
//                         "开始时间",
//                         style: TextStyle(
//                           fontFamily: "simsan",
//                           color: Colors.white,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Text(
//                     mapexplorationmodal?.data?[select!].eventStartDate ==
//                         null ||
//                         mapexplorationmodal
//                             ?.data?[select!].eventStartDate ==
//                             ""
//                         ? "N/A"
//                         : (mapexplorationmodal?.data?[select!].eventStartDate)
//                         .toString() +
//                         (mapexplorationmodal?.data?[select!].eventStartTime)
//                             .toString(),
//                     style: TextStyle(
//                       fontFamily: "simsan",
//                       color: Colors.white,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                           height: 30.0,
//                           width: 30.0,
//                           child: Icon(
//                             Icons.watch_later_outlined,
//                             color: Colors.white,
//                           )),
//                       Text(
//                         "体验时长",
//                         style: TextStyle(
//                           fontFamily: "simsan",
//                           color: Colors.white,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Text(
//                     "15分钟",
//                     style: TextStyle(
//                       fontFamily: "simsan",
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                           height: 30.0,
//                           width: 30.0,
//                           child: Icon(
//                             Icons.location_on,
//                             color: Colors.white,
//                           )),
//                       Text(
//                         "体验地点",
//                         style: TextStyle(
//                           fontFamily: "simsan",
//                           color: Colors.white,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   // Text(
//                   //   "中国 陕西西安 桃园南路21号公园天下小",
//                   //   style: TextStyle(
//                   //     fontFamily: "simsan",
//                   //       color: Colors.white,
//                   //       fontSize: 14.sp,
//                   //       fontWeight: FontWeight.bold,
//                   //       ),
//                   // ),
//                   Text(
//                     mapexplorationmodal?.data?[select!].address == null ||
//                         mapexplorationmodal?.data?[select!].address == ""
//                         ? "N/A"
//                         : (mapexplorationmodal?.data?[select!].address)
//                         .toString() +
//                         " | " +
//                         (mapexplorationmodal?.data?[select!]
//                             .distanceToCurrentPlace ==
//                             null ||
//                             mapexplorationmodal?.data?[select!]
//                                 .distanceToCurrentPlace ==
//                                 ""
//                             ? "N/A"
//                             : (mapexplorationmodal?.data?[select!].distanceToCurrentPlace)
//                             .toString()),
//                     style: TextStyle(
//                       fontFamily: "simsan",
//                       color: Colors.white,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//   mapexpo() async {
//     print("hiii");
//
//     bool serviceEnabled = await determinePosition();
//     if (serviceEnabled) {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best)
//           .timeout(const Duration(seconds: 5));
//       setState(() {
//         _currentPosition = position;
//       });
//     } else {
//       buildErrorDialog(context, "", "请启用您的手机位置");
//     }
//     final Map<String, String> data = {};
//     data['user_id'] = userdata?.userData?.id ?? "";
//     data['latitude'] = (_currentPosition?.latitude).toString();
//     data['longitude'] = (_currentPosition?.longitude).toString();
//     print(data);
//     checkInternet().then((internet) async {
//       if (internet) {
//         ideaprovider().mapexpolorapi(data).then((response) async {
//           mapexplorationmodal =
//               MapExplorationModal.fromJson(json.decode(response.body));
//           print(mapexplorationmodal?.status);
//           if (response.statusCode == 200 &&
//               mapexplorationmodal?.status == "success") {
//             for (int index = 0;
//             index < (mapexplorationmodal?.data?.length ?? 0);
//             index++) {
//               print('print image :${mapexplorationmodal?.data?[index].profilePicture}');
//               setState(() {
//                 _customMarkers.add(
//                   MarkerData(
//                     marker: Marker(
//                       onTap: () {
//                         print("jdkc");
//                         setState(() {
//                           select = index;
//                         });
//
//                         alert();
//                         print('print image :${mapexplorationmodal?.data?[index].profilePicture}');
//                       },
//                       markerId:
//                       MarkerId('id-$index'), // Use a unique identifier
//                       position: LatLng(
//                           double.parse(
//                               (mapexplorationmodal?.data?[index].eventLatitude)
//                                   .toString()),
//                           double.parse(
//                               (mapexplorationmodal?.data?[index].eventLongitude)
//                                   .toString())), // Use the correct position
//                     ),
//                     child: _customMarker(
//                         (mapexplorationmodal?.data?[index].profilePicture)
//                             .toString(),
//                         Colors.red), // Use the correct image and color
//                   ),
//                 );
//               });
//             }
//
//             setState(() {
//               locations;
//               img;
//
//               print("jiii");
//               print(locations);
//               print(img);
//               // isLoading = false;
//             });
//           }
//         });
//       } else {
//         setState(() {
//           // isLoading = false;
//         });
//         buildErrorDialog(context, '错误', "需要内部人员");
//       }
//     });
//   }
//   experincebuttonap(String? value) {
//     final Map<String, String> data = {};
//     data['user_id'] = userdata?.userData?.id ?? '';
//     data['idea_id'] = value.toString();
//     print(data);
//
//     checkInternet().then((internet) async {
//       if (internet) {
//         ideaprovider().experincebuttonapi(data).then((response) async {
//           experincemodal = ExperinceModal.fromJson(json.decode(response.body));
//
//           if (response.statusCode == 200 &&
//               experincemodal?.status == "success") {
//             Get.to(Four());
//             mapexpo();
//             idealistap();
//             idealistmodal?.data?[sel!].buttonExperience == "0"
//                 ?   buildErrorDialog(context, "经验", "你已经体验过这个想法")
//                 : buildErrorDialog(context, "经验", "你已经消除了这个想法");
//
//             // Get.off(Four());
//             setState(() {
//               isLoading = false;
//             });
//           } else {
//             setState(() {
//               isLoading = false;
//             });
//           }
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         buildErrorDialog(context, '错误', "需要互联网");
//       }
//     });
//   }
//   idealistap() async {
//     double? latitude;
//     double? longitude;
//     final List<Placemark> placemarks;
//     String? city;
//     bool serviceEnabled = await determinePosition();
//     if (serviceEnabled) {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best)
//           .timeout(const Duration(seconds: 5));
//       setState(() {
//         _currentPosition = position;
//         latitude = _currentPosition?.latitude;
//         longitude = _currentPosition?.longitude;
//       });
//       placemarks = await placemarkFromCoordinates(
//         latitude!,
//         longitude!,
//       );
//       city = placemarks.first.locality;
//     } else {
//       buildErrorDialog(context, "", "请启用您的手机位置");
//     }
//
//     print(_currentPosition);
//     final Map<String, String> data = {};
//     data['user_id'] = userdata?.userData?.id ?? '';
//     data['latitude'] = latitude.toString();
//     data['longitude'] = longitude.toString();
//     data['city'] = city.toString();
//     print(data);
//     checkInternet().then((internet) async {
//       if (internet) {
//         ideaprovider().idealistapi(data).then((response) async {
//           idealistmodal = IdeaListModal.fromJson(json.decode(response.body));
//           print("erjghnerj");
//           print(idealistmodal?.status);
//           print(idealistmodal?.isLogin);
//           if (response.statusCode == 200 &&
//               idealistmodal?.status == "success") {
//             mapexpo();
//             // idealistmodal?.isLogin == "0" ? Profilepop(context) : "";
//             setState(() {
//               isLoading = false;
//             });
//           } else {
//             setState(() {
//               isLoading = false;
//             });
//           }
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         buildErrorDialog(context, '错误', "需要互联网");
//       }
//     });
//   }
//
//   collectedbuttonap(String? value) {
//     final Map<String, String> data = {};
//     data['user_id'] = userdata?.userData?.id ?? '';
//     data['idea_id'] = value.toString();
//
//     checkInternet().then((internet) async {
//       if (internet) {
//         ideaprovider().collectionbuttonapi(data).then((response) async {
//           collectionmodal =
//               CollectionModal.fromJson(json.decode(response.body));
//
//           if (response.statusCode == 200 &&
//               collectionmodal?.status == "success") {
//             Get.to(Four());
//             mapexpo();
//             idealistmodal?.data?[COLLSEL!].buttonCollected == "0"
//                 ? buildErrorDialog(context, "收藏", "这个想法已添加到您的收藏中")
//                 : buildErrorDialog(context, "收藏", "此创意已从您的收藏中删除");
//             mapexpo();
//             idealistap();
//             setState(() {
//               isLoading = false;
//             });
//           } else {
//             setState(() {
//               isLoading = false;
//             });
//           }
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         buildErrorDialog(context, '错误', "需要互联网");
//       }
//     });
//   }
//
//
//
// }