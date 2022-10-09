import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      //if sign in process is aborted
      //stop progress indicator
      if (googleAuth?.accessToken == null && googleAuth?.idToken == null) {
        throw Exception(
          'Interactive sign in process was canceled by the user.',
        );
      }
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
    } on PlatformException catch (e) {
      switch (e.code) {
        case GoogleSignIn.kNetworkError:
          throw throw Exception(
            'A network error (such as timeout,interrupted connection or unreachable host) has occurred.',
          );
        case GoogleSignIn.kSignInCanceledError:
          throw throw Exception(
            'Interactive sign in process was canceled by the user.',
          );
        case GoogleSignIn.kSignInFailedError:
          throw throw Exception('Attempt to sign in failed.');
        case GoogleSignIn.kSignInRequiredError:
          throw throw Exception(
            'No signed in user and interactive sign in flow is required',
          );
        default:
          throw throw Exception('Unkown error.');
      }
    }
  }

  Future<void> signOut() async {
    //sign out from firebase
    await FirebaseAuth.instance.signOut();
    //sign out from google
    await GoogleSignIn().signOut();
  }
}
