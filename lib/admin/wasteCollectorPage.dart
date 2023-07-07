import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class WasteCollectorPage extends StatefulWidget {
  const WasteCollectorPage({super.key});

  @override
  State<WasteCollectorPage> createState() => _WasteCollectorPageState();
}

class _WasteCollectorPageState extends State<WasteCollectorPage> {
  bool isLocationFetching = false;
  var location = TextEditingController();
  var long = TextEditingController();
  var lat = TextEditingController();

  List<Placemark>? placemark;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemark![1];
    location.text =
        '${place.street},${place.country},${place.locality},${place.postalCode}';
    long.text = '${position.longitude}';
    lat.text = '${position.latitude}';
    // locationcontroller.text = widget.address!;
  }

  islocation() async {
    if (isLocationFetching = false) {}
    Position position = await _determinePosition();
    setState(() {
      isLocationFetching = true;
    });
    await GetAddressFromLatLong(position);
    setState(() {
      isLocationFetching = false;
    });
  }

  submit() async {
    Position position = await _determinePosition();
    try {
      CollectionReference collref =
          FirebaseFirestore.instance.collection('wasteCollector');
      collref.add({
        'location': location.text,
        'latitude': position.latitude,
        'longitude': position.longitude
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Location Sent Successfully!'),
      ));
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('There is an error sending Location!'),
      ));
    }
    setState(() {
      location.clear();
      long.clear();
      lat.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 100)),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_sharp)),
          ),
          Padding(padding: EdgeInsets.only(top: 100)),
          ElevatedButton(
              onPressed: () {
                islocation();
                setState(() {
                  isLocationFetching = true;
                });
              },
              child: Text(
                'Your Location',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            margin: EdgeInsets.only(top: 40, right: 30, left: 60),
            child: Text(
              '${location.text}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Longitude:-  ${long.text}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Latitude:-  ${lat.text}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: submit,
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              )),
          SizedBox(height: 50),
          if (isLocationFetching == true)
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      )),
    );
  }
}
