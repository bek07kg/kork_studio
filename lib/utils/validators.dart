class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Это поле необходимо заполнить";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Введите корректный адрес электронной почты';
    }
    return null;
  }
}
