class Utils {
  static String? isEmail(String? email) {
    return email!.contains('@') ? null : 'Invalid email';
  }

  static String? isNotEmpty(String? value) {
    return value!.isNotEmpty ? null : "This is required";
  }
}
