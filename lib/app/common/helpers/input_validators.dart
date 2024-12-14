class InputValidators {
  static String? notEmpty(String? value, [bool optional = false]) {
    if (optional && (value == null || value.trim().isEmpty)) {
      return null;
    }
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? notNull<T>(T? value) {
    if (value == null) {
      return 'This field is required';
    }
    return null;
  }

  static String? password(String? value, [bool optional = false]) {
    if (optional && (value == null || value.trim().isEmpty)) {
      return null;
    }
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? minLength(String? value, int length, [bool optional = false]) {
    if (optional && (value == null || value.trim().isEmpty)) {
      return null;
    }
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.length < length) {
      return 'This field must be at least $length characters long';
    }
    return null;
  }

  static String? email(String? value, [bool optional = false]) {
    if (optional && (value == null || value.trim().isEmpty)) {
      return null;
    }
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }
}
