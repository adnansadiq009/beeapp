import 'package:dio/dio.dart';
import 'package:fuzzy/config.dart';
import 'api_client.dart';

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await ApiClient.dio.get('/category?public=true');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('Fetched categories (raw): $data');
        return data.map((item) => Category.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
}
