abstract class AppValidators {
  static String? combine(List<String?> validators) {
    return validators.firstWhere((error) => error != null, orElse: () => null);
  }

  static String? isValidUrl(String? value) {
    final validUrl = Uri.tryParse(value ?? '')?.isAbsolute ?? false;
    if (value == null || validUrl == false) {
      return 'Entered text is not a valid link';
    }
    return null;
  }
}
