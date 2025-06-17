import 'package:fuzzy/config.dart';

class HomeProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  TextEditingController searchCtrl = TextEditingController();
  bool isDrawerOpen = false;
  List<Product> filteredProducts = [];

  List cartListData = [];

  // All lists now use Product model
  List<Product> newArrivalList = [];
  List<Product> newTrendFurniture = [];
  List<Product> newOfferZone = [];
  List<Product> newFurnitureDecor = [];
  List wishListHome = []; // Keep for cart compatibility
  List newFurnitureType = []; // Static data from appArray
  bool isSelected = false;

  // Loading and error states
  bool _isLoading = false;
  bool _isNewArrivalsLoading = false;
  bool _isTrendFurnitureLoading = false;
  bool _isOfferZoneLoading = false;
  bool _isFurnitureDecorLoading = false;
  String? _error;

  // Getters
  bool get isLoading => _isLoading;
  bool get isNewArrivalsLoading => _isNewArrivalsLoading;
  bool get isTrendFurnitureLoading => _isTrendFurnitureLoading;
  bool get isOfferZoneLoading => _isOfferZoneLoading;
  bool get isFurnitureDecorLoading => _isFurnitureDecorLoading;
  String? get error => _error;

  // Selected index open another index page

  // Load all data from APIs
  Future<void> onReady() async {
    _setLoading(true);
    _clearError();

    try {
      // Load static data (furniture types) from local arrays
      newFurnitureType = appArray.furnitureType;

      // Load all product data from APIs concurrently
      await Future.wait([
        _fetchNewArrivals(),
        _fetchTrendFurniture(),
        _fetchOfferZone(),
        _fetchFurnitureDecor(),
      ]);
    } catch (e) {
      _setError('Failed to load home data: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _fetchNewArrivals() async {
    try {
      _isNewArrivalsLoading = true;
      notifyListeners();

      newArrivalList = await _productService.fetchNewArrivals();
    } catch (e) {
      _setError('Error fetching new arrivals: $e');
      newArrivalList = [];
    } finally {
      _isNewArrivalsLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchTrendFurniture() async {
    try {
      _isTrendFurnitureLoading = true;
      notifyListeners();

      newTrendFurniture = await _productService.fetchProducts(
        category: 'trending',
        limit: 6,
      );
    } catch (e) {
      _setError('Error fetching trend furniture: $e');
      newTrendFurniture = [];
    } finally {
      _isTrendFurnitureLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchOfferZone() async {
    try {
      _isOfferZoneLoading = true;
      notifyListeners();

      newOfferZone = await _productService.fetchProducts(
        category: 'offers',
        limit: 8,
      );
    } catch (e) {
      _setError('Error fetching offer zone: $e');
      newOfferZone = [];
    } finally {
      _isOfferZoneLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchFurnitureDecor() async {
    try {
      _isFurnitureDecorLoading = true;
      notifyListeners();

      newFurnitureDecor = await _productService.fetchProducts(
        category: 'decor',
        limit: 10,
      );
    } catch (e) {
      _setError('Error fetching furniture decor: $e');
      newFurnitureDecor = [];
    } finally {
      _isFurnitureDecorLoading = false;
      notifyListeners();
    }
  }

  void filterProductsByCategory(String selectedCategory) {
    filteredProducts = newArrivalList
        .where((product) =>
            product.category?.toLowerCase() == selectedCategory.toLowerCase())
        .toList();
    notifyListeners();
  }

  // Refresh all data
  Future<void> refreshData() async {
    await onReady();
  }

  // Wishlist functionality with API integration
  Future<void> toggleWishlist(String productId) async {
    try {
      await _productService.toggleWishlist(productId);

      // Update local lists
      _updateProductWishlistStatus(newArrivalList, productId);
      _updateProductWishlistStatus(newTrendFurniture, productId);
      _updateProductWishlistStatus(newOfferZone, productId);
      _updateProductWishlistStatus(newFurnitureDecor, productId);

      notifyListeners();
    } catch (e) {
      _setError('Failed to update wishlist: $e');
    }
  }

  void _updateProductWishlistStatus(List<Product> list, String productId) {
    final index = list.indexWhere((product) => product.id == productId);
    // if (index != -1) {
    //   list[index] = list[index].copyWith(
    //     isWishlisted: !list[index].isWishlisted,
    //   );
    // }
  }

  // Add to cart - only works with Product objects
  void addToCart(Product product, context,
      {String colorName = "Default", int qty = 1}) {
    Map<String, dynamic> cartItem = {
      "id": product.id,
      "image": product.firstImageUrl ?? '',
      "title": product.title,
      "qty": qty,
      "colorName": colorName,
      "finalAmount": product.price.toString(),
      // "amount": product.originalPrice?.toString() ?? product.price.toString(),
    };

    // Check if item already exists in cart
    int existingIndex = cartListData.indexWhere((item) =>
        item['id'] == cartItem['id'] &&
        item['colorName'] == cartItem['colorName']);

    if (existingIndex != -1) {
      cartListData[existingIndex]['qty'] += qty;
    } else {
      cartListData.add(cartItem);
    }

    route.pushNamed(context, routeName.cartView);
    notifyListeners();
  }

  // Add to wishlist - works with Product objects and API
  Future<void> addToWishlist(Product product, context,
      {String colorName = "Default"}) async {
    try {
      // Call API to toggle wishlist
      await toggleWishlist(product.id!);

      // Also add to local wishListHome for compatibility
      Map<String, dynamic> wishlistItem = {
        "id": product.id,
        "image": product.firstImageUrl ?? '',
        "title": product.title,
        "qty": 1,
        "colorName": colorName,
        "finalAmount": product.price.toString(),
        // "amount": product.originalPrice?.toString() ?? product.price.toString(),
      };

      int existingIndex = wishListHome.indexWhere((item) =>
          item['id'] == wishlistItem['id'] &&
          item['colorName'] == wishlistItem['colorName']);

      if (existingIndex == -1) {
        wishListHome.add(wishlistItem);
      }

      route.pushNamed(context, routeName.wishlist);
      notifyListeners();
    } catch (e) {
      _setError('Failed to add to wishlist: $e');
    }
  }

  // Search functionality
  Future<List<Product>> searchProducts(String query) async {
    if (query.isEmpty) return [];

    try {
      // You might need to update your API to support search
      return await _productService.fetchProducts(
        page: 1,
        limit: 20,
        // Add search parameter when API supports it
      );
    } catch (e) {
      _setError('Error searching products: $e');
      return [];
    }
  }

  // Get product by ID
  Future<Product?> getProductById(String productId) async {
    try {
      return await _productService.getProductDetails(productId);
    } catch (e) {
      _setError('Error fetching product details: $e');
      return null;
    }
  }

  void moveToCart(int index, List<Map<String, dynamic>> itemList, context) {
    if (index >= 0 && index < itemList.length) {
      Map<String, dynamic>? itemToMove = itemList[index];
      if (itemToMove['image'] != null &&
          itemToMove['title'] != null &&
          itemToMove["qty"] != null &&
          itemToMove["colorName"] != null &&
          itemToMove['finalAmount'] != null &&
          itemToMove['amount'] != null) {
        String itemImage = itemToMove['image'].toString();
        String itemTitle = itemToMove['title'].toString();
        int itemQty = itemToMove["qty"];
        String itemColorName = itemToMove['colorName'].toString();
        String itemAmount = itemToMove['finalAmount'].toString();
        String itemDiscount = itemToMove['amount'].toString();

        int existingIndex = cartListData.indexWhere((item) =>
            item['title'] == itemTitle &&
            item['finalAmount'] == itemAmount &&
            item['amount'] == itemDiscount &&
            item['colorName'] == itemColorName);

        if (existingIndex != -1) {
          cartListData[existingIndex]['qty'] += itemQty;
        } else {
          cartListData.add({
            "image": itemImage,
            "title": itemTitle,
            "qty": itemQty,
            "colorName": itemColorName,
            "finalAmount": itemAmount,
            "amount": itemDiscount,
          });
        }
      }
      route.pushNamed(context, routeName.cartView);
      notifyListeners();
    }
  }

  //wishlist Functionality
  void moveToWishlist(int index, List<Map<String, dynamic>> itemList, context) {
    if (index >= 0 && index < itemList.length) {
      Map<String, dynamic>? itemToMove = itemList[index];
      if (itemToMove['image'] != null &&
          itemToMove['title'] != null &&
          itemToMove['finalAmount'] != null &&
          itemToMove['qty'] != null &&
          itemToMove["colorName"] != null &&
          itemToMove['amount'] != null) {
        String itemTitle = itemToMove['title'].toString();
        String itemAmount = itemToMove['finalAmount'].toString();
        String itemDiscount = itemToMove['amount'].toString();
        String itemColorName = itemToMove['colorName'].toString();

        int existingIndex = wishListHome.indexWhere((item) =>
            item['title'] == itemTitle &&
            item['finalAmount'] == itemAmount &&
            item['amount'] == itemDiscount &&
            item['colorName'] == itemColorName);

        if (existingIndex != -1) {
          bool alreadyInWishlist = itemList[index]['isInWishlist'] ?? false;
          if (!alreadyInWishlist) {
            itemList[index]['isInWishlist'] = true;
          }
          wishListHome[existingIndex]['qty'] += itemToMove['qty'];
        } else {
          wishListHome.add({
            "image": itemToMove['image'],
            "title": itemTitle,
            "qty": itemToMove['qty'],
            "finalAmount": itemAmount,
            "amount": itemDiscount,
            "colorName": itemColorName
          });
          itemList[index]['isInWishlist'] = true;
        }
        route.pushNamed(context, routeName.wishlist);
        notifyListeners();
      }
    }
  }

  // Utility methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }
}

// class HomeProvider with ChangeNotifier {
//   TextEditingController searchCtrl = TextEditingController();
//   bool isDrawerOpen = false;

//   int selectIndex = 0;
//   List cartListData = [];
//   List newArrivalList = [];
//   List newTrendFurniture = [];
//   List wishListHome = [];
//   List newOfferZone = [];
//   List newFurnitureDecor = [];
//   bool isSelected = false;
//   List newFurnitureType = [];

//   //slected index open another index page
//   onSelectedValue(int index, context) {
//     selectIndex = index;
//     route.pushNamed(context, routeName.chairData);
//     notifyListeners();
//   }

// //ready for load to data
//   void onReady() {
//     newArrivalList = appArray.newArrival;
//     newTrendFurniture = appArray.trendFurniture;
//     newOfferZone = appArray.offerZone;
//     newFurnitureDecor = appArray.furnitureDecor;
//     newFurnitureType = appArray.furnitureType;
//     notifyListeners();
//   }

// //add to cart Functionality
//   void moveToCart(int index, List<Map<String, dynamic>> itemList, context) {
//     if (index >= 0 && index < itemList.length) {
//       Map<String, dynamic>? itemToMove = itemList[index];
//       if (itemToMove['image'] != null &&
//           itemToMove['title'] != null &&
//           itemToMove["qty"] != null &&
//           itemToMove["colorName"] != null &&
//           itemToMove['finalAmount'] != null &&
//           itemToMove['amount'] != null) {
//         String itemImage = itemToMove['image'].toString();
//         String itemTitle = itemToMove['title'].toString();
//         int itemQty = itemToMove["qty"];
//         String itemColorName = itemToMove['colorName'].toString();
//         String itemAmount = itemToMove['finalAmount'].toString();
//         String itemDiscount = itemToMove['amount'].toString();

//         int existingIndex = cartListData.indexWhere((item) =>
//             item['title'] == itemTitle &&
//             item['finalAmount'] == itemAmount &&
//             item['amount'] == itemDiscount &&
//             item['colorName'] == itemColorName);

//         if (existingIndex != -1) {
//           cartListData[existingIndex]['qty'] += itemQty;
//         } else {
//           cartListData.add({
//             "image": itemImage,
//             "title": itemTitle,
//             "qty": itemQty,
//             "colorName": itemColorName,
//             "finalAmount": itemAmount,
//             "amount": itemDiscount,
//           });
//         }
//       }
//       route.pushNamed(context, routeName.cartView);
//       notifyListeners();
//     }
//   }

//   //wishlist Functionality
//   void moveToWishlist(int index, List<Map<String, dynamic>> itemList, context) {
//     if (index >= 0 && index < itemList.length) {
//       Map<String, dynamic>? itemToMove = itemList[index];
//       if (itemToMove['image'] != null &&
//           itemToMove['title'] != null &&
//           itemToMove['finalAmount'] != null &&
//           itemToMove['qty'] != null &&
//           itemToMove["colorName"] != null &&
//           itemToMove['amount'] != null) {
//         String itemTitle = itemToMove['title'].toString();
//         String itemAmount = itemToMove['finalAmount'].toString();
//         String itemDiscount = itemToMove['amount'].toString();
//         String itemColorName = itemToMove['colorName'].toString();

//         int existingIndex = wishListHome.indexWhere((item) =>
//             item['title'] == itemTitle &&
//             item['finalAmount'] == itemAmount &&
//             item['amount'] == itemDiscount &&
//             item['colorName'] == itemColorName);

//         if (existingIndex != -1) {
//           bool alreadyInWishlist = itemList[index]['isInWishlist'] ?? false;
//           if (!alreadyInWishlist) {
//             itemList[index]['isInWishlist'] = true;
//           }
//           wishListHome[existingIndex]['qty'] += itemToMove['qty'];
//         } else {
//           wishListHome.add({
//             "image": itemToMove['image'],
//             "title": itemTitle,
//             "qty": itemToMove['qty'],
//             "finalAmount": itemAmount,
//             "amount": itemDiscount,
//             "colorName": itemColorName
//           });
//           itemList[index]['isInWishlist'] = true;
//         }
//         route.pushNamed(context, routeName.wishlist);
//         notifyListeners();
//       }
//     }
//   }
// }
