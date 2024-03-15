// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Bottombar extends StatefulWidget {
//   int? selin;
//   int? selin1;
//
//   Bottombar({super.key, required this.selin, this.selin1});
//
//   @override
//   State<Bottombar> createState() => _BottombarState();
// }
//
// bool isopn = false;
// int? _selectedIndex;
// NotchBottomBarController? _controller;
//
// class _BottombarState extends State<Bottombar> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       _selectedIndex = widget.selin!;
//       print("sel:${_selectedIndex}");
//     });
//   }
//
//   int cartItemCount = 5;
//
//   @override
//   Widget build(BuildContext context) {
//     _controller = NotchBottomBarController(index: widget.selin!);
//     return Stack(children: [
//       loginmodal?.user?.email == "" || loginmodal?.user?.email == null
//           ? Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: AnimatedNotchBottomBar(
//                 notchBottomBarController: _controller!,
//                 showLabel: true,
//                 color: bgcolor,
//                 notchColor: primary,
//                 itemLabelStyle: TextStyle(color: primary, fontFamily: 'volken'),
//                 removeMargins: true,
//                 bottomBarWidth: MediaQuery.of(context).size.width,
//                 durationInMilliSeconds: 100,
//                 bottomBarItems: [
//                   BottomBarItem(
//                     inActiveItem: Icon(CupertinoIcons.cart, color: primary),
//                     activeItem: Icon(CupertinoIcons.cart, color: Boxbg),
//                     itemLabel: 'Cart',
//                   ),
//                   BottomBarItem(
//                     inActiveItem: Icon((Icons.category), color: primary),
//                     activeItem: Icon(CupertinoIcons.cart, color: Boxbg),
//                     itemLabel: 'Category',
//                   ),
//                   BottomBarItem(
//                     inActiveItem: Icon(LineIcons.home, color: primary),
//                     activeItem: Icon(LineIcons.home, color: Boxbg),
//                     itemLabel: 'Home',
//                   ),
//                   BottomBarItem(
//                     inActiveItem:
//                         Icon(Icons.favorite_border_rounded, color: primary),
//                     activeItem: Icon(LineIcons.home, color: Boxbg),
//                     itemLabel: 'Wishlist',
//                   ),
//                   BottomBarItem(
//                     inActiveItem: Icon(CupertinoIcons.person, color: primary),
//                     activeItem: Icon(CupertinoIcons.person, color: Boxbg),
//                     itemLabel: 'Login',
//                   ),
//                 ],
//                 onTap: (index) {
//                   index == 2
//                       ? Get.to(
//                           Homepage(
//                             sele: 2,
//                           ),
//                         )
//                       : index == 3
//                           ? Get.offAll(LoginPage())
//                           : index == 1
//                               ? Get.to(
//                                   CategoryPage(),
//                                 )
//                               : index == 0
//                                   ? Get.to(
//                                       MyNewCartPage(sele: 0),
//                                     )
//                                   : index == 4
//                                       ? Get.offAll(LoginPage())
//                                       : null;
//                   setState(
//                     () {
//                       index == 0 ? isopn = false : isopn = true;
//                     },
//                   );
//                 },
//               ),
//             )
//           : Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: AnimatedNotchBottomBar(
//                 notchBottomBarController: _controller!,
//                 showLabel: true,
//                 color: bgcolor,
//                 notchColor: primary,
//                 itemLabelStyle: TextStyle(color: primary, fontFamily: 'volken'),
//                 removeMargins: true,
//                 bottomBarWidth: MediaQuery.of(context).size.width,
//                 durationInMilliSeconds: 100,
//                 bottomBarItems: [
//                   BottomBarItem(
//                     inActiveItem: Icon(
//                       Icons.shopping_bag,
//                       color: primary,
//                     ),
//                     activeItem: Icon(Icons.shopping_bag, color: Boxbg),
//                     itemLabel: 'Order',
//                   ),
//                   BottomBarItem(
//                     inActiveItem: Icon(LineIcons.heartAlt, color: primary),
//                     activeItem: Icon(LineIcons.heartAlt, color: Boxbg),
//                     itemLabel: 'Wishlist',
//                   ),
//                   BottomBarItem(
//                     inActiveItem: Icon(LineIcons.home, color: primary),
//                     activeItem: Icon(LineIcons.home, color: Boxbg),
//                     itemLabel: 'Home',
//                   ),
//                   BottomBarItem(
//                     inActiveItem:
//                         Icon(Icons.person_outline_rounded, color: primary),
//                     activeItem:
//                         Icon(Icons.person_outline_rounded, color: Boxbg),
//                     itemLabel: 'Profile',
//                   ),
//                   BottomBarItem(
//                     inActiveItem:
//                         Icon(CupertinoIcons.cart_fill, color: primary),
//                     activeItem: Icon(CupertinoIcons.cart_fill, color: Boxbg),
//                     itemLabel: 'Cart',
//                   ),
//                 ],
//                 onTap: (index) {
//                   index == 0
//                       ? Get.to(
//                           Myorders(
//                             sele: 0,
//                           ),
//                         )
//                       : index == 1
//                           ? Get.to(
//                               Wishlist(
//                                 sele: 1,
//                               ),
//                             )
//                           : index == 2
//                               ? Get.to(
//                                   Homepage(
//                                     sele: 2,
//                                   ),
//                                 )
//                               : index == 3
//                                   ? Get.to(
//                                       Myprofilepage(
//                                         sele: 3,
//                                       ),
//                                     )
//                                   : Get.to(
//                                       MyNewCartPage(sele: 4),
//                                     );
//                   setState(
//                     () {
//                       index == 0
//                           ? isopn = false
//                           : index == 1
//                               ? isopn = false
//                               : index == 2
//                                   ? isopn = false
//                                   : index == 3
//                                       ? isopn = false
//                                       : isopn = true;
//                     },
//                   );
//                 },
//               ),
//             ),
//       // isopn?Container(): Positioned(
//       //      bottom:5.h, // Adjust the value based on your layout
//       //      right: 8.w, // Adjust the value based on your layout
//       //      child: GestureDetector(
//       //          onTap: () {
//       //            // Handle the tap on the cart icon
//       //          },
//       //          child: Container(
//       //              width: 5.w,
//       //              height: 5.w,
//       //              child: Stack(
//       //                alignment: Alignment.center,
//       //                children: [
//       //                  if (cartItemCount > 0)
//       //                    Positioned(
//       //                      top: 0,
//       //                      right: 0,
//       //                      child: Container(
//       //                        width: 5.w,
//       //                        height: 5.w,
//       //                        alignment: Alignment.center,
//       //                        padding: EdgeInsets.all(2),
//       //                        decoration: BoxDecoration(
//       //                          color: Colors.red,
//       //                          borderRadius: BorderRadius.circular(100),
//       //                        ),
//       //                        constraints: BoxConstraints(
//       //                          minWidth: 16,
//       //                          minHeight: 16,
//       //                        ),
//       //                        child: Text(
//       //                          cartItemCount.toString(),
//       //                          style: TextStyle(
//       //                            color: Colors.white,
//       //                            fontSize: 12,
//       //
//       //                          ),
//       //                          textAlign: TextAlign.center,
//       //                        ),
//       //                      ),
//       //                    ),
//       //                ],
//       //              ))))
//     ]);
//   }
// }
