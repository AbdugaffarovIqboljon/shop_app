import 'package:shop_app/library.dart';

class CardDatabase {
  static const String keyCardHolder = 'cardHolder';
  static const String keyCardNumber = 'cardNumber';

  static Future<void> saveCreditCard(
    String cardHolder,
    String cardNumber,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyCardHolder, cardHolder);
    prefs.setString(keyCardNumber, cardNumber);
  }

  static Future<Map<String, String>?> getCreditCard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cardHolder = prefs.getString(keyCardHolder);
    final String? cardNumber = prefs.getString(keyCardNumber);

    if (cardHolder != null && cardNumber != null) {
      return {'cardHolder': cardHolder, 'cardNumber': cardNumber};
    }

    return null;
  }
}
