class Validator {
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return "TextFields cannot be empty";
    }
    return null;
  }

  static String? validateUserId({required String uid, required String value}) {
    if (uid.isEmpty) {
      return "User Id cannot be empty";
    } else if (uid.length <= 5) {
      return "user ID should be greater than 5 characters";
    }
    return null;
  }
}
