import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controllerCompleter =
      Completer<GoogleMapController>();
  CameraPosition _center =
      CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 14);
  final List<Marker> _marker = [];
  final List<Marker> _branch = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(23.0225, 72.5714),
      infoWindow: InfoWindow(title: "testinjg"),
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(22.3072, 73.1812),
      infoWindow: InfoWindow(title: "testinjg", snippet: "testinjg"),
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(30.3753, 69.3451),
      infoWindow: InfoWindow(title: "testinjg", snippet: "testinjg"),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_branch);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onMapTapped,
        markers: Set<Marker>.of(_marker),
        initialCameraPosition: CameraPosition(
          target: LatLng(21.1702, 72.8311),
          zoom: 10,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controllerCompleter.complete(controller);
    });
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId('${_marker.length}'),
          position: latLng,
          infoWindow: InfoWindow(
            title: 'Marker ${_marker.length}',
          ),
        ),
      );
      print("latlng123456${latLng}");
    });
  }
}
