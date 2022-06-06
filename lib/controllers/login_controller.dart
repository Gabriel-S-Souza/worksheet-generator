import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/data_access_object.dart';
import '../main.dart';

class LoginController {
  
  String email = '';

  String name = '';

  void setEmail(String value) => email = value;

  void setName(String value) => name = value;


  bool get isEmailValid => EmailValidator.validate(email);

  bool get isNameValid => name.isNotEmpty;

  bool get isFormValid => isEmailValid && isNameValid;

  Future<void> login() async {
    Box<dynamic> userDataBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.userData);
    await userDataBox.put('email', email);
    await userDataBox.put('name', name);
    log(userDataBox.get('email'));
    log(userDataBox.get('name'));
  }
}