import 'package:ecommerce/common/widgets/loaders/loaders.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product/product_repository.dart';
import '../../../utils/constants/enums.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    featchFeaturedProducts();
    super.onInit();
  }

  void featchFeaturedProducts() async {
    try{
      // show loader while loading
      isLoading.value = true;

      // fetch products
      final products = await productRepository.getFeaturedProducts();

      // assign products
      featuredProducts.assignAll(products);

    } catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // get the produtc price or price range for variations.
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // if no variations exist, return the simple price or sale price
    if(product.productType == ProductType.single.toString()){
      return (product.salePrice > 0 ? product.salePrice : product.price).toString();
    } else {
      // calculate the smallest and largest prices among variations
      for(var variation in product.productVariations!){
        // determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //update smallest and largest price
        if(priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if(priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // if smallest and largest prices are the same, return a single price
      if(smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // otherwise return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  // calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if(salePrice == null || salePrice <= 0.0) return null;
    if(originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of stock';

  }
}