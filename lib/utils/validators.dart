String? isValidPassword(String? password) {
  if (password == null || password.isEmpty) return 'Password is required';
  if (password.length < 8) return 'Password must have 8 or more characters';
  if (!password.contains(RegExp(r"[a-z]"))) {
    return 'Password must have special characters, numbers, lower and upper case letters';
  }
  if (!password.contains(RegExp(r"[A-Z]"))) {
    return 'Password must have special characters, numbers, lower and upper case letters';
  }
  if (!password.contains(RegExp(r"[0-9]"))) {
    return 'Password must have special characters, numbers, lower and upper case letters';
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must have special characters, numbers, lower and upper case letters';
  }
  return null;
}

String? isValidEmail(String? email) {
  if (email == null || email.isEmpty) return 'Email is required';
  int atIndex = email.indexOf('@');
  if (!email.contains('@') && email.split('@').length - 1 != 1) {
    return 'Invalid email';
  }
  if (!email.substring(atIndex).contains('.')) return 'Invalid email';
  return null;
}
