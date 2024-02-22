import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/address_screen_provider.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/build_map_section.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/build_saved_address_section.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/save_button.dart';
import 'package:shop_app/utils.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, _) {
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
          body: addressProvider.isMapVisible
              ? Column(
                  children: [
                    const SizedBox(height: 15),
                    Expanded(
                      flex: 6,
                      child: buildMapSection(addressProvider),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Row(
                                children: [
                                  if (addressProvider.country != null &&
                                      addressProvider.country!.isNotEmpty)
                                    Text(
                                      "${removeBrackets(addressProvider.country!)},",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  const SizedBox(width: 5),
                                  Text(
                                    removeBrackets(addressProvider.street),
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50.sp),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: buildSaveButton(
                                onTap: () {
                                  addressProvider.saveAddressToDatabase();
                                  addressProvider.toggleMapVisibility();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                )
              : buildSavedAddressSection(addressProvider),
        );
      },
    );
  }
}
