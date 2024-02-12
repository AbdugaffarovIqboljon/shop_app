import 'package:flutter/services.dart';

/// #For Payment Screen
class CardNumberFormatter extends TextInputFormatter {
  String formatCardNumber(String input) {
    String cleanedInput = input.replaceAll(' ', '');

    /// #Regex to add spaces to every 4 characters
    String formattedInput = cleanedInput.replaceAllMapped(
      RegExp(r'.{4}'),
      (match) => '${match.group(0)} ',
    );

    return formattedInput.trim();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatCardNumber(newValue.text);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String removeBrackets(String? input) {
  if (input != null) {
    return input.replaceAll(RegExp(r'[()\[\]]'), '');
  }
  return '';
}


