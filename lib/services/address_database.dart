import 'package:shared_preferences/shared_preferences.dart';

class AddressDatabase {
  static const String countryKey = 'country';
  static const String streetKey = 'street';

  static Future<void> saveAddress(String country, String street) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(countryKey, country);
    await prefs.setString(streetKey, street);
  }

  static Future<String?> getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(countryKey);
  }

  static Future<String?> getStreet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(streetKey);
  }
}
