import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:formulario_de_atendimento/services/google_auth_api.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/data_access_object.dart';

class LoginController {

  late final GoogleAuthApi _googleAuthApi = GetIt.I.get<GoogleAuthApi>();

  // final GoogleSignIn googleSignin = GoogleSignIn();

  // GoogleSignInAccount? currentUser;
  
  String email = '';

  String name = '';

  void setEmail(String value) => email = value;

  void setName(String value) => name = value;


  bool get isEmailValid => EmailValidator.validate(email);

  bool get isNameValid => name.isNotEmpty;

  bool get isFormValid => isEmailValid && isNameValid;

  // Future<void> login() async {
  //   Box<dynamic> userDataBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.userData);
  //   await userDataBox.put('email', email);
  //   await userDataBox.put('name', name);
  //   log(userDataBox.get('email'));
  //   log(userDataBox.get('name'));
  // }

  Future googleLogin() async {

    await _googleAuthApi.googleLogin();

    Box<dynamic> userDataBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.userData);
    await userDataBox.put('email', email);
    await userDataBox.put('name', name);
    log(userDataBox.get('email'));
    log(userDataBox.get('name'));
    
  }

  Future<void> logout() async {
    await _googleAuthApi.logout();
  }
}