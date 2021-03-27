class Utils {
  static String? isEmail(String? email) {
    if (email == null) return null;
    final regEx = RegExp("^[a-zA-Z0-9.a-zA-Z0-9"
        r".!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regEx.hasMatch(email) ? null : 'Invalid email';
  }

  static String? isNotEmpty(String? value) {
    return value!.isNotEmpty ? null : "This is required";
  }
}
