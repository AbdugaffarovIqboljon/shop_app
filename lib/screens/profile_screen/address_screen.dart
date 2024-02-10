import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/save_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  YandexMapController? mapController;
  Position? position;
  LocationPermission permission = LocationPermission.always;
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
        latitude: 37.78572997442163,
        longitude: -122.40631317855258,
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "Address",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              alignment: Alignment(0.92.sp, 0.96.sp),
              children: [
                YandexMap(
                  mode2DEnabled: true,
                  mapType: MapType.map,
                  nightModeEnabled: false,
                  logoAlignment: const MapAlignment(
                    horizontal: HorizontalAlignment.left,
                    vertical: VerticalAlignment.bottom,
                  ),
                  mapObjects: list,
                  onMapCreated: (YandexMapController controller) {
                    mapController = controller;
                  },
                  onMapTap: (Point point) async {
                    setState(() {
                      list.add(
                        PlacemarkMapObject(
                          mapId: const MapObjectId('1'),
                          point: Point(
                            latitude: point.latitude,
                            longitude: point.longitude,
                          ),
                        ),
                      );
                    });
                    print("POINT LATITUDE: ${point.latitude}");
                    print("POINT LONGTITUDE: ${point.longitude}");
                  },
                ),
                IconButton(
                  iconSize: 30.sp,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black87,
                  ),
                  onPressed: () {
                    _getCurrentLocation();
                  },
                  icon: const Icon(
                    Icons.my_location_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          buildSaveButton(
            onTap: () {},
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    setState(() {
      list.add(
        PlacemarkMapObject(
          mapId: const MapObjectId('1'),
          point: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        ),
      );
    });

    await _moveToCurrentLocation(position);
  }

  Future<void> _moveToCurrentLocation(
    Position position,
  ) async {
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
  }
}
