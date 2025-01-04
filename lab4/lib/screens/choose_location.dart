import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  LatLng? _chosenLocation;

  void _selectLocation(LatLng location) {
    setState(() {
      _chosenLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Location',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 5.0,
        actions: [
          if (_chosenLocation != null)
            IconButton(
              icon: const Icon(Icons.check, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop(_chosenLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.9981, 21.4253),
          zoom: 14,
        ),
        onTap: _selectLocation,
        markers: _chosenLocation == null
            ? {}
            : {
          Marker(
            markerId: const MarkerId('selected-location'),
            position: _chosenLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange,
            ),
          ),
        },
      ),
      floatingActionButton: _chosenLocation != null
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop(_chosenLocation);
        },
        backgroundColor: Colors.deepOrange,
        icon: const Icon(Icons.check, color: Colors.white),
        label: const Text(
          'Confirm',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null,
    );
  }
}
