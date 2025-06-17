// models/product_model.dart
import 'package:fuzzy/models/model_path_list.dart';
import 'package:html/parser.dart' as html_parser;

class Product {
  final String? id;
  final String? storeId;
  final List<Map<String, dynamic>>? options;
  final String? channelId;
  // final int? shopifyId;
  final String? title;
  final String? vendor;
  final String? productType;
  final String? description;
  final bool? trackStock;
  final List<String>? availability;
  // final Map<String, dynamic>? identifiers;
  final Map<String, dynamic>? shipping;
  // final Map<String, dynamic>? seo;
  final String? category;
  final String? subCategory;
  // final List<String>? tags;
  final String? createdAt;
  final String? updatedAt;
  // final String? deletedAt;
  final ListForResale? listForResale;
  final double rating;
  final String? status;
  final String? mapped;
  final bool isInWishlist;
  final List<Variant> variants;
  final List<ProductImage> images;
  final num price;

  final num? discountedPrice;

  Product({
    this.id,
    this.storeId,
    this.options,
    this.channelId,
    // this.shopifyId,
    this.title,
    this.vendor,
    this.productType,
    this.description,
    this.trackStock,
    this.availability,
    // this.identifiers,
    this.shipping,
    // this.seo,
    this.category,
    this.subCategory,
    // this.tags,
    this.createdAt,
    this.rating = 0.0,
    this.updatedAt,
    this.isInWishlist = false,
    // this.deletedAt,
    this.listForResale,
    required this.status,
    this.mapped,
    required this.variants,
    required this.images,
    required this.price,
    this.discountedPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String rawDescription = json['description'] ?? '';
    String cleanDescription = _stripHtmlTags(rawDescription);
    List<Variant> variantList =
        (json['variants'] as List?)?.map((v) => Variant.fromJson(v)).toList() ??
            [];

    num mainPrice = variantList.isNotEmpty ? variantList[0].price : 0.0;
    num? mainDiscountedPrice =
        variantList.isNotEmpty ? variantList[0].discountedPrice : null;

    // 🆕 Extract category and subCategory from listForResale
    final resale = json['listForResale'] ?? {};
    return Product(
      id: json['_id'],
      storeId: json['storeId'],
      options: json['options'] != null
          ? List<Map<String, dynamic>>.from(json['options'])
          : null,
      channelId: json['channelId'],
      // shopifyId: json['shopify_id'],
      title: json['title'],
      vendor: json['vendor'],
      productType: json['productType'],
      description: cleanDescription,
      trackStock: json['trackStockNull'],
      availability: json['availability'] != null
          ? List<String>.from(json['availability'])
          : null,
      // identifiers: json['identifiers'],
      shipping: json['shipping'],
      // seo: json['seo'],
      category: resale['category'],
      subCategory: resale['subCategory'],
      // tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      // deletedAt: json['deletedAt'],
      listForResale: json['listForResale'] != null
          ? ListForResale.fromJson(json['listForResale'])
          : null,
      status: json['status'],
      mapped: json['mapped'],
      variants: (json['variants'] as List?)
              ?.map((v) => Variant.fromJson(v))
              .toList() ??
          [],
      images: (json['images'] as List?)
              ?.map((img) => ProductImage.fromJson(img))
              .toList() ??
          [],
      isInWishlist: json['isInWishlist'] ?? false,
      price: mainPrice,
      discountedPrice: mainDiscountedPrice,
    );
  }
  String get firstImageUrl =>
      images.isNotEmpty ? images.first.url : 'https://via.placeholder.com/150';
  static String _stripHtmlTags(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text.trim() ?? '';
  }
}

class ProductImage {
  final String url;
  final String? id;

  ProductImage({required this.url, this.id});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    const String baseUrl = 'https://static.shopilam.com/';
    String rawUrl = json['url'] ?? '';

    // Trim whitespace and check for full URL
    rawUrl = rawUrl.trim();
    String finalUrl = rawUrl.startsWith('https') ? rawUrl : baseUrl + rawUrl;

    return ProductImage(
      url: finalUrl,
      id: json['id']?.toString(),
    );
  }
}

class ListForResale {
  final String category;
  final String subCategory;
  final bool isList;
  final bool? isPublic;
  final int discount;
  final int inventory;
  final int? threshold;
  final List<ShippingCharge>? shippingCharges;

  ListForResale({
    required this.category,
    required this.subCategory,
    required this.isList,
    this.isPublic,
    required this.discount,
    required this.inventory,
    this.threshold,
    this.shippingCharges,
  });

  factory ListForResale.fromJson(Map<String, dynamic> json) {
    return ListForResale(
      category: json['category'],
      subCategory: json['subCategory'],
      isList: json['isList'],
      isPublic: json['isPublic'],
      discount: json['discount'],
      inventory: json['inventory'],
      threshold: json['threshold'],
      shippingCharges: json['shippingCharges'] != null
          ? List<ShippingCharge>.from(
              json['shippingCharges']
                  .where((e) => e != null)
                  .map((e) => ShippingCharge.fromJson(e)),
            )
          : null,
    );
  }
}

class ShippingCharge {
  final int fromPrice;
  final int toPrice;
  final int totalPrice;

  ShippingCharge({
    required this.fromPrice,
    required this.toPrice,
    required this.totalPrice,
  });

  factory ShippingCharge.fromJson(Map<String, dynamic> json) {
    return ShippingCharge(
      fromPrice: json['fromPrice'],
      toPrice: json['toPrice'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromPrice': fromPrice,
      'toPrice': toPrice,
      'totalPrice': totalPrice,
    };
  }
}






// class Product {
//   final String id;
//   final String title;
//   final String description;
//   final double price;
//   final double? discountedPrice;
//   final List<ProductImage> images;
//   final double rating;
//   final bool isInWishlist;
//   final List<String>? colors;
//   final List<Variant> variants;

//   // 🆕 Add these
//   final String? category;
//   final String? subCategory;

//   Product({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     this.discountedPrice,
//     required this.images,
//     this.rating = 0.0,
//     this.isInWishlist = false,
//     this.colors,
//     required this.variants,
//     this.category,
//     this.subCategory,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     String rawDescription = json['description'] ?? '';
//     String cleanDescription = _stripHtmlTags(rawDescription);
//     List<Variant> variantList =
//         (json['variants'] as List?)?.map((v) => Variant.fromJson(v)).toList() ??
//             [];

//     double mainPrice = variantList.isNotEmpty ? variantList[0].price : 0.0;
//     double? mainDiscountedPrice =
//         variantList.isNotEmpty ? variantList[0].discountedPrice : null;

//     // 🆕 Extract category and subCategory from listForResale
//     final resale = json['listForResale'] ?? {};

//     return Product(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       description: cleanDescription,
//       price: mainPrice,
//       discountedPrice: mainDiscountedPrice,
//       images: (json['images'] as List?)
//               ?.map((img) => ProductImage.fromJson(img))
//               .toList() ??
//           [],
//       rating: 0.0,
//       isInWishlist: json['isInWishlist'] ?? false,
//       variants: variantList,
//       category: resale['category'],
//       subCategory: resale['subCategory'],
//     );
//   }

//   String get firstImageUrl =>
//       images.isNotEmpty ? images.first.url : 'https://via.placeholder.com/150';

//   static String _stripHtmlTags(String htmlString) {
//     final document = html_parser.parse(htmlString);
//     return document.body?.text.trim() ?? '';
//   }
// }