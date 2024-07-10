class FormValidation {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name field cannot be empty";
    }
    if (value.contains('@') || value.contains('.com')) {
      return "Name cannot contain words like these";
    }
    return null;
  }

  static String? validateExpanseName(String? value) {
    if (value == null || value.isEmpty) {
      return "Expanse title cannot be empty";
    }
    if (value.contains('@') || value.contains('.com')) {
      return "Expanse title cannot contain letters like these";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email field cannot be empty";
    }
    if (!value.contains('@') || !value.contains('.com')) {
      return "Invalid email address";
    }
    return null;
  }

  static String? validateamount(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter your amount";
    }
    // if (value.length != 11) {
    //   return "Phone number length must be 11";
    // }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number cannot be empty";
    }
    // if (value.length != 11) {
    //   return "Phone number length must be 11";
    // }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password field cannot be empty";
    }
    if (value.length <= 8) {
      return "Password length must be greater than 8";
    }
    return null;
  }
}
