import 'dart:developer' show log;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  User? get currentUser => FirebaseAuth.instance.currentUser;
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    // Attempt to get the currently authenticated user
    GoogleSignInAccount? googleUser = googleSignIn.currentUser;

    // Attempt to sign in without user interaction
    googleUser ??= await googleSignIn.signInSilently();

    // Trigger the authentication flow
    googleUser ??= await googleSignIn.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    //sign out from firebase
    await FirebaseAuth.instance.signOut();
    //sign out from google
    await GoogleSignIn().signOut();
  }
}
