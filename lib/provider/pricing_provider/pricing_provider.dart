import 'package:flutter/material.dart';

class PricingProvider with ChangeNotifier {
  double _subTotal = 0;
  double _shipping = 0;
  double _taxPercentage = 0;
  double _taxValue = 0;
  double _paid = 0;
  List<Map<String, dynamic>> _extra = [];

  double get subTotal => _subTotal;
  double get shipping => _shipping;
  double get taxPercentage => _taxPercentage;
  double get taxValue => _taxValue;
  double get paid => _paid;
  double get balance => _subTotal + _shipping + _taxValue - _paid;
  double get currentTotalPrice => _subTotal + _shipping + _taxValue;
  List<Map<String, dynamic>> get extra => _extra;

  void setPricing({
    required double subTotal,
    required double shipping,
    required double taxPercentage,
    double paid = 0,
    List<Map<String, dynamic>> extra = const [],
  }) {
    _subTotal = subTotal;
    _shipping = shipping;
    _taxPercentage = taxPercentage;
    _taxValue = (subTotal + shipping) * (taxPercentage / 100);
    _paid = paid;
    _extra = extra;
    notifyListeners();
  }

  void updatePaid(double amount) {
    _paid = amount;
    notifyListeners();
  }

  void reset() {
    _subTotal = 0;
    _shipping = 0;
    _taxPercentage = 0;
    _taxValue = 0;
    _paid = 0;
    _extra = [];
    notifyListeners();
  }
}
