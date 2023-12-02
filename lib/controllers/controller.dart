import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/constant_method.dart';
import '../models/address_list_model.dart';
import '../models/locality_list_model.dart';
import '../services/service.dart';

class MyController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxBool isDarkMode = false.obs;
  RxInt itemCount = 0.obs;
  RxInt itemCost = 0.obs;
  RxList<dynamic> products = [].obs;

  List<Color> clr = <Color>[
    Colors.blue.shade50,
    Colors.purple.shade50,
    Colors.green.shade50,
    Colors.orange.shade50,
    Colors.red.shade50,
    Colors.cyan.shade50,
    Colors.amber.shade50,
  ];
  RxString useName = ''.obs;
  RxString emailAddress = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString image = ''.obs;
  RxString uid = ''.obs;
  RxString langitude = ''.obs;
  RxString longitude = ''.obs;
  RxString location = ''.obs;
  RxInt addressID = 0.obs;
  RxString locality = ''.obs;
  RxList<dynamic> myAddressList = <AddressData>[].obs;
  late Box hiveBox = Hive.box('box');
  late Box productBox = Hive.box('productBox');
  RxInt selectIndex = 0.obs;
  RxList<dynamic> localityList = <String>[].obs;

  void changeTheme(state) {
    if (state == true) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    update();
  }

  @override
  void onInit() {
    start();
    super.onInit();
  }

  start() async {
    try {
      setOptimalDisplayMode();
      await darkModeCheck();
      checkNetworkConnectivity();
      defaultAddress();
      fetchLocalityList();
    } catch (error) {
      successMsg('Something went wrong', false);
    }
  }

  Future<void> darkModeCheck() async {
    var prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? true;
    update();
  }

  Future<void> setOptimalDisplayMode() async {
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;
    final List<DisplayMode> sameResolution = supported.where((DisplayMode m) => m.width == active.width && m.height == active.height).toList()..sort((DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate));
    final DisplayMode mostOptimalMode = sameResolution.isNotEmpty ? sameResolution.first : active;
    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  //API
  Future<void> openHiveBox() async {
    hiveBox = await Hive.openBox('box');
    productBox = await Hive.openBox('productBox');
  }

  checkNetworkConnectivity() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        defaultAddress();
        Get.snackbar('Online', 'Connected to Mobile Network', backgroundColor: Colors.greenAccent, duration: const Duration(seconds: 3), colorText: Colors.black);
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        defaultAddress();
        Get.snackbar('Online', 'Connected to Wifi Network', backgroundColor: Colors.greenAccent, duration: const Duration(seconds: 3), colorText: Colors.black);
      } else {
        Get.defaultDialog(
          content: const Text('Check your Internet Connection'),
          textCancel: 'Exit',
          onCancel: () {
            SystemNavigator.pop();
          },
        );
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
          Get.defaultDialog(
            title: 'Location Permission',
            barrierDismissible: false,
            middleText: 'Location permission is permanently denied, we cannot request permissions.',
            textCancel: 'Exit',
            onCancel: () {
              SystemNavigator.pop();
            },
            textConfirm: 'Setting',
            onConfirm: () {
              Geolocator.openAppSettings();
              determinePosition();
            },
          );
          return null;
        } else {
          return await Geolocator.getCurrentPosition();
        }
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          Get.defaultDialog(
            backgroundColor: Get.theme.primaryColorDark,
            title: 'Location Permission',
            titleStyle: Get.textTheme.titleMedium,
            barrierDismissible: false,
            middleText: 'Location permission is denied.',
            textCancel: 'Exit',
            onCancel: () {
              SystemNavigator.pop();
            },
            textConfirm: 'Setting',
            onConfirm: () {
              Geolocator.openAppSettings();
              determinePosition();
            },
          );

          return null;
        } else {
          return await Geolocator.getCurrentPosition();
        }
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        return await Geolocator.getCurrentPosition();
      }
    } else {
      serviceEnabled = await Geolocator.openAppSettings();
      if (!serviceEnabled) {
        successMsg('Location services are disabled.', false);
        return null;
      } else {
        return await Geolocator.getCurrentPosition();
      }
    }
    return null;
  }

  getLocation() async {
    Position? tempLocation;
    String address;

    tempLocation = await determinePosition();
    if (tempLocation != null) {
      langitude.value = tempLocation.latitude.toString();
      longitude.value = tempLocation.longitude.toString();
      // await coordinateToAddress(location.latitude, location.longitude);
      Placemark? place = await coordinateToAddress(tempLocation.latitude, tempLocation.longitude);
      locality.value = place!.locality!;
      address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.subAdministrativeArea}, ${place.country}';
      location.value = address;
    }
  }

  Future<Placemark?> coordinateToAddress(latitude, longitude) async {
    try {
      List<Placemark> placemarks;
      if (!kIsWeb) {
        placemarks = await placemarkFromCoordinates(latitude, longitude);
        Placemark place = placemarks[0];
        return place;
      } else {
        GeoData data = await Geocoder2.getDataFromCoordinates(latitude: latitude, longitude: longitude, googleMapApiKey: "AIzaSyA1IzSXmq9t3jrT8KOLRI1hE-pwoFJNh28");
        location.value = data.address;
        locality.value = data.city;
      }
    } on Exception catch (e) {
      Get.defaultDialog(
        title: 'Network Problem',
        content: Column(
          children: [
            Text('$e'),
            ElevatedButton(
              onPressed: () async {
                coordinateToAddress(latitude, longitude);
                Get.back();
              },
              child: const Text('try again'),
            ),
          ],
        ),
      );
    }
    return null;
  }

  defaultAddress() async {
    try {
      var tempLocation = await determinePosition();
      if (tempLocation != null) {
        langitude.value = tempLocation.latitude.toString();
        longitude.value = tempLocation.longitude.toString();
        Placemark? place = await coordinateToAddress(tempLocation.latitude, tempLocation.longitude);
        locality.value = place!.locality!;

        String address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.subAdministrativeArea}, ${place.country}';
        location.value = address;
        if (isLoggedIn.value) {
          var res = await Services().defualtAddress(uid.value, LatLng(tempLocation.latitude, tempLocation.longitude), address, place.postalCode.toString(), place.locality.toString(), ' ', 'other');
          if (res!.responseCode == '200') {
            addressID.value = int.parse(res.address!.id!);
          } else {
            Get.defaultDialog(content: Text(res.responseMsg!));
          }
        }
      } else {
        successMsg("Problem in fetching address", false);
      }
    } catch (e) {
      if (!kIsWeb) Get.defaultDialog(content: const Text('Something went Wrong'));
      successMsg("We can't set your default address", false);
    }
  }

  fetchLocalityList() async {
    try {
      var response = await Services().localityList();
      if (response!.status == true) {
        List<Localities> tmp = response.data!;
        for (var i in tmp) {
          localityList.add(i.locality!);
        }
      } else {
        Get.defaultDialog(content: Text('${response.message}'));
      }
    } catch (e) {
      Get.defaultDialog(content: Text('$e'));
    }
  }
}
