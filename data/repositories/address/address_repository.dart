import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/address/models/address_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../features/personalization/controller/address_controller.dart';

class AddressRepository extends GetxController {
  static AddressController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // to return list of address model
  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();

    } catch(e){
      throw 'Something went wrong while fetching Address Information. Try again later';
    }
  }

  // clear the selected field for all address
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress' : selected}); // {} means that is the json function
    } catch(e){
      throw 'Unable to update your address. Try again later';
    }
  }

  // Store new user order
  Future<String> addAddress(AddressModel address) async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    } catch(e){
      throw 'Something went wrong while saving Address Information. Try again later';
    }
  }
} 