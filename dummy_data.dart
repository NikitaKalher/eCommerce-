import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';

import 'features/shop/models/banner_model.dart';

class TDummyData {

  // Banners
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: TImages.promoBanner3,
        targetScreen: TRoutes.order,
        active: false),
    BannerModel(imageUrl: TImages.promoBanner4,
        targetScreen: TRoutes.cart,
        active: true),
    BannerModel(imageUrl: TImages.promoBanner5,
        targetScreen: TRoutes.favourites,
        active: true),
    BannerModel(imageUrl: TImages.promoBanner1,
        targetScreen: TRoutes.search,
        active: true),
    BannerModel(imageUrl: TImages.promoBanner2,
        targetScreen: TRoutes.settings,
        active: true),
    BannerModel(imageUrl: TImages.promoBanner4,
        targetScreen: TRoutes.userAddress,
        active: true),
    BannerModel(imageUrl: TImages.promoBanner5,
        targetScreen: TRoutes.checkout,
        active: false),
  ];

  // list of all categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', name: 'Sports', image: TImages.sportIcon, isFeatured: true),
    CategoryModel(id: '5',
        name: 'Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true),
    CategoryModel(id: '2',
        name: 'Electronics',
        image: TImages.electronicsIcon,
        isFeatured: true),
    CategoryModel(
        id: '3', name: 'Cloths', image: TImages.clothsIcon, isFeatured: true),
    CategoryModel(
        id: '4', name: 'Animals', image: TImages.animalIcon, isFeatured: true),
    CategoryModel(
        id: '6', name: 'Shoes', image: TImages.shoeIcon, isFeatured: true),
    CategoryModel(id: '7',
        name: 'Cosmetics',
        image: TImages.cosemeticsIcon,
        isFeatured: true),
    CategoryModel(id: '14',
        name: 'Jewelery',
        image: TImages.jeweleryIcon,
        isFeatured: true),

    // subcategories
    CategoryModel(id: '8',
        name: 'Sport Shoes',
        image: TImages.shoesIcon,
        isFeatured: false,
        parentId: '1'),
    CategoryModel(id: '9',
        name: 'Track suits',
        image: TImages.clothIcon,
        isFeatured: false,
        parentId: '1'),
    CategoryModel(id: '10',
        name: 'Sports Equipments',
        image: TImages.sportIcon,
        isFeatured: false,
        parentId: '1'),

    // furniture
    CategoryModel(id: '11',
        name: 'Bedroom furniture',
        image: TImages.furnitureIcon,
        isFeatured: false,
        parentId: '5'),
    CategoryModel(id: '12',
        name: 'Kitchen furniture',
        image: TImages.furnitureIcon,
        isFeatured: false,
        parentId: '5'),
    CategoryModel(id: '13',
        name: 'Office furniture',
        image: TImages.furnitureIcon,
        isFeatured: false,
        parentId: '5'),

    // electronics
    CategoryModel(id: '14',
        name: 'Laptop',
        image: TImages.electronicsIcon,
        isFeatured: false,
        parentId: '2'),
    CategoryModel(id: '15',
        name: 'Mobile',
        image: TImages.electronicsIcon,
        isFeatured: false,
        parentId: '2'),

    CategoryModel(id: '16',
        name: 'Shirts',
        image: TImages.electronicsIcon,
        isFeatured: false,
        parentId: '3'),
  ];

  //--------List of products--------------
  static final List<ProductModel> products = [
    ProductModel(
        id: '001',
        stock: 15,
        price: 135,
        title: 'White Nike sports shoe',
        thumbnail: TImages.productImage,
        isFeatured: true,
        description: 'White Nike sports shoe',
        brand: BrandModel(id: '1', name: 'Nike', image: TImages.facebook, productsCount: 265, isFeatured: true),
        images: [TImages.productImage, TImages.productImage, TImages.productImage, TImages.productImage],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
          ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: TImages.productImage,
              description: 'This is a Product description for White Nike sports shoe',
              attributeValues: {'Color' : 'Black', 'Size': ' EU 32'},
          ),
          ProductVariationModel(
            id: '2',
            stock: 15,
            price: 132,
            image: TImages.productImage,
            attributeValues: {'Color' : 'Black', 'Size': ' EU 32'},
          ),
          ProductVariationModel(
            id: '3',
            stock: 0,
            price: 234,
            image: TImages.productImage,
            attributeValues: {'Color' : 'Black', 'Size': ' EU 34'},
          ),
          ProductVariationModel(
            id: '4',
            stock: 222,
            price: 232,
            image: TImages.productImage,
            attributeValues: {'Color' : 'Green', 'Size': ' EU 32'},
          ),
          ProductVariationModel(
            id: '5',
            stock: 0,
            price: 334,
            image: TImages.productImage,
            attributeValues: {'Color' : 'Red', 'Size': ' EU 34'},
          ),
          ProductVariationModel(
            id: '6',
            stock: 11,
            price: 332,
            image: TImages.productImage,
            attributeValues: {'Color' : 'Red', 'Size': ' EU 32'},
          )
        ],
        productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '002',
      stock: 15,
      price: 35,
      title: 'Blue T-shirt for all ages',
      thumbnail: TImages.productImage,
      isFeatured: true,
      description: 'This is a product description for Blue Nike sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', name: 'Zara', image: TImages.facebook),
      images: [TImages.productImage, TImages.productImage, TImages.productImage, TImages.productImage],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '003',
      stock: 15,
      price: 38000,
      title: 'Leather brown Jacket',
      thumbnail: TImages.productImage,
      isFeatured: false,
      description: 'This is a product description for Blue Nike sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', name: 'Zara', image: TImages.facebook),
      images: [TImages.productImage, TImages.productImage, TImages.productImage, TImages.productImage],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '004',
      stock: 15,
      price: 38000,
      title: '4 color collar t-shirt dry fit',
      thumbnail: TImages.productImage,
      isFeatured: false,
      description: 'This is a product description for Blue Nike sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', name: 'Zara', image: TImages.facebook),
      images: [TImages.productImage, TImages.productImage, TImages.productImage, TImages.productImage],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32']),
      ],
      productType: 'ProductType.single',
    ),

  ];
}