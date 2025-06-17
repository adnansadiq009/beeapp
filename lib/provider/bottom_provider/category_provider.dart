import '../../config.dart';

class CategoryProvider with ChangeNotifier {
  TextEditingController searchCtrl = TextEditingController();
  final CategoryService _categoryService = CategoryService();
  List cartListData = [];
  List chairList = [];
  bool isBack = false;
  List<Category> _categories = [];
  bool _isLoading = false;
  String _error = '';
  String categoryName = "";
  int selectIndex = 0;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;
  //page load
  void onReady(context) {
    chairList = appArray.chairlist;
    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
    fetchCategories();
  }

  void resetCategory() {
    selectIndex = 0;
    categoryName = "All Products";
    notifyListeners();
  }

  onSelectedCategory(int index, String title, context) {
    selectIndex = index;
    categoryName = title;
    route.pushNamed(context, routeName.chairData);
    notifyListeners();
  }

  // Use CategoryService here
  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _categories = await _categoryService.fetchCategories();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //move to cart
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

//device on back press
  onBackPress(context, isBack) async {
    if (isBack) {
      Navigator.canPop(context);
    } else {
      isDashboard(context);
    }
  }
}
