import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Format {
  static final MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
  );

  static final regex = new RegExp(r'^(\+7)(\s\(\d{3}\)\s)(\d{3}-\d{2}-\d{2}$)');

  static bool isValidPhoneNumber(String? number) {
    if (number == null) {
      return false;
    }
    return regex.hasMatch(number);
  }

  static final MaskTextInputFormatter numberFormatter3 = MaskTextInputFormatter(
    mask: '###',
  );

  static final MaskTextInputFormatter numberFormatter2 = MaskTextInputFormatter(
    mask: '##',
  );
}
