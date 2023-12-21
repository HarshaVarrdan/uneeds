import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uneeds/extra/Common_Functions.dart';

class LocationFunctions {
  Future<Map<String, dynamic>> getCurrentPosition(BuildContext context) async {
    late Position currentPosition;
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return {"error": "permission"};
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
    }).catchError((e) {
      debugPrint(e);
      CommonFunctions().showMessageSnackBar(e, context);
    });
    return {
      "Position": currentPosition,
      "Address": await _getAddressFromLatLng(currentPosition, context)
    };
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CommonFunctions().showMessageSnackBar(
          'Location services are disabled. Please enable the services',
          context);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CommonFunctions()
            .showMessageSnackBar('Location permissions are denied', context);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      CommonFunctions().showMessageSnackBar(
          'Location permissions are permanently denied, we cannot request permissions.',
          context);
      return false;
    }
    return true;
  }

  Future<Map<String, String>> _getAddressFromLatLng(
      Position position, BuildContext context) async {
    late Placemark place;
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      place = placemarks[0];
    }).catchError((e) {
      CommonFunctions().showMessageSnackBar(e, context);
    });
    return {
      "street": place.street!,
      "subLocality": place.subLocality!,
      "subAdministrationArea": place.subAdministrativeArea!,
      "postalCode": place.postalCode!
    };
  }
}
