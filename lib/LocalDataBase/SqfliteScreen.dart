import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LatLngModel {
  int? id;
  double? latitude;
  double? longitude;

  LatLngModel({this.id, this.latitude, this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  Database? _db;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS map(
        id INTEGER PRIMARY KEY,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'map_database.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> insertLatLng(LatLngModel latLng) async {
    final Database db = await database;
    await db.insert(
      'map',
      latLng.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<LatLngModel>> getAllLatLng() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('map');
    return List.generate(maps.length, (i) {
      return LatLngModel(
        id: maps[i]['id'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
      );
    });
  }
}

class SqfliteScreen extends StatefulWidget {
  @override
  State<SqfliteScreen> createState() => _SqfliteScreenState();
}

class _SqfliteScreenState extends State<SqfliteScreen> {
  Completer<GoogleMapController> _controllerCompleter =
      Completer<GoogleMapController>();
  List<Marker> _markers = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadMarkersFromDatabase();
  }

  void _loadMarkersFromDatabase() async {
    List<LatLngModel> latLngList = await _databaseHelper.getAllLatLng();
    setState(() {
      _markers = latLngList
          .map((latLng) => Marker(
                markerId: MarkerId(latLng.id.toString()),
                position: LatLng(latLng.latitude!, latLng.longitude!),
                infoWindow: InfoWindow(
                  title: 'Marker ${latLng.id}',
                ),
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllLatLng(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onMapTapped,
              markers: Set<Marker>.of(_markers),
              initialCameraPosition: CameraPosition(
                target: LatLng(21.1702, 72.8311),
                zoom: 10,
              ),
            );
          }
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controllerCompleter.complete(controller);
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('${_markers.length}'),
          position: latLng,
          infoWindow: InfoWindow(
            title: 'Marker ${_markers.length}',
          ),
        ),
      );
      _databaseHelper.insertLatLng(LatLngModel(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      ));
      print("latlang;-${latLng}");
    });
  }
}
