import 'package:ecommerce/data/repositories/banners/banner_repository.dart';
import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
/*
class BannerController extends GetxController {

  // Variables
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs; // this list get all the banners and these banners can be reuse

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }


  // update page navigational dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  // fetch banners
  Future<void> fetchBanners() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // fetch banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // assign banners
      this.banners.assignAll(banners);

    } catch (e) {
      // Handle and display error
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      // Hide loader
      isLoading.value = false;
    }
  }

}*/

class BannerController extends GetxController {

  // Variables
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs; // this list gets all the banners and these banners can be reused

  final BannerRepository bannerRepo;

  // Constructor to inject the repository dependency
  BannerController(this.bannerRepo);

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  // Update page navigational dots
  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  // Fetch banners
  Future<void> fetchBanners() async {
    try {
      // Show loader while loading banners
      isLoading.value = true;

      // Clear previous banners if necessary (optional, depends on logic)
      banners.clear();

      // Fetch banners from the repository
      final fetchedBanners = await bannerRepo.fetchBanners();

      // Assign fetched banners to the observable list
      if (fetchedBanners.isNotEmpty) {
        banners.assignAll(fetchedBanners);
      } else {
        print("No banners were fetched from the server.");
      }

    } catch (e) {
      // Handle and display error, possibly show the full stack trace
      print('Error fetching banners: $e');
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      // Hide loader
      isLoading.value = false;
    }
  }

}
