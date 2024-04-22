// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:sizer/sizer.dart';
//
// import '../Extras/Const.dart';
//
// class Webviewscreen extends StatefulWidget {
//   Webviewscreen({
//     super.key,
//   });
//
//   @override
//   State<Webviewscreen> createState() => _WebviewscreenState();
// }
//
// class _WebviewscreenState extends State<Webviewscreen> {
//   late InAppWebViewController _webViewController;
//
//   bool _load = true;
//
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     setState(() {
//       _load = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgcolor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 5.h,
//             ),
//             Row(
//               children: [
//                 Text("dfdsfdsf"),
//               ],
//             ),
//             Container(
//               height: 50.h,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 // Set scroll direction to horizontal
//                 itemCount: 10,
//                 itemBuilder: (BuildContext context, int index) {
//                   return SizedBox(
//                     width: 150, // Adjust this value according to your needs
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: EdgeInsets.symmetric(horizontal: 2.w),
//                       color: index % 2 == 0 ? bgcolor : Colors.white,
//                       child: InAppWebView(
//                         initialOptions: InAppWebViewGroupOptions(
//                           crossPlatform: InAppWebViewOptions(
//                             transparentBackground: true,
//                           ),
//                         ),
//                         initialUrlRequest: URLRequest(
//                           url: WebUri.uri(Uri.parse(
//                               "https://my.matterport.com/show/?m=omU8T1CbKVQ&wmode=opaque")),
//                         ),
//                         onWebViewCreated: (InAppWebViewController controller) {
//                           _webViewController = controller;
//                         },
//                         onLoadStart:
//                             (InAppWebViewController controller, Uri? url) {
//                           setState(() {
//                             _load = true;
//                           });
//                         },
//                         onLoadStop:
//                             (InAppWebViewController controller, Uri? url) {
//                           setState(() {
//                             _load = false;
//                             print('loading : ${_load}');
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 3.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
