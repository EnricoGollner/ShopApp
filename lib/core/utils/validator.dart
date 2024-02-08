class Validator {
  static String? isRequired(String? text) {
    if (text == null || text.isEmpty) {
      return 'Required Field';
    }
    
    return null;
  }

  static String? isRequiredAndMinLength({required String? text, int minLength = 10}) {
    if (text == null || text.isEmpty) {
      return 'Required Field';
    } else if (text.length < minLength) {
      return 'Minimum length of $minLength characters';
    }
    
    return null;
  }

  static String? isValidImageUrl(String? urlText) {
    String? message = isRequired(urlText);
    if (message != null) {
      return message;
    }

    bool isValidUrl = Uri.tryParse(urlText!)?.hasAbsolutePath ?? false;
    bool endsWithFileExtension = urlText.toLowerCase().endsWith('.png') || urlText.toLowerCase().endsWith('.jpg') || urlText.toLowerCase().endsWith('.jpeg');

    if (isValidUrl && endsWithFileExtension) {
      return null;
    } else {
      return 'Invalid URL';
    }
  }
}