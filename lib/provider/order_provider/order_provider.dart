import 'package:fuzzy/config.dart';
// Adjust this path as needed

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

  List<Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> onReady() async {
    await fetchOrders();
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await _orderService.fetchOrders();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitOrder(Order newOrder) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final createdOrder = await _orderService.submitOrder(newOrder);
      _orders.insert(0, createdOrder); // Add new order to the list
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
