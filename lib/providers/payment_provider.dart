import 'package:flutter/material.dart';
import 'package:shop_app/services/credit_card_database.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isEditButtonPressed = false;

  bool get isEditButtonPressed => _isEditButtonPressed;

  final TextEditingController _cardNumberController = TextEditingController();

  TextEditingController get cardNumberController => _cardNumberController;

  final TextEditingController _cardHolderNameController =
      TextEditingController();

  TextEditingController get cardHolderNameController =>
      _cardHolderNameController;

  String _cardNumber = '';

  String get cardNumber => _cardNumber;

  set cardNumber(String value) {
    _cardNumber = value;
    notifyListeners();
  }

  String _cardHolder = '';

  String get cardHolder => _cardHolder;

  set cardHolder(String value) {
    _cardHolder = value;
    notifyListeners();
  }

  set isEditButtonPressed(bool value) {
    _isEditButtonPressed = value;
    notifyListeners();
  }

  Future<void> addCreditCard() async {
    await CardDatabase.saveCreditCard(_cardHolder, _cardNumber);
    _isEditButtonPressed = false;
    notifyListeners();
  }

  void toggleEditButton() {
    _isEditButtonPressed = !_isEditButtonPressed;
    notifyListeners();
  }
}
