import 'package:dio/dio.dart';
import 'package:fuzzy/config.dart';
import 'api_client.dart';
// Make sure this matches the path where your Order model is defined

class OrderService {
  Future<List<Order>> fetchOrders() async {
    try {
      final response = await ApiClient.dio.get('/api/v1/orders');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('Fetched orders (raw): $data');
        return data.map((item) => Order.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Future<Order> submitOrder(Order order) async {
    final response =
        await ApiClient.dio.post('/api/v1/orders', data: order.toJson());

    if (response.statusCode == 201) {
      return Order.fromJson(response.data);
    } else {
      throw Exception('Failed to submit order');
    }
  }
}
