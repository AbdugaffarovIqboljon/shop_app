import 'package:shop_app/library.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationService {
  Future<Point> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceException('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationServiceException('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationServiceException(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final Position position = await Geolocator.getCurrentPosition();
    return Point(latitude: position.latitude, longitude: position.longitude);
  }
}

class LocationServiceException implements Exception {
  final String message;

  LocationServiceException(this.message);
}
