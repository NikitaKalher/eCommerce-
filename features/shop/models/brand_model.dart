import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  // Empty helper function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  // Convert model to JSON structure for Firebase storage
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  // Map JSON document to BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
    );
  }

  // Map Firestore document snapshot to BrandModel
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return BrandModel.empty();

    final data = document.data()!;
    return BrandModel(
      id: document.id, // Use document ID for the Brand ID
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
    );
  }
}
