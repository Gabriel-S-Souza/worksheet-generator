import 'package:email_validator/email_validator.dart';

class LoginController {
  
  String email = '';

  String name = '';

  void setEmail(String value) => email = value;

  void setName(String value) => name = value;


  bool get isEmailValid => EmailValidator.validate(email);

  bool get isNameValid => name.isNotEmpty;

  bool get isFormValid => isEmailValid && isNameValid;

  bool loading = false;

  bool logged = false;

  Future<void> login() async {
    loading = true;
    await Future.delayed(const Duration(seconds: 2));
    loading = false;
    logged = true;
  }
}