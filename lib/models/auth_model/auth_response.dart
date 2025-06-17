class AuthResponse {
  final String token;
  final User user;
  final List<Store> stores;
  final List<String> procureStatus;
  // final ShopilamSurvey? shopilamSurvey;

  AuthResponse({
    required this.token,
    required this.user,
    required this.stores,
    required this.procureStatus,
    // required this.shopilamSurvey,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      stores: (json['stores'] as List<dynamic>?)
              ?.map((e) => Store.fromJson(e))
              .toList() ??
          [],
      procureStatus: List<String>.from(json['procureStatus'] ?? []),
      // shopilamSurvey: json['shopilamSurvey'] != null
      //     ? ShopilamSurvey.fromJson(json['shopilamSurvey'])
      //     : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
      'stores': stores.map((e) => e.toJson()).toList(),
      'procureStatus': procureStatus,
      // 'shopilamSurvey': shopilamSurvey?.toJson(),
    };
  }
}

class User {
  final String name;
  final String phoneNumber;
  final String email;
  final String image;

  User({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'image': image,
    };
  }
}

class Store {
  final String id;
  final String platform;
  final bool isMaster;
  final String logo;
  final String domainName;
  final String name;

  Store({
    required this.id,
    required this.platform,
    required this.isMaster,
    required this.logo,
    required this.domainName,
    required this.name,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? '',
      platform: json['platform'] ?? '',
      isMaster: json['isMaster'] ?? false,
      logo: json['logo'] ?? '',
      domainName: json['domainName'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform,
      'isMaster': isMaster,
      'logo': logo,
      'domainName': domainName,
      'name': name,
    };
  }
}

class ShopilamSurvey {
  final String id;
  final String accountId;
  final bool currentlySelling;
  final List<String> sellingChannels;
  final bool salesChannel;
  final List<String> products;
  final bool resellersProducts;
  final List<String> resellersOperate;
  final String manageResellers;
  final String primaryChallenge;
  final String sellProducts;
  final String viaDropshipping;
  final String hearAboutShopilam;
  final String createdAt;
  final String updatedAt;

  ShopilamSurvey({
    required this.id,
    required this.accountId,
    required this.currentlySelling,
    required this.sellingChannels,
    required this.salesChannel,
    required this.products,
    required this.resellersProducts,
    required this.resellersOperate,
    required this.manageResellers,
    required this.primaryChallenge,
    required this.sellProducts,
    required this.viaDropshipping,
    required this.hearAboutShopilam,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShopilamSurvey.fromJson(Map<String, dynamic> json) {
    return ShopilamSurvey(
      id: json['_id'] ?? '',
      accountId: json['accountId'] ?? '',
      currentlySelling: json['currentlySelling'] ?? false,
      sellingChannels: List<String>.from(json['sellingChannels'] ?? []),
      salesChannel: json['salesChannel'] ?? false,
      products: List<String>.from(json['products'] ?? []),
      resellersProducts: json['resellersProducts'] ?? false,
      resellersOperate: List<String>.from(json['resellersOperate'] ?? []),
      manageResellers: json['manageResellers'] ?? '',
      primaryChallenge: json['primaryChallenge'] ?? '',
      sellProducts: json['sellProducts'] ?? '',
      viaDropshipping: json['viaDropshipping'] ?? '',
      hearAboutShopilam: json['hearAboutShopilam'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'accountId': accountId,
      'currentlySelling': currentlySelling,
      'sellingChannels': sellingChannels,
      'salesChannel': salesChannel,
      'products': products,
      'resellersProducts': resellersProducts,
      'resellersOperate': resellersOperate,
      'manageResellers': manageResellers,
      'primaryChallenge': primaryChallenge,
      'sellProducts': sellProducts,
      'viaDropshipping': viaDropshipping,
      'hearAboutShopilam': hearAboutShopilam,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
