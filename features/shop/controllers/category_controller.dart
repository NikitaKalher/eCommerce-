import 'package:ecommerce/common/widgets/loaders/loaders.dart';
import 'package:ecommerce/data/repositories/categories/category_repository.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // load category data
  Future<void> fetchCategories() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // Fetch categories from dataSource (FireStore, API,etc.)
      final categories = await _categoryRepository.getAllCategories();

        // update the categories list
        allCategories.assignAll(categories);

        // Filter featured categories
        featuredCategories.assignAll(
          allCategories
              .where((category) => category.isFeatured && category.parentId.isEmpty)
              .take(8)
              .toList(),
        );
    } catch (e) {
      // Handle and display error
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      // Hide loader
      isLoading.value = false;
    }
  }
}
