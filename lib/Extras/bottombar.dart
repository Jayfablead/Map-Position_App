import 'dart:async';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Favourite/FavouriteScreen.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Marina/MyMarinaListScreen.dart';
import '../PrimiumPayments/PremiumScreen.dart';
import '../Profile/ProfileScreen.dart';
import 'buildErrorDialog.dart';
import 'const.dart';

class Bottombar extends StatefulWidget {
  int? select_tab;

  Bottombar({super.key, required this.select_tab});

  @override
  State<Bottombar> createState() => _BottombarState();
}

bool isopn = false;
int? _selectedIndex;
NotchBottomBarController? _controller;
Timer? _timer;
bool _isConnected = false;

class _BottombarState extends State<Bottombar> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    setState(() {
      _selectedIndex = widget.select_tab!;

      print("sel:${_selectedIndex}");
    });
    _checkInternet();
    // _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
    //   RemainingMsgApi();
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    _controller = NotchBottomBarController(index: widget.select_tab!);
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedNotchBottomBar(
            color: Colors.white,
            notchBottomBarController: _controller!,
            showLabel: true,
            notchColor: Colors.black,
            itemLabelStyle: TextStyle(color: Colors.black, fontFamily: 'pop'),
            removeMargins: true,
            bottomBarWidth: MediaQuery.of(context).size.width,
            durationInMilliSeconds: 100,
            bottomBarItems: [
              BottomBarItem(
                inActiveItem:
                Icon(Icons.favorite, color: Colors.black),
                activeItem:
                Icon(Icons.favorite, color: Colors.white),
                itemLabel: 'Favourite',
              ),
              BottomBarItem(
                inActiveItem:
                Icon(Icons.paid, color: Colors.black87),
                activeItem:
                Icon(Icons.paid, color: Colors.white),
                itemLabel: 'Premium',
              ),
              BottomBarItem(
                inActiveItem: Icon(CupertinoIcons.home, color: Colors.black),
                activeItem: Icon(CupertinoIcons.home, color: Colors.white),
                itemLabel: 'Home',
              ),
              BottomBarItem(
                inActiveItem:
                Icon(Icons.directions_boat, color: Colors.black),
                activeItem:
                Icon(Icons.directions_boat, color: Colors.white),
                itemLabel: 'Position',
              ),
              BottomBarItem(
                inActiveItem:
                Icon(Icons.person, color: Colors.black),
                activeItem:
                Icon(Icons.person, color: Colors.white),
                itemLabel: 'Profile',
              ),
            ],

            onTap: (index) {
              _isConnected ? index == 0
                  ? Get.to(FavouriteScreen())
                  : index == 1
                  ? Get.to(PremiumScreen())
                  : index == 2
                  ? Get.to(HomeScreen())
                  : index == 3
                  ? Get.to(MyMarinaListScreen())
                  : Get.to(ProfileScreen()) : buildErrorDialog(context, '', "Without Internet Not Use This");

            },
          ),
        ),
      ],
    );
  }
  Future<void> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
    }
  }
}
