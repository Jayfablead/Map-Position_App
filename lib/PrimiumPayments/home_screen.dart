import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapposition/PrimiumPayments/positionController.dart';

import '../Modal/postionModel.dart';



class OtherPage extends StatelessWidget {
  final PositionController positionController = Get.put(PositionController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Page'),
        
        // actions: [ElevatedButton(onPressed: () {
        //   positionController.fetchPositionData();
        // }, child: Text("data"))],
      ),
      body: Obx(() {
        positionController.fetchPositionData();
        if (positionController.isLoading.value) {
          return buildPositionListView(positionController.position);
        } else {
          return Center(child: Container(height: 100,width: 100, child: CircularProgressIndicator()));
        }
      }),
    );
  }

  Widget buildPositionListView(PostionModel? position) {
    return ListView.builder(
      itemCount: position?.positions.length,
      itemBuilder: (context, index) {
        return  Container(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:     Get.width/12,
                    width:     Get.width/12,
                    child: CachedNetworkImage(
                      imageUrl: '${position?.positions?[index].properties.imgUrl}',
                      placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget while the image is loading
                      errorWidget: (context, url, error) => Text("data"), // Widget to display when an error occurs
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${position?.positions?[index].properties.title}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: Get.width / 22),
                      ),
                      Text(
                        "${position?.positions?[index].geometry?.coordinates[0]}",
                        style: TextStyle(
                            color: Colors.black.withOpacity(.4),
                            fontWeight: FontWeight.w900,
                            fontSize: Get.width / 28),
                      )
                    ],
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                     // Image.asset(""),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: Get.height / 3,
                width: Get.width,
              child:

              CachedNetworkImage(

                    imageUrl: position?.positions[index].properties.postImage ?? "",
                    placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget while the image is loading
                    errorWidget: (context, url, error) => Text("data"), // Widget to display when an error occurs
                  ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [Expanded(child: Text("${position?.positions[index].properties.title}"))],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  height: Get.height / 100,
                  width: Get.width,
                  color: Colors.black.withOpacity(.2)),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        );

      },
    );
  }
}

