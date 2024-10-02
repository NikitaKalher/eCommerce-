import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // variables
  final _db = FirebaseFirestore.instance;

  // get all banners
  Future<List<BannerModel>> fetchBanners() async {
    try {
      // Fetch banners where 'Active' field is true
      final result = await _db.collection('Banners')
          .where('Active', isEqualTo: true)
          .get();

      // Log the number of banners fetched for debugging
      print("Fetched ${result.docs.length} banners from Firestore.");

      // Convert documents to BannerModel objects
      return result.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();

    } catch (e) {
      // Log the actual error
      print("Error fetching banners: $e");
      throw 'Something went wrong while fetching banners: $e';
    }
  }
}
