import '../global_state.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Map_Screen extends StatefulWidget {
  @override
  Map_Screen_State createState() => Map_Screen_State();
}

class Map_Screen_State extends State<Map_Screen> {
  Position position;
  Global_State _global_key = Global_State.instance;
  double _latitude;
  double _longitude;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center;
  LatLng _lastMapPosition = _center;
  Set<Marker> _markers = {};

  var _addressLine;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() async {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "$_lastMapPosition",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        draggable: true,
      ));
      _latitude = _lastMapPosition.latitude;
      _longitude = _lastMapPosition.longitude;
      _getUserLocation();
    });
  }

  //translate latitude and longitude into address
  _getUserLocation() async {
    _markers.forEach((value) async {
      final coordinates =
          Coordinates(value.position.latitude, value.position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var address = addresses.first;
      _addressLine = address.addressLine;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onAddMarkerButtonPressed();
    _center = LatLng(_global_key.latitude, _global_key.longitude);
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text(
            "Hope 4 Cat",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: screen_height / 2,
                      width: screen_width - 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 17.0,
                        ),
                        mapType: MapType.normal,
                        markers: _markers,
                        onCameraMove: _onCameraMove,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                          child: FloatingActionButton(
                            onPressed: _onAddMarkerButtonPressed,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.blueGrey[700],
                            child: const Icon(Icons.add_location, size: 30.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(3, 15, 0, 0),
              child: Container(
                height: 90,
                width: screen_width - 50,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: _addressLine == null
                    ? Text(
                        'Please press the location button to refresh address',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        '${_addressLine}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(35, 20, 30, 0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  _global_key.latitude = _latitude;
                  _global_key.longitude = _longitude;
                  print(_global_key.latitude);
                  print(_global_key.longitude);
                  Navigator.pop(context);
                },
                child: Text(
                  "Confirm Location",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                color: Colors.deepOrange[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
