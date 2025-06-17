import 'package:fuzzy/config.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  List<Product> newArrivals = [];
  List<Product> trendFurniture = [];
  List<Product> offerZone = [];
  List<Product> furnitureDecor = [];

  bool isLoading = false;
  String? error;

  Future<void> fetchAllProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final results = await Future.wait([
        _productService.fetchNewArrivals(),
        _productService.fetchProducts(category: 'trending'),
        _productService.fetchProducts(category: 'offers'),
        _productService.fetchProducts(category: 'decor'),
      ]);

      newArrivals = results[0];
      trendFurniture = results[1];
      offerZone = results[2];
      furnitureDecor = results[3];
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Product?> getProductById(String id) async {
    try {
      return await _productService.getProductDetails(id);
    } catch (e) {
      error = 'Failed to fetch product: $e';
      notifyListeners();
      return null;
    }
  }
}
