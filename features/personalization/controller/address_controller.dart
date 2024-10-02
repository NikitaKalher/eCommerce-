import 'package:ecommerce/common/widgets/loaders/loaders.dart';
import 'package:ecommerce/data/repositories/address/address_repository.dart';
import 'package:ecommerce/features/address/models/address_model.dart';
import 'package:ecommerce/features/controllers/network_manager.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  // assign the selected address
  final Rx<AddressModel> selectedAddress = AddressModel
      .empty()
      .obs;
  final addressRepository = Get.put(AddressRepository());

  // Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value =
          addresses.firstWhere((element) => element.selectedAddress,
              orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {

      /* Get.defaultDialog(
        title: '',
        onWillPop: () async {return false;},
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const TCircularLoader(),
      );*/
      //clear the "selected" field, before assign new address we have to first delete the already assigned address
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  // Add new Address
  Future addNewAddresses() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          ('Storing address'), TImages.animation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      // update selected address status
      address.id = id;
      await selectedAddress(address);

      // rremove lpoader
      TFullScreenLoader.stopLoading();

      // show success message
      TLoaders.successSnackBar(title: 'Congratualtions', message: 'Your addrerss has been saved successfully.');

      // refresh address data
      refreshData.toggle();

      // reset fields
      resetFormFields();

      // redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Address not found.', message: e.toString());
    }
  }

  // Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}  