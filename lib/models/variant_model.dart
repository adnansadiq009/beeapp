class Variant {
  final String id;
  final String title;
  final int price;
  final Stock stock;
  // final int compareAtPrice;
  // final int costPerItem;
  final String createdAt;
  final String updatedAt;
  final bool taxable;
  // final String? barcode;
  // final String? fulfillmentService;
  final dynamic weight;
  final String sku;
  // final String? imageId;
  final int discountedPrice;

  Variant({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    // required this.compareAtPrice,
    // required this.costPerItem,
    required this.createdAt,
    required this.updatedAt,
    required this.taxable,
    // this.barcode,
    // this.fulfillmentService,
    this.weight,
    required this.sku,
    // this.imageId,
    required this.discountedPrice,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      stock: Stock.fromJson(json['stock']),
      // compareAtPrice: json['compareAtPrice'],
      // costPerItem: json['costPerItem'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      taxable: json['taxable'],
      // barcode: json['barcode'],
      // fulfillmentService: json['fulfillment_service'],
      weight: json['weight'],
      sku: json['sku'],
      // imageId: json['imageId'],
      discountedPrice: json['discountedPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'stock': stock.toJson(),
      // 'compareAtPrice': compareAtPrice,
      // 'costPerItem': costPerItem,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'taxable': taxable,
      // 'barcode': barcode,
      // 'fulfillment_service': fulfillmentService,
      'weight': weight,
      'sku': sku,
      // 'imageId': imageId,
      'discountedPrice': discountedPrice,
    };
  }
}

class Stock {
  final int available;
  final int inHand;

  Stock({
    required this.available,
    required this.inHand,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      available: json['available'],
      inHand: json['inHand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'inHand': inHand,
    };
  }
}
