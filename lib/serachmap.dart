import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapposition/Extras/Const.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(serachscreen());
}

class serachscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
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

  @override
  void dispose() {
    searchController.dispose();
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

  void _searchAndNavigate() async {
    final String address = searchController.text;
    List<Location> locations = await locationFromAddress(address);
    if (locations != null && locations.isNotEmpty) {
      setState(() {
        _center = LatLng(locations[0].latitude, locations[0].longitude);
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId('Searched Location'),
          position: _center,
        ));
        mapController!.animateCamera(CameraUpdate.newLatLng(_center));
      });
    }
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
    });
  }

  MapType _mapType = MapType.satellite;

  void _toggleMapType() {
    setState(() {
      _isSatellite = !_isSatellite;
    });
    setState(() {
      _mapType = _isSatellite ? MapType.satellite : MapType.normal;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    print("livelocation:-${_currentPosition1}");
  }

  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentPosition1,
              // You can set your initial position here
              zoom: 12.0,
            ),
            mapType: _isSatellite ? MapType.satellite : MapType.normal,
            markers: _markers,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            compassEnabled: true,
          ),
          Positioned(
            top: 5.h,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchAndNavigate,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            right: 20,
            child: FloatingActionButton(
backgroundColor: blackback,              onPressed: () {
                _focusOnLiveLocation();
              },
              child: Icon(Icons.my_location,color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 110,
            right: 20,
            child: FloatingActionButton(
              onPressed: _toggleMapType,
              backgroundColor: blackback,
              child: Icon(_isSatellite ? Icons.map_outlined : Icons.map,color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _focusOnLiveLocation() {
    if (_currentPosition1 != null && mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition1,
          zoom: 10.0,
        ),
      ));
    }
  }
}
