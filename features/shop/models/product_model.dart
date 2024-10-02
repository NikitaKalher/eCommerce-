import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? data;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    this.data,
    this.salePrice = 0.0,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    required this.productType,
    this.productAttributes,
    this.productVariations,
  });

  // Create an empty product model
  static ProductModel empty() => ProductModel(
    id: '',
    stock: 0,
    price: 0.0,
    title: '',
    thumbnail: '',
    productType: '',
  );

  // Convert model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand?.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  // Map Firestore document snapshot to ProductModel
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();

    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      title: data['Title'],
      isFeatured: data['IsFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>?)
          ?.map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>?)
          ?.map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  // Map QuerySnapshot from Firebase to ProductModel
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      title: data['Title'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>?)
          ?.map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>?)
          ?.map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
