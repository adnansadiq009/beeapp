class LineItem {
  final String variantId;
  final String sku;
  final int quantity;
  final String name;
  final double price;
  final String image;
  final String vendor;
  final double weight;

  LineItem({
    required this.variantId,
    required this.sku,
    required this.quantity,
    required this.name,
    required this.price,
    required this.image,
    required this.vendor,
    required this.weight,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        variantId: json['variantId'],
        sku: json['sku'],
        quantity: json['quantity'],
        name: json['name'],
        price: (json['price'] as num).toDouble(),
        image: json['image'],
        vendor: json['vendor'],
        weight: (json['weight'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'variantId': variantId,
        'sku': sku,
        'quantity': quantity,
        'name': name,
        'price': price,
        'image': image,
        'vendor': vendor,
        'weight': weight,
      };
}
