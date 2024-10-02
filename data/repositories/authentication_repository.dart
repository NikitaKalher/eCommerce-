import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  // Provides a singleton instance of this controller
  static AuthenticationRepository get instance => Get.find();

  // Local storage instance from GetStorage
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // get Authenticated User data
  User? get authUser => _auth.currentUser;

  // This method is automatically called when the controller is ready
  @override
  void onReady() {
    // Removes the native splash screen after the app is ready
    FlutterNativeSplash.remove();

    // Determines which screen to show based on storage data
    screenRedirect();
  }

  // Function to show relevant screen
  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      // Local storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())  // Redirect to login screen if not the first time
          : Get.offAll(() => const OnBoardingScreen());  // Redirect to OnBoarding screen if it's the first time
    }
  }

  //---------------- Federated identity & social sign-in - Google-------------------------------
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //Create a new credentials
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in signInWithGoogle: ${e.message}');
      throw 'Google sign-in failed: ${e.message}';
    } catch (e) {
      print('Unexpected error in signInWithGoogle: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  //------------------------------- Email & Password sign-in - Login----------------------------------
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in loginWithEmailAndPassword: ${e.message}');
      throw 'Login failed: ${e.message}';
    } catch (e) {
      print('Unexpected error in loginWithEmailAndPassword: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  // -----------------------------Email & Password sign-up - Register------------------------------------
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in registerWithEmailAndPassword: ${e.message}');
      throw 'Registration failed: ${e.message}';
    } catch (e) {
      print('Unexpected error in registerWithEmailAndPassword: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  //------------------------------ Email verification - Send verification email-----------------------
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in sendEmailVerification: ${e.message}');
      throw 'Failed to send verification email: ${e.message}';
    } catch (e) {
      print('Unexpected error in sendEmailVerification: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  //-------------------------[Email Authentication] - FORGET PASSWORD------------------------
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in sendEmailVerification: ${e.message}');
      throw 'Failed to send verification email: ${e.message}';
    } catch (e) {
      print('Unexpected error in sendEmailVerification: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  //------------------------[ReAuthenticate] - RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in sendEmailVerification: ${e.message}');
      throw 'Failed to send verification email: ${e.message}';
    } catch (e) {
      print('Unexpected error in sendEmailVerification: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  //---------------------------------- Log out user - Valid for any authentication----------------------------------
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in logout: ${e.message}');
      throw 'Logout failed: ${e.message}';
    } catch (e) {
      print('Unexpected error in logout: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete user - remove user auth and firestore account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in logout: ${e.message}');
      throw 'Logout failed: ${e.message}';
    } catch (e) {
      print('Unexpected error in logout: $e');
      throw 'Something went wrong. Please try again';
    }
  }
}
