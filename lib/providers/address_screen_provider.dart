import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app/data/services/database/address_database.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddressProvider extends ChangeNotifier {
  YandexMapController? mapController;
  List<Placemark> placeMarks = [];
  String? country;
  String? street;

  bool _isMapVisible = true;

  bool get isMapVisible => _isMapVisible;

  void toggleMapVisibility() {
    _isMapVisible = !_isMapVisible;
    notifyListeners();
  }

  /// #Database Operations
  void saveAddressToDatabase() async {
    if (country != null && street != null) {
      await AddressDatabase.saveAddress(country!, street!);
      await Future.delayed(const Duration(milliseconds: 800));
    }
  }

  Future<void> getAddressFromDatabase() async {
    String? savedCountry = await AddressDatabase.getCountry();
    String? savedStreet = await AddressDatabase.getStreet();

    if (savedCountry != null && savedStreet != null) {
      country = savedCountry;
      street = savedStreet;
      notifyListeners();
    }
  }

  void editLocation() {
    toggleMapVisibility();
    getCurrentLocation();
  }

  List<PlacemarkMapObject> list = [
    PlacemarkMapObject(
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            "assets/icons/profile/ic_marker.png",
          ),
          scale: 0.4,
          isVisible: true,
        ),
      ),
      mapId: const MapObjectId("1"),
      point: const Point(
        latitude: 41.2995,
        longitude: 69.2401,
      ),
    ),
  ];

  void addPlaceMarkMapObject(Point point) {
    list.add(
      PlacemarkMapObject(
        mapId: const MapObjectId('1'),
        point: point,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              "assets/icons/profile/ic_marker.png",
            ),
            scale: 0.4,
            isVisible: true,
          ),
        ),
      ),
    );
    notifyListeners();
  }

  void updateAddressInfo(List<Placemark> placeMarks) {
    country = placeMarks.map((e) => e.country).first;
    street = placeMarks.map((e) => e.thoroughfare).first;
    print("STREET : $street");
    notifyListeners();
  }

  void setMapController(YandexMapController controller) {
    mapController = controller;
  }

  void getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    addPlaceMarkMapObject(
      Point(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
    await moveToCurrentLocation(position);
  }

  Future<void> moveToCurrentLocation(Position position) async {
    await mapController!.moveCamera(
      animation: const MapAnimation(
        type: MapAnimationType.linear,
        duration: 0.8,
      ),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
          zoom: 17,
        ),
      ),
    );
    placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    updateAddressInfo(placeMarks);
    print("PlaceMarks: ${placeMarks.toString()}");
    notifyListeners();
  }
}
