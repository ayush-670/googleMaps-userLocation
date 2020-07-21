import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _originLatitude = 0.0;
  double _originLongitude = 0.0;
  double _destLatitude = 22.471787;
  double _destLongitude = 88.356525;
  GoogleMapController _controller;

  Color icnColor = Colors.grey[800];
  List<Marker> _markers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
      
        backgroundColor: Colors.white,
        onPressed: () async {
          Position position = await Geolocator()
              .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          setState(() {
            icnColor = Colors.blue;
            _originLatitude = position.latitude;
            _originLongitude = position.longitude;
            _markers.add(
                  Marker(
                      infoWindow: InfoWindow(
                          title: 'Your location', snippet: 'This is your current location'),
                      markerId: MarkerId(
                        "Home",
                      ),
                      position: LatLng(_originLatitude, _originLongitude)),
                );
          });
          _controller.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(_originLatitude, _originLongitude),
            ),
          );
        },
        child: Icon(Icons.my_location, color: icnColor,)
        ,
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _originLatitude,
            _originLongitude,
          ),
          zoom: 17.0,
        ),
        markers: _markers.toSet(),
      ),
    );
  }
}

// IconButton _loc() {}
// // Center(
// //         child: Container(
// //child:
// //       )
//  child:
