import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasteaider/user/homePage.dart';

class FindBinPage extends StatefulWidget {
  const FindBinPage({super.key});

  @override
  State<FindBinPage> createState() => _FindBinPageState();
}

class _FindBinPageState extends State<FindBinPage> {
  Uint8? markerImage;
  Future<Uint8List> getbytesfromasset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor? customIcon;
  @override
  void initState() {
    getBytesFromAsset('assets/images/person.png', 100).then((onValue) {
      customIcon = BitmapDescriptor.fromBytes(onValue);
    });

    super.initState();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  // void addCustomIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration(), 'assets/images/person.png')
  //       .then((icon) {
  //     setState(() {
  //       markerIcon = icon;
  //     });
  //   });
  // }

  late GoogleMapController googlemapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580614, -122.085749655962), zoom: 14);
  // Set<Marker> markers = {};
  List<Marker> marker = [];
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  // @override
  // void initState() {
  //   addCustomIcon();
  //   super.initState();
  // }
  // void addCustomIcon(){
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/person.png').then((icon){
  //     setState(() {
  //       markerIcon=icon;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Bin'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
            icon: Icon(Icons.arrow_forward),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: Set<Marker>.of(marker),
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googlemapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await _determinedPosition();
            // BitmapDescriptor markerbitmap =
            //     await BitmapDescriptor.fromAssetImage(
            //   ImageConfiguration(),
            //   "assets/images/person.png",
            // );
            print('latitude=====>${position.latitude}');
            List<Marker> list = await [
              Marker(
                  draggable: true,
                  onDragEnd: (value) {},
                  markerId: MarkerId('1'),
                  position: LatLng(position.latitude, position.longitude),
                  infoWindow: InfoWindow(title: 'My Position'),
                  icon: customIcon!

                  // icon: BitmapDescriptor.fromBytes(Uint8List.view(
                  //     'assets/images/person.png'))
                  ),
              Marker(
                  markerId: MarkerId('2'),
                  position: LatLng(37.42796133580614, -122.085749655962),
                  infoWindow: InfoWindow(title: 'Bin')),
              Marker(
                  markerId: MarkerId('3'),
                  position: LatLng(37.4143, -122.0774),
                  infoWindow: InfoWindow(title: 'Bin')),
              Marker(
                  markerId: MarkerId('4'),
                  position: LatLng(37.4268, -122.0807),
                  infoWindow: InfoWindow(title: 'Bin')),
              Marker(
                  markerId: MarkerId('5'),
                  position: LatLng(37.4227, -122.0664),
                  infoWindow: InfoWindow(title: 'Bin'))
            ];
            googlemapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14)));
            // markers.clear();
            marker.clear();

            marker.addAll(list

                // Marker(
                //   markerId: MarkerId('Currentlocation'),
                //   position: LatLng(position.latitude, position.longitude))
                );
            setState(() {});
          },
          label: Text('Find bin'),
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
