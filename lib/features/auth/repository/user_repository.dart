import 'dart:developer' show log;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  Future<UserCredential?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    // Return the current user
    //or
    // Trigger the authentication flow
    final googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    //if sign in process is aborted
    //stop progress indicator
    if (googleAuth?.accessToken == null && googleAuth?.idToken == null) {
      return null;
    }
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    return userCredential;
  }

  Future<void> signOut() async {
    //sign out from firebase
    await FirebaseAuth.instance.signOut();
    //sign out from google
    await GoogleSignIn().signOut();
  }
}
