import 'package:ecommerce/common/widgets/loaders/loaders.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/personalization/screens/widgets/re_authenticate_user_login_form.dart';
import 'package:ecommerce/features/shop/models/user_model.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/network_manager.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;  //when there is change in data obs redraw the design

  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch user record
  Future<void> fetchUserRecord() async {
    try{
      profileLoading.value= true;
      final user = await userRepository.fetchUserDetails();
      this.user(user); // this.user means user that is used on top
    } catch(e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // save user record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try{
      // first update Rx and then check if user data is already stored. if not store new data
      await fetchUserRecord();

      // if no record already stored.
      if(user.value.id.isEmpty) {
        if(userCredentials != null) {
          // convert name to first and last name
          final nameParts = UserModel.nameParts(
              userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch(e) {
      TLoaders.warningSnackBar(
          title: 'Data not Saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile.'
      );
    }
  }

  // Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(), // to close the popup
        child: const Text('Cancel'),
      ),
    );
  }

  // Delete user account
  void deleteUserAccount() async {
    try{
      TFullScreenLoader.openLoadingDialog('Processing', TImages.animation);

      // First re-authenticate user
      final auth= AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        // re verify auth email
        if(provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //-------Re-Authenticate before deleting--------
  Future<void> reAuthenticateEmailAndPasswordUser() async {
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
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading(); // Stop the loader if validation fails
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }

  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;

        // Upload image and get the URL
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update user profile picture in Firestore
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        // Update the user object and refresh the UI
        user.update((val) {
          val?.profilePicture = imageUrl;
        });

        TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been updated!',
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }

}