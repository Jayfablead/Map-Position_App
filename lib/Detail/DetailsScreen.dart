import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../Extras/Drwer.dart';

class DetailsScreen extends StatefulWidget {
  String? postid;
  DetailsScreen({super.key,this.postid});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

final List<String> titles = [
  "Surat",
  "Up",
  "Gujarat",
  "Karon",
  "Mp",
];
List imgs = [
  "https://assets-global.website-files.com/5e83362767d71ffd59a0c8a9/6377b0249bab82a13967e18f_hero%20image%20-%20Mapbox%20Satellite%20Streets.png",
  "https://taxiboatvarenna.com/wp-content/uploads/2023/11/TaxiBoatVarenna-Boat-sailing-on-lake-Como-2.webp",
  "https://d2ugbn5gb88fyp.cloudfront.net/1289393/0_0.png",
  "https://d2ugbn5gb88fyp.cloudfront.net/1289393/0_0.png",
  "https://d2ugbn5gb88fyp.cloudfront.net/1289393/0_0.png",
];

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyProductlistpage =
      GlobalKey<ScaffoldState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _review = TextEditingController();
  int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyProductlistpage,
        drawer: drawer1(),
        backgroundColor: bgcolor,
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50.h,
                    width: MediaQuery.of(context).size.width,
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
                            'https://img.trvcdn.net/https://s3.ap-southeast-2.amazonaws.com/thebalibible.com/uploads/images/venue/e4f4c2a46d054197dbce6540d8bc5a4d.jpg?v=1?imgeng=m_box/w_1418/h_946',
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Image.asset(Default_Profile, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 5.h,
                left: 4.w,
                right: 3.w,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 9.w,
                            width: 9.w,
                            alignment: Alignment.center,
                            padding: EdgeInsetsDirectional.all(2.2.w),
                            decoration: BoxDecoration(
                              color: blackback,
                              borderRadius: BorderRadius.circular(900),
                            ),
                            child: Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.white,
                              size: 15.sp,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _scaffoldKeyProductlistpage.currentState
                                    ?.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu_rounded,
                                color: blackback,
                                size: 23.sp,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    "Tony Stark's Dream Mansion",
                    style: TextStyle(
                        letterSpacing: 1,
                        color: blackback,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
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
                    " ⭐️ 4.8 [320 reviews]",
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
                  Icon(
                    Icons.add_location,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                  Text(
                    "Sleman,Yogyakarta",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        height: 15.w,
                        width: 15.w,
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
                                'https://i.pinimg.com/originals/51/e0/d5/51e0d5aa27808ce689e3dd5a5cd7685a.png',
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset(Default_Profile, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rabert Downerny",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "volken")),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text("Boat Owner",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: secondary,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "volken")),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 12.w,
                        width: 12.w,
                        alignment: Alignment.center,
                        padding: EdgeInsetsDirectional.all(2.2.w),
                        decoration: BoxDecoration(
                          color: blackback,
                          borderRadius: BorderRadius.circular(900),
                        ),
                        child: Icon(
                          Icons.sms,
                          color: Colors.white,
                          size: 15.sp,
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
                  Text("Facilities Nearby :-",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "volken")),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.sp, color: secondary),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 15.w,
                              width: 15.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtRIWAWJ82MIU3sZz_G753lnqYMkP6MBq6ly1FUtoCaAW9tsUl',
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
                            SizedBox(
                              width: 3.w,
                            ),
                            Text("Groceries",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 15.w,
                              width: 15.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuoa863jQHob2mOU5heotg6KO4Af4JcqDcgwfZ4yzPt_DvntQA',
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
                            SizedBox(
                              width: 3.w,
                            ),
                            Text("Pharmacy",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 15.w,
                              width: 15.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ-Ny6we7GlTTn8xMrp9v4RAh6iUVUGDfKoJfeMX-Gddc6YYK3',
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
                            SizedBox(
                              width: 3.w,
                            ),
                            Text("Alcohol",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 15.w,
                              width: 15.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4UP0P6tKJ1DQG4Q6DI5TferlLPkz9xiKMp0UGWvfXIxeJweQm',
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
                            SizedBox(
                              width: 3.w,
                            ),
                            Text("Restaurant",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: secondary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "volken")),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text("Description :-",
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
                      'Motorboats are powered by internal combustion engines, usually gasoline or diesel. The engine size can vary from a few horsepower for smaller boats used in lakes and rivers, to several hundred horsepower for larger vessels used in oceans and for water sports.',
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
                height: 2.h,
              ),
              Row(
                children: [
                  Text("Details :-",
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Characteristics",
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
                          Row(
                            children: [
                              SizedBox(
                                width: 87.w,
                                child: Text(
                                    "Here are the mooring conditions you'll find in the anchorage Anse de l'Aiguade",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: secondary,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "volken")),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20.w,
                                width: 20.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.w, vertical: 1.h),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://www.svgheart.com/wp-content/uploads/2021/11/anchor-monogram-frame-sailing-ship-free-svg-file-SvgHeart.Com.png',
                                    color: Colors.blue,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(Default_Profile,
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text("Anchor Allowed",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "volken")),
                            ],
                          )
                        ],
                      )),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Seabed types :-",
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
                          Row(
                            children: [
                              SizedBox(
                                width: 87.w,
                                child: Text(
                                    "You'll find the following types of seabed at Anse de l'Aiguade",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: secondary,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "volken")),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 20.w,
                                    width: 20.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVM_V8qDAZB0zcdTh_ab6TVb4_7xMvEXtSNYO7m7PGX2kdPNo5',
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
                                  Text("Sand",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: secondary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "volken")),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    height: 20.w,
                                    width: 20.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSe0dP7c4doZOnbn5eWQCdiv1hn2cg4visMGff3p7T46c5_HEB0',
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(Default_Profile,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Text("Sand",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: secondary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "volken")),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 20.w,
                                    width: 20.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVM_V8qDAZB0zcdTh_ab6TVb4_7xMvEXtSNYO7m7PGX2kdPNo5',
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
                                  Text("Sand",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: secondary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "volken")),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    height: 20.w,
                                    width: 20.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSe0dP7c4doZOnbn5eWQCdiv1hn2cg4visMGff3p7T46c5_HEB0',
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(Default_Profile,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Text("Sand",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: secondary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "volken")),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 20.w,
                                    width: 20.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVM_V8qDAZB0zcdTh_ab6TVb4_7xMvEXtSNYO7m7PGX2kdPNo5',
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
                                  Text("Sand",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: secondary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "volken")),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    height: 20.w,
                                    width: 20.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSe0dP7c4doZOnbn5eWQCdiv1hn2cg4visMGff3p7T46c5_HEB0',
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(Default_Profile,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Text("Sand",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: secondary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "volken")),
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Text("Nearby Listings :-",
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
              Container(
                height: 30.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: imgs.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
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
                                  imageUrl: imgs[index].toString(),
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
                              Positioned(
                                top: 0.2.h,
                                left: 34.w,
                                child: Container(
                                  height: 9.w,
                                  width: 9.w,
                                  alignment: Alignment.center,
                                  padding: EdgeInsetsDirectional.all(2.2.w),
                                  decoration: BoxDecoration(
                                    color: blackback,
                                    borderRadius: BorderRadius.circular(900),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.white,
                                    size: 15.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                titles[index],
                                style: TextStyle(
                                  fontFamily: "Volkan",
                                  letterSpacing: 1.2,
                                  color: secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          batan(
                              title: "View Details",
                              route: () {},
                              hight: 5.h,
                              width: 30.w,
                              txtsize: 10.sp)
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Review",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: blackback,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "volken")),
                  InkWell(
                    onTap: () {
                      showratingpop();
                    },
                    child: Text("Add Review",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: blackback,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "volken")),
                  ),
                ],
              ),
              for (int i = 0; i < 5; i++) ...[
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
                                          "https://images.unsplash.com/photo-1579034628318-b14c8ab399a9?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGJlYXJkfGVufDB8fDB8fHww",
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
                                          "Mr. Ryan Reynolds",
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
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14.sp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14.sp,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  SizedBox(
                                    width: 65.w,
                                    child: Text(
                                      "Best Boat Driver",
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
            ]),
          )
        ])));
  }

  showratingpop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // backgroundColor: Colors.transparent,
            child: Form(
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
                                    borderRadius: BorderRadius.circular(100),
                                    color: blackback),
                                child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 17.sp,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Rating :-",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
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
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Review  : ",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Volkan")),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                width: 85.w,
                                child: TextFormField(
                                  maxLines: 4,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: secondary),
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
                              Text("Name: ",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "")),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                width: 85.w,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: secondary),
                                  controller: _name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Your Name";
                                    }
                                    return null;
                                  },
                                  decoration: inputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text("Email: ",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Volkan")),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                width: 85.w,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: secondary),
                                  controller: _email,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Your Email";
                                    } else {
                                      bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value);
                                      if (!emailValid) {}
                                    }
                                    return null;
                                  },
                                  decoration: inputDecoration(
                                    hintText: "Enter Your Email",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          batan(
                              title: "Add Review",
                              route: () {},
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
  }
}
