import 'dart:typed_data'; // Correct import for Uint8List
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  // upload local Assets from IDE
  // Returns a Unit8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async{
    try{
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch(e) {
      // handle exceptions gracefully
      throw 'Error loading image data : $e';
    }
  }

  //upload image using ImageData on cloud Firebase Storage
// returns the download URL of the uploaded image.
  Future<String> uploadImageData(String path, Uint8List image, String name) async {
    try{
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch(e){
      // handle exceptions gracefully
      throw 'Error loading image data : $e';
    }
  }
}