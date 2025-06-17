import 'package:fuzzy/config.dart';

class SelectedProductProvider extends ChangeNotifier {
  Product? _selectedProduct;

  Product? get selectedProduct => _selectedProduct;

  void setSelectedProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void clear() {
    _selectedProduct = null;
    notifyListeners();
  }

  List<LineItem> buildLineItems({
    required Variant variant,
    required int quantity,
  }) {
    if (_selectedProduct == null) return [];

    return [
      LineItem(
        variantId: variant.id ?? '',
        sku: variant.sku ?? '',
        quantity: quantity,
        name: _selectedProduct!.title ?? '',
        price: variant.price.toDouble(),
        image: _selectedProduct!.firstImageUrl,
        vendor: _selectedProduct!.vendor ?? '',
        weight: (variant.weight ?? 0).toDouble(),
      ),
    ];
  }
}
