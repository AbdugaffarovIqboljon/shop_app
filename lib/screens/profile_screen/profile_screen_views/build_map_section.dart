import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shop_app/providers/address_screen_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

Widget buildMapSection(AddressProvider addressProvider) {
  return Stack(
    alignment: Alignment(0.92.sp, 0.96.sp),
    children: [
      ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        child: YandexMap(
          mode2DEnabled: true,
          mapType: MapType.map,
          nightModeEnabled: false,
          logoAlignment: const MapAlignment(
            horizontal: HorizontalAlignment.left,
            vertical: VerticalAlignment.bottom,
          ),
          mapObjects: addressProvider.list,
          onMapCreated: (YandexMapController controller) {
            addressProvider.setMapController(controller);
          },
          onMapTap: (Point point) async {
            addressProvider.placeMarks = await placemarkFromCoordinates(
              point.latitude,
              point.longitude,
            );
            addressProvider.updateAddressInfo(addressProvider.placeMarks);
            addressProvider.addPlaceMarkMapObject(point);
          },
        ),
      ),
      IconButton(
        iconSize: 30.sp,
        style: IconButton.styleFrom(
          backgroundColor: Colors.black87,
        ),
        onPressed: () async {
          addressProvider.getCurrentLocation();
        },
        icon: const Icon(
          Icons.my_location_outlined,
          color: Colors.white,
        ),
      ),
    ],
  );
}