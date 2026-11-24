import 'product.dart';
import 'category.dart';

class HomePageData {
  final List<CategoryModel> categories;
  final Map<String, dynamic> heroBanner;
  final List<Product> featureProducts;
  final Map<String, dynamic> newCollection;
  final List<Product> recommended;
  final List<Map<String, dynamic>> topCollections;
  final List<Map<String, dynamic>> categoryPromos;
  final Map<String, dynamic> productPageData;
  final String storeName;

  const HomePageData({
    required this.categories,
    required this.heroBanner,
    required this.featureProducts,
    required this.newCollection,
    required this.recommended,
    required this.topCollections,
    required this.categoryPromos,
    required this.productPageData,
    this.storeName = 'GemStore',
  });

  factory HomePageData.fromJson(Map<String, dynamic> json) {
    final root = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    final homePage = (root['homePage'] ?? root['home'] ?? root['feed']) is Map
        ? Map<String, dynamic>.from((root['homePage'] ?? root['home'] ?? root['feed']) as Map)
        : root;
    final productPage = (root['productPage'] ?? root['details']) is Map
        ? Map<String, dynamic>.from((root['productPage'] ?? root['details']) as Map)
        : <String, dynamic>{};

    final categoriesList = (homePage['categories'] as List<dynamic>?)
            ?.map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList() ??
        [];

    final featureSource = homePage['featureProducts'] ?? homePage['products'] ?? homePage['items'];
    final featureProductsList = (featureSource as List<dynamic>?)
            ?.map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList() ??
        [];

    final recommendedList = ((homePage['recommended'] ?? homePage['recommendations'] ?? const []) as List<dynamic>?)
            ?.map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList() ??
        [];

    final topCollectionsList = (homePage['topCollections'] as List<dynamic>?)
            ?.map((e) => Map<String, dynamic>.from(e as Map))
            .toList() ??
        [];

    final categoryPromosList = (homePage['categoryPromos'] as List<dynamic>?)
            ?.map((e) => Map<String, dynamic>.from(e as Map))
            .toList() ??
        [];

    return HomePageData(
      categories: categoriesList,
      heroBanner: Map<String, dynamic>.from((homePage['heroBanner'] ?? homePage['banner']) as Map? ?? {}),
      featureProducts: featureProductsList,
      newCollection: Map<String, dynamic>.from(homePage['newCollection'] as Map? ?? {}),
      recommended: recommendedList,
      topCollections: topCollectionsList,
      categoryPromos: categoryPromosList,
      productPageData: Map<String, dynamic>.from(productPage),
      storeName: homePage['storeName'] as String? ?? 'GemStore',
    );
  }
}
