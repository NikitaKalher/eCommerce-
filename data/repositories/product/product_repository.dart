import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/firebase_storage_service.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/constants/enums.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;

  // Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try{
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

    }  on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch(e) {
      throw e.message!;
    } catch(e) {
      throw 'Something went wrong. Please try again';
    }
  }


  // upload dummy data to the cloud firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // upload all the products along with their images
      final storage = Get.put(TFirebaseStorageService());

      // loop through each product
      for(var product in products) {
        // get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        // upload image and get its url
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        // assign url to product.thumbnail attribute
        product.thumbnail = url;

        // Product list of images
        if(product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for(var image in product.images!) {
            // get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // upload image and get its url
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            // Assign URL to product.thumbnail attribute
            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }

        // upload variation images
        if(product.productType == ProductType.variable.toString()) {
          for(var variation in product.productVariations!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            // upload image and get it's url
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);

            // assign url to variation.image attribute
            variation.image = url;
          }
        }

        // store product in Firestore
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch(e) {
      throw e.message!;
    } on PlatformException catch(e) {
      throw e.message!;
    } catch(e) {
      throw e.toString();
    }
  }
}