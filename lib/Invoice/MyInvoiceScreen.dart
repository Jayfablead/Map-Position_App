import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:mapposition/Extras/Drwer.dart';

import 'package:sizer/sizer.dart';

import '../Extras/Headerwidget.dart';
import '../Extras/PdfViewScreen.dart';

class MyInvoices extends StatefulWidget {
  const MyInvoices({super.key});

  @override
  State<MyInvoices> createState() => _MyInvoicesState();
}

class chat {
  String profilephoto;
  String username;
  String link;
  String time;

  chat(this.profilephoto, this.username, this.link, this.time);
}

class _MyInvoicesState extends State<MyInvoices> {
  List<chat> data = [
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.smartsheet.com/sites/default/files/2020-03/IC-Basic-Invoice-Template-10768_PDF.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.smartsheet.com/sites/default/files/2020-03/IC-Auto-Invoice-10768_PDF.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.smartsheet.com/sites/default/files/2020-03/IC-Sales-Invoice-Template-10768_PDF.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.smartsheet.com/sites/default/files/2020-03/IC-Rental-Invoice-10768_PDF.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.smartsheet.com/sites/default/files/2020-03/IC-Services-Invoice-Template-10768_PDF.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.smartsheet.com/sites/default/files/2020-03/IC-Freelance-Invoice-Template-10768_PDF.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.invoicesimple.com/wp-content/uploads/2022/12/InvoiceSimple-PDF-Template.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.invoicesimple.com/wp-content/uploads/2022/12/InvoiceSimple-PDF-Template.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.invoicesimple.com/wp-content/uploads/2022/12/InvoiceSimple-PDF-Template.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.invoicesimple.com/wp-content/uploads/2022/12/InvoiceSimple-PDF-Template.pdf',
        "Safe Boat"),
    chat(
        "assets/Upload .png",
        'Invoice File.pdf',
        'https://www.invoicesimple.com/wp-content/uploads/2022/12/InvoiceSimple-PDF-Template.pdf',
        "Safe Boat"),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey75891 = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController _serch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
drawer: drawer1(),

      key: _scaffoldKey75891,

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              header(
                  text: "Invoice",
                  callback1: () {
                    _scaffoldKey75891.currentState?.openDrawer();
                  }),
              SizedBox(
                height: 1.h,
              ),

              SizedBox(
                height: 1.h,
              ),
              for (int index = 0; index < 10; index++) ...[
                InkWell(
                  onTap: () {
                    // Get.to(PdfView(
                    //   link: data[index].link,
                    // ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0.5.h),
                    padding: EdgeInsets.all(2.w),
                    height: 12.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: secondary,
                        width: 1.sp
                      ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 1.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(900),
                                    ),
                                    height: 12.w,
                                    width: 13.w,
                                    // padding: EdgeInsets.all(1.w),
                                    child:
                                    Image.asset(data[index].profilephoto)),
                                SizedBox(
                                  width: 2.w,
                                ),
                                SizedBox(
                                  width: 70.w,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].username ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'pop',
                                          color: blackback,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        data[index].time ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'pop',
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp,
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
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}