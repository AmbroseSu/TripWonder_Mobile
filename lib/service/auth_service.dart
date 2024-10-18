import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Future<UserCredential?> loginWithGoogle() async {
  //   try {
  //     final googleUser = await GoogleSignIn().signIn();
  //
  //     final googleAuth = await googleUser?.authentication;
  //
  //     final cred = GoogleAuthProvider.credential(
  //         idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
  //
  //     return await _auth.signInWithCredential(cred);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // Sign in with Google
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the authentication details from Google
      final googleAuth = await googleUser.authentication;

      // Create a credential using the GoogleAuthProvider
      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Sign in to Firebase with the generated credential
      final userCredential = await _auth.signInWithCredential(cred);

      // Return the user credential which contains the user information
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
