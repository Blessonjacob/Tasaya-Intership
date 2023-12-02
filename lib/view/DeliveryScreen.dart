import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;

class DeliveryScreen extends StatefulWidget {
  @override
  State createState() => DeliveryScreenState();
}

class DeliveryScreenState extends State<DeliveryScreen> {
  late GoogleMapController mapController;
  late String apiKey = "AIzaSyCxlXgWml-24GdXaO-k2OU6q62qkzbwjQg"; // Replace with your API key

  LatLng origin = LatLng(22.719568, 75.857727); // San Francisco
  LatLng destination = LatLng(22.7543887319602, 75.8952665170425); // San Francisco (change to your desired destination)

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
      markerId: MarkerId('origin'),
      position: origin,
      infoWindow: InfoWindow(title: 'Origin'),
    ));
    markers.add(Marker(
      markerId: MarkerId('destination'),
      position: destination,
      infoWindow: InfoWindow(title: 'Destination'),
    ));

    getDirections();
  }

  Future<void> getDirections() async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> result = polylinePoints.decodePolyline(data['routes'][0]['overview_polyline']['points']);

        List<LatLng> points = result.map((point) => LatLng(point.latitude, point.longitude)).toList();

        setState(() {
          polylines.add(Polyline(
            polylineId: PolylineId('poly'),
            color: Colors.blue,
            points: points,
            width: 5,
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Directions Demo'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: origin,
          zoom: 12.0,
        ),
        markers: markers,
        polylines: polylines,
      ),
    );
  }
}