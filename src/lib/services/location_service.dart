import 'package:geolocator/geolocator.dart';
import 'package:mudakir/services/app_version.dart';
import 'package:flutter/material.dart';

class LocationService with ChangeNotifier {

  bool hasPermission = false;
  bool serviceEnabled = false;
  Position? locationData;

  bool _initialized = false;

  LocationService() {
    _initialize();
  }

  Future<void> _initialize() async {
    await updateAndNotify();
    _initialized = true;
  }

  Future<void> requestPermission() async {
    if ((await Geolocator.requestPermission()) == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
    await updateAndNotify();
  }

  Future<void> requestService() async {
    await Geolocator.openLocationSettings();
    await updateAndNotify();
  }
  
  Future<void> updateAndNotify() async {

    AppVersion.log("LocationService", "Getting Location Status...");

    try {
      Position? lastPosition = await Geolocator.getLastKnownPosition();
      if(lastPosition != null) {
        
        AppVersion.log("LocationService", "Got a location from getLastKnownPosition()");

        locationData = lastPosition;
        
        serviceEnabled = true;
        hasPermission = true;
        
        notifyListeners();
        saveLocationData(
          latitude: locationData!.latitude,
          longitude: locationData!.longitude
        );

        return;
      }
    
    } catch (e) {
      AppVersion.log("LocationService", "Error: ${e.toString()}");
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    notifyListeners();

    LocationPermission status = await Geolocator.checkPermission();

    hasPermission = status == LocationPermission.whileInUse;
    hasPermission = status == LocationPermission.always ? true : hasPermission;

    notifyListeners();

    if (serviceEnabled && hasPermission) {
      locationData = await Geolocator.getCurrentPosition();
      notifyListeners();
      saveLocationData(
        latitude: locationData!.latitude,
        longitude: locationData!.longitude
      );
    }

    AppVersion.log("LocationService",
      "Enabled=$serviceEnabled, "
      "PermissionStatus=$status, "
      "${locationData.toString()}"
    );

  }

  Future<void> saveLocationData({
    required double latitude,
    required double longitude,
  }) async {
    if (
          await AppVersion.data!.setDouble("LocationLatitude", latitude)
      &&  await AppVersion.data!.setDouble("LocationLongitude", longitude)
      &&  await AppVersion.data!.setInt("LocationSaveTime", DateTime.now().microsecondsSinceEpoch)
    ) {
      AppVersion.log("LocationService", "Location Saved, longitude: $longitude, latitude: $latitude");
      notifyListeners();
      return;
    }
    AppVersion.log("LocationService", "Couldn't save location data, longitude: $longitude, latitude: $latitude");
  }

  static bool gotSavedLocationData() {
    return AppVersion.data!.containsKey("LocationLatitude")
        && AppVersion.data!.containsKey("LocationLongitude")
        && AppVersion.data!.containsKey("LocationSaveTime");
  }

  static Map<String, dynamic> getSavedLocationData() {
    return {
      "latitude"    : AppVersion.data!.getDouble("LocationLatitude"),
      "longitude"   : AppVersion.data!.getDouble("LocationLongitude"),
      "capturetime" : AppVersion.data!.getInt("LocationSaveTime"),
    };
  }

  Future<bool> removeSavedLocationData() async {
    bool status = await AppVersion.data!.remove("LocationLatitude") 
        && await AppVersion.data!.remove("LocationLongitude") 
        && await AppVersion.data!.remove("LocationSaveTime");
    notifyListeners();
    return status;
  }

  bool hasData() => locationData != null;
  bool initialized() => _initialized;
}