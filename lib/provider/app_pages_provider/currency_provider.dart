import 'package:fuzzy/config.dart';
import '../../plugin_list.dart';

class CurrencyProvider with ChangeNotifier {
  int? value = 0;
  int currencyVal = 1;
  String? priceSymbol = "Rs. ";
  int? selectIndex = 0;
  int? index = 0;
  String? symbolData;
  String? symbol;
  Locale? locale;
  bool isInvisible = false;
  final SharedPreferences sharedPreferences;

  List currencyListData = [];
// currency store local storage
  CurrencyProvider(this.sharedPreferences) {
    int? storedCurrencyVal = sharedPreferences.getInt('currencyData');
    index = sharedPreferences.getInt('selectedIndex');
    symbol = sharedPreferences.getString("symbol");

    if (storedCurrencyVal != null && symbol != null && index != null) {
      currencyVal = storedCurrencyVal;
      priceSymbol = symbol;
      selectIndex = index;
    }
  }

//page load
  void onReady() {
    currencyListData = appArray.currencyList;
    notifyListeners();
  }

//select currency
  onSelectCurrencyMethod(index, context, data) {
    selectIndex = index;
    currency(context).priceSymbol = data['symbol'].toString();
    final currencyData = Provider.of<CurrencyProvider>(context, listen: false);
    currencyData.currencyVal = _safeConvertToInt(data['exchange_rate']);
    symbolData = data['symbol'].toString();
    sharedPreferences.setInt('currencyData', currencyData.currencyVal.toInt());
    sharedPreferences.setInt("selectedIndex", selectIndex!);
    sharedPreferences.setString("symbol", symbolData!);
    currencyData.notifyListeners();
    notifyListeners();
  }

// Helper method to safely convert any input to integer
  int _safeConvertToInt(dynamic input) {
    try {
      if (input is int) return input;
      if (input is double) return input.round();
      if (input is String) return double.parse(input).round();
      return int.parse(input.toString());
    } catch (e) {
      return 1; // Default fallback value
    }
  }

//symbol set
  setVal() {
    priceSymbol = symbolData!;
    notifyListeners();
  }
}
