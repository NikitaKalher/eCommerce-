import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  //Empty helper function
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeatured: false);

  // convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name' : name,
      'Image' : image,
      'ParentId' : parentId,
      'IsFeatured' : isFeatured,
    };
  }

  // to receive this values
// Map Json oriented document snapshot from Firebase to UserModel
  // to create multiple constructor we use 'factory' method
  // .fromSnapshot used to create different names for the same class constructor
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    if (data != null) {
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '', // Handle potential null values
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] is bool ? data['IsFeatured'] : false,  // Ensure the type is boolean
      );
    } else {
      return CategoryModel.empty();
    }
  }
}