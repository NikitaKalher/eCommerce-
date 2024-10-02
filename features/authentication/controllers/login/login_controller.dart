import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/personalization/controller/user_controller.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../navigation_menu.dart';
import '../../../controllers/network_manager.dart';


class LoginController extends GetxController {
  // variables
  final rememberMe = false.obs; // obs is the Getx feature to redraw state on the design .
  // here we are using statelessWidget so we use obs,
  // otherwise if we use statefulWidget we need to use setState method ,, setState redraw the complete screen, obs only redraw specific widget
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  // --------Email and password signIn-----
  Future<void> emailAndPasswordSignIn() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog('Logging you in ...', TImages.animation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection and try again.');
        return;
      }

      // Validate the form
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading(); // Stop the loader if validation fails
        return;
      }

      // save data if Remember Me is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authentication
      try {
        if (kDebugMode) {
          print('Attempting login...');
        }
        final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
        if (kDebugMode) {
          print('Login successful: ${userCredentials.user}');
        }

        // remove loader
        TFullScreenLoader.stopLoading();

        // Navigate to HomeScreen after successful login
        Get.offAll(() => const NavigationMenu());

      } catch (e) {
        if (kDebugMode) {
          print('Login failed: ${e.toString()}');
        }
        TLoaders.errorSnackBar(title: 'Login Failed', message: e.toString());
      }



    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //-------------Google SignIn Authentication----------
  Future<void> googleSignIn() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog('Logging you in ...', TImages.animation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Google authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // save user record
      await userController.saveUserRecord(userCredentials);

      // remove loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
