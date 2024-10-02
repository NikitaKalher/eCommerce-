import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/personalization/controller/user_controller.dart';
import 'package:ecommerce/features/shop/screens/profile/Widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/loaders.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/popups/full_screen_loader.dart';
import 'network_manager.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in ...', TImages.animation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(title: 'No Internet',
            message: 'Please check your internet connection and try again.');
        return;
      }

      // Validate the form
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading(); // Stop the loader if validation fails
        return;
      }

      // create json which we want to update
      // update the user firstName and lastName in the firebase firestore
      Map<String, dynamic> name = { // Map<String, dynamic> used to create json , name json
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      // update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your name has been updated.');

      // move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


}