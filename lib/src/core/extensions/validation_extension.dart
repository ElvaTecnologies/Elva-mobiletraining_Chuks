import 'package:flutter/cupertino.dart';

extension ValidationExtension on BuildContext {
  String? validateEmail(String? value) {
    if (value == null) return 'Email cannot be empty';

    if (value.isEmpty) return 'Email cannot be empty';

    bool emailIsValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~]+@[a-zA-Z]+")
            .hasMatch(value);

    return !emailIsValid ? 'hint: email must have "@" and "."' : null;
  }

  String? validatePassword(String? value) => value == null || value.length < 6
      ? 'Password must have 6 or more characters'
      : null;
}
