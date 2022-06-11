import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  // sign in with google:
  static Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: GoogleSignInAuthentication.accesstToken,
      idToken: googleAuth.idToken,
    );
    final User? user = await FirebaseAuth.instance.signInWithCredential(credential);
}