class ValidatorsApp {
  ValidatorsApp._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp _usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_.]{2,19}$');

  static final RegExp _fullNameRegex = RegExp(r'^[A-Za-z]+( [A-Za-z]+)+$');

  static final RegExp _phoneRegex = RegExp(r'^\d{11}$');

  static String? validateEmail(String? val) {
    final value = val?.trim() ?? '';
    if (value.isEmpty) return "This field is required";
    if (!_emailRegex.hasMatch(value)) return "Enter valid email";
    return null;
  }

  static String? validatePassword(String? val) {
    final value = val?.trim() ?? '';
    if (value.isEmpty) return "This field is required";
    if (!_passwordRegex.hasMatch(value)) return "Enter valid password";
    return null;
  }

  static String? validateConfirmPassword(String? val, String? password) {
    final value = val?.trim() ?? '';
    if (value.isEmpty) return "This field is required";
    if (value != password) return "Passwords do not match";
    return null;
  }

  static String? validateUserName(String? val) {
    final value = val?.trim() ?? '';
    if (value.isEmpty) return "This field is required";
    if (!_usernameRegex.hasMatch(value)) return "Enter valid username";
    return null;
  }

  static String? validateFullName(String? val) {
    final value = val?.trim() ?? '';
    if (value.isEmpty) return "This field is required";
    if (!_fullNameRegex.hasMatch(value)) return "Enter valid full name";
    return null;
  }

  static String? validatePhoneNumber(String? val) {
    final value = val?.trim() ?? '';
    if (value.isEmpty) return "This field is required";
    if (!_phoneRegex.hasMatch(value)) return "Enter valid phone number";
    return null;
  }
}
