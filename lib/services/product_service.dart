// services/product_service.dart
import 'package:dio/dio.dart';
import 'package:fuzzy/models/model_path_list.dart';
import 'api_client.dart';

class ProductService {
  final Dio _dio = ApiClient.dio;

  Future<List<Product>> fetchProducts({
    int page = 1,
    int limit = 10,
    String? category,
  }) async {
    try {
      final response = await _dio.get('/api/v1/products/products/listed');

      if (response.data == null) return [];
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } on DioException catch (e) {
      // Let Dio exceptions bubble up with their original information
      rethrow;
    }
  }

  Future<List<Product>> fetchNewArrivals() async {
    try {
      final response = await _dio.get('/api/v1/products/products/listed');

      if (response.data == null) return [];

      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Product> getProductDetails(String productId) async {
    try {
      final response = await _dio.get('api/v1/products/$productId');
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> toggleWishlist(String productId) async {
    try {
      await _dio.post('api/v1/wishlist/toggle', data: {'productId': productId});
    } on DioException catch (e) {
      rethrow;
    }
  }
}
