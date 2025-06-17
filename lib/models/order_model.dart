class Order {
  final String productId;
  final List<LineItem> lineItems;
  final String financialStatus;
  final String fulfillmentStatus;
  final Pricing pricing;
  final String paymentMethod;
  final ShipmentDetails shipmentDetails;
  final String status;

  Order({
    required this.productId,
    required this.lineItems,
    required this.financialStatus,
    required this.fulfillmentStatus,
    required this.pricing,
    required this.paymentMethod,
    required this.shipmentDetails,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      productId: json['productId'],
      lineItems: (json['lineItems'] as List)
          .map((item) => LineItem.fromJson(item))
          .toList(),
      financialStatus: json['financialStatus'],
      fulfillmentStatus: json['fulfillmentStatus'],
      pricing: Pricing.fromJson(json['pricing']),
      paymentMethod: json['paymentMethod'],
      shipmentDetails: ShipmentDetails.fromJson(json['shipmentDetails']),
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'lineItems': lineItems.map((e) => e.toJson()).toList(),
        'financialStatus': financialStatus,
        'fulfillmentStatus': fulfillmentStatus,
        'pricing': pricing.toJson(),
        'paymentMethod': paymentMethod,
        'shipmentDetails': shipmentDetails.toJson(),
        'status': status,
      };
}

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

class Pricing {
  final double subTotal;
  final double currentTotalPrice;
  final double paid;
  final double balance;
  final double shipping;
  final double taxPercentage;
  final double taxValue;
  final List<Map<String, dynamic>> extra;

  Pricing({
    required this.subTotal,
    required this.currentTotalPrice,
    required this.paid,
    required this.balance,
    required this.shipping,
    required this.taxPercentage,
    required this.taxValue,
    required this.extra,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        subTotal: (json['subTotal'] as num).toDouble(),
        currentTotalPrice: (json['currentTotalPrice'] as num).toDouble(),
        paid: (json['paid'] as num).toDouble(),
        balance: (json['balance'] as num).toDouble(),
        shipping: (json['shipping'] as num).toDouble(),
        taxPercentage: (json['taxPercentage'] as num).toDouble(),
        taxValue: (json['taxValue'] as num).toDouble(),
        extra: List<Map<String, dynamic>>.from(json['extra']),
      );

  Map<String, dynamic> toJson() => {
        'subTotal': subTotal,
        'currentTotalPrice': currentTotalPrice,
        'paid': paid,
        'balance': balance,
        'shipping': shipping,
        'taxPercentage': taxPercentage,
        'taxValue': taxValue,
        'extra': extra,
      };
}

class ShipmentDetails {
  final String email;
  final List<Address> addresses;

  ShipmentDetails({required this.email, required this.addresses});

  factory ShipmentDetails.fromJson(Map<String, dynamic> json) =>
      ShipmentDetails(
        email: json['email'],
        addresses: (json['addresses'] as List)
            .map((e) => Address.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };
}

class Address {
  final String name;
  final String phone;
  final String address1;
  final String address2;
  final String company;
  final City city;
  final String country;

  Address({
    required this.name,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.company,
    required this.city,
    this.country = "Pakistan",
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json['name'],
        phone: json['phone'],
        address1: json['address1'],
        address2: json['address2'],
        company: json['company'],
        city: City.fromJson(json['city']),
        country: json['country'] ?? "Pakistan",
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'address1': address1,
        'address2': address2,
        'company': company,
        'city': city.toJson(),
        'country': country,
      };
}

class City {
  final String city;

  City({required this.city});

  factory City.fromJson(Map<String, dynamic> json) => City(
        city: json['city'],
      );

  Map<String, dynamic> toJson() => {
        'city': city,
      };
}
