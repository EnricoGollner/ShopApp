class Validator {
  static String? isRequired(String? text) {
    if (text == null || text.isEmpty) {
      return 'Required Field';
    }

    return null;
  }

  static String? isEmail(String? text) {
    String? message = isRequired(text);

    if (message != null) {
      return message;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text!)) {
      return 'E-mail format invalid!';
    }

    return null;
  }

  static String? confirmPassword({required String password, required String? confirmPassword}) {
    String? message = isRequired(confirmPassword);

    if (message != null) {
      return message;
    } else if (password != confirmPassword) {
      return 'Passwords needs to be equal.';
    }

    return null;
  }

  static String? isRequiredAndMinLength(
      {required String? text, int minLength = 10}) {
    if (text == null || text.isEmpty) {
      return 'Required Field';
    } else if (text.length < minLength) {
      return 'Minimum length of $minLength characters';
    }

    return null;
  }

  static String? isValidUrlImage(String? urlText) {
    String? message = isRequired(urlText);
    if (message != null) {
      return message;
    }

    bool isValidUrl = Uri.tryParse(urlText!)?.hasAbsolutePath ?? false;
    bool endsWithFileExtension = urlText.toLowerCase().endsWith('.png') ||
        urlText.toLowerCase().endsWith('.jpg') ||
        urlText.toLowerCase().endsWith('.jpeg');

    if (isValidUrl && endsWithFileExtension) {
      return null;
    } else {
      return 'Invalid URL';
    }
  }
}
