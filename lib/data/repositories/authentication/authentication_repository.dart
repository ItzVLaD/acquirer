import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Class with repository of Authentication
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final _auth = FirebaseAuth.instance;

  /// Get Authenticated User Date
  User? get authUser => _auth.currentUser;

  /// Called on main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
  }

  /// Function to login with Google
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
    final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    return await _auth.signInWithCredential(credentials);
  }

  /// Function to logout
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
