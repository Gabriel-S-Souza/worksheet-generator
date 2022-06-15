import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthApi {

  final GoogleSignIn googleSignin = GoogleSignIn(
    scopes: ['https://mail.google.com/'],
  );

  GoogleSignInAccount? currentUser;

  Future<GoogleSignInAccount?> googleLogin() async {

    if (await googleSignin.isSignedIn()) {
      log('User is already signed in');
      log(googleSignin.currentUser.toString());
      currentUser = googleSignin.currentUser;
      return currentUser;
    }

    try {
      final googleUser = await googleSignin.signIn();
      if (googleUser == null) {
        log('google user is null');
        return null;
      }

      log(googleUser.toString());

      currentUser = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      
      return googleUser;

    } catch (e) {
      log(e.toString());
      return null;
    }
    
  }

  Future<GoogleSignInAccount?> signInSilently() async {
     try {
      final googleUser = await googleSignin.signInSilently();
      if (googleUser == null) {
        log('google user is null');
        return null;
      }

      log(googleUser.toString());

      currentUser = googleUser;
      
      return googleUser;

    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    await googleSignin.signOut();
    await FirebaseAuth.instance.signOut();
  }
}