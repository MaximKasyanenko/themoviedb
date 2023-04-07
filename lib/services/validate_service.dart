class ValidateService {
  static bool isValidateLogin(String login) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9._-]{3,25}$');
    return regex.hasMatch(login);
  }

  static bool isPasswordValid(String password) {
    // Пароль должен содержать минимум 8 символов
    if (password.length < 8) {
      return false;
    }
    // Пароль должен содержать хотя бы одну цифру
    RegExp digitRegex = RegExp(r'\d');
    if (!digitRegex.hasMatch(password)) {
      return false;
    }
    // Пароль должен содержать хотя бы одну букву в верхнем регистре
    // RegExp upperCaseRegex = RegExp(r'[A-Z]');
    // if (!upperCaseRegex.hasMatch(password)) {
    //   return false;
    // }

    // Пароль должен содержать хотя бы одну букву в нижнем регистре
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    if (!lowerCaseRegex.hasMatch(password)) {
      return false;
    }
    // // Пароль должен содержать хотя бы один специальный символ
    // RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    // if (!specialCharRegex.hasMatch(password)) {
    //   return false;
    // }
    return true;
  }
}
