import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/shop/models/user_model.dart';

// Repository class for user-related operations
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Functions to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      // Specific error handling for Firestore exceptions
      print('FirebaseException in saveUserRecord: ${e.message}');
      throw 'Failed to save user record: ${e.message}';
    } on FormatException catch (e) {
      // Handling for FormatException
      print('FormatException in saveUserRecord: $e');
      throw 'Data format error: ${e.message}';
    } on PlatformException catch (e) {
      // Handling for PlatformException
      print('PlatformException in saveUserRecord: ${e.message}');
      throw 'Platform error: ${e.message}';
    } catch (e) {
      // Generic error handling
      print('Unexpected error in saveUserRecord: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch user details based on user Id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists) {
        return UserModel.fromSnapShot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      // Specific error handling for Firestore exceptions
      print('FirebaseException in saveUserRecord: ${e.message}');
      throw 'Failed to save user record: ${e.message}';
    } on FormatException catch (e) {
      // Handling for FormatException
      print('FormatException in saveUserRecord: $e');
      throw 'Data format error: ${e.message}';
    } on PlatformException catch (e) {
      // Handling for PlatformException
      print('PlatformException in saveUserRecord: ${e.message}');
      throw 'Platform error: ${e.message}';
    } catch (e) {
      // Generic error handling
      print('Unexpected error in saveUserRecord: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to update user data in firebase
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      // Specific error handling for Firestore exceptions
      print('FirebaseException in saveUserRecord: ${e.message}');
      throw 'Failed to save user record: ${e.message}';
    } on FormatException catch (e) {
      // Handling for FormatException
      print('FormatException in saveUserRecord: $e');
      throw 'Data format error: ${e.message}';
    } on PlatformException catch (e) {
      // Handling for PlatformException
      print('PlatformException in saveUserRecord: ${e.message}');
      throw 'Platform error: ${e.message}';
    } catch (e) {
      // Generic error handling
      print('Unexpected error in saveUserRecord: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      // Retrieve the user ID from the authentication repository
      final userId = AuthenticationRepository.instance.authUser?.uid;

      // Check if the user ID is null
      if (userId == null) {
        print('No authenticated user found.');
        throw 'No authenticated user found.';
      }

      // Perform the update operation
      await _db.collection("Users").doc(userId).update(json);

    } on FirebaseException catch (e) {
      // Specific error handling for Firestore exceptions
      print('FirebaseException in updateSingleField: ${e.message}');
      throw 'Failed to update user record: ${e.message}';
    } on FormatException catch (e) {
      // Handling for FormatException
      print('FormatException in updateSingleField: $e');
      throw 'Data format error: ${e.message}';
    } on PlatformException catch (e) {
      // Handling for PlatformException
      print('PlatformException in updateSingleField: ${e.message}');
      throw 'Platform error: ${e.message}';
    } catch (e) {
      // Generic error handling
      print('Unexpected error in updateSingleField: $e');
      throw 'Something went wrong. Please try again';
    }
  }


  // Function to remove user data from Firebase
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      // Specific error handling for Firestore exceptions
      print('FirebaseException in saveUserRecord: ${e.message}');
      throw 'Failed to save user record: ${e.message}';
    } on FormatException catch (e) {
      // Handling for FormatException
      print('FormatException in saveUserRecord: $e');
      throw 'Data format error: ${e.message}';
    } on PlatformException catch (e) {
      // Handling for PlatformException
      print('PlatformException in saveUserRecord: ${e.message}');
      throw 'Platform error: ${e.message}';
    } catch (e) {
      // Generic error handling
      print('Unexpected error in saveUserRecord: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  // upload any image
  Future<String> uploadImage(String path, XFile image) async { // XFile is used to receive image
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name); //on this location we have to add the image
      await ref.putFile(File(image.path)); // get image from image.path amd convert it into file, this is going to store this in ref
      final url = await ref.getDownloadURL(); // get url and store in firebase
      return url;

    } on FirebaseException catch (e) {
      // Specific error handling for Firestore exceptions
      print('FirebaseException in saveUserRecord: ${e.message}');
      throw 'Failed to save user record: ${e.message}';
    } on FormatException catch (e) {
      // Handling for FormatException
      print('FormatException in saveUserRecord: $e');
      throw 'Data format error: ${e.message}';
    } on PlatformException catch (e) {
      // Handling for PlatformException
      print('PlatformException in saveUserRecord: ${e.message}');
      throw 'Platform error: ${e.message}';
    } catch (e) {
      // Generic error handling
      print('Unexpected error in saveUserRecord: $e');
      throw 'Something went wrong. Please try again';
    }
  }

}
