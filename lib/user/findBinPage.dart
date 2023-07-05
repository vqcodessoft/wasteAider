import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindBinPage extends StatefulWidget {
  const FindBinPage({super.key});

  @override
  State<FindBinPage> createState() => _FindBinPageState();
}

class _FindBinPageState extends State<FindBinPage> {
  late GoogleMapController googlemapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580614, -122.085749655962), zoom: 14);
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Current Location'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googlemapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await _determinedPosition();
            googlemapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14)));
            markers.clear();

            markers.add(Marker(
                markerId: MarkerId('Currentlocation'),
                position: LatLng(position.latitude, position.longitude)));
            setState(() {});
          },
          label: Text('Current Location'),
          icon: Icon(
            Icons.location_history,
          )),
    );
  }

  Future<Position> _determinedPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Services are Disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission Denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission are permenantly Denied');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
