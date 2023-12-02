// ignore_for_file: depend_on_referenced_packages

import '../services/service.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
// ignore: implementation_imports
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController {
  final Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    if (text.isNotEmpty) {
      http.Response response = await Services().getLocationData(text);
      var data = jsonDecode(response.body.toString());
      if (data['status'] == 'OK') {
        _predictionList = [];
        data['predictions'].forEach((prediction) => _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        // ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }
}
