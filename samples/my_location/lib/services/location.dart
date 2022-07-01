import 'package:location/location.dart';

class DeviceLocation {
  LocationData? locationData;
  PermissionStatus? _permissionGranted;
  bool serviceEnabled = false;
  final Location location = Location();

  DeviceLocation();

  Future<bool> enableService() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        serviceEnabled = false;
      }
    }
    return serviceEnabled;
  }

  Future<bool> grantPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    } else if (_permissionGranted != PermissionStatus.granted) {
      return false;
    }
    return true;
  }

  Future<void> getDeviceLocationData() async {
    locationData = await location.getLocation();
  }
}
