import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/data_access_object.dart';

class LoginController {

  final GoogleSignIn googleSignin = GoogleSignIn();

  GoogleSignInAccount? currentUser;
  
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

    Box<dynamic> userDataBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.userData);
    await userDataBox.put('email', email);
    await userDataBox.put('name', name);
    log(userDataBox.get('email'));
    log(userDataBox.get('name'));

    try {
      final googleUser = await googleSignin.signIn();
    if (googleUser == null) {
      return;
    }
    currentUser = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
    }
    
  }

  Future<void> logout() async {
    await googleSignin.signOut();
    await FirebaseAuth.instance.signOut();
  }
}