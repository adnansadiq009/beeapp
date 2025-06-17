import 'package:fuzzy/config.dart'; // Assuming models like User, Store, ShopilamSurvey are here

class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;
  List<Store> _stores = [];
  List<String> _procureStatus = [];
  // ShopilamSurvey? _shopilamSurvey;

  bool _isLoading = false;
  String? _error;

  // Getters
  User? get user => _user;
  String? get token => _token;
  List<Store> get stores => _stores;
  List<String> get procureStatus => _procureStatus;
  // ShopilamSurvey? get shopilamSurvey => _shopilamSurvey;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Set all data at once
  void setAuthData(AuthResponse response) {
    _user = response.user;
    _token = response.token;
    _stores = response.stores;
    _procureStatus = response.procureStatus;
    //  _shopilamSurvey = response.shopilamSurvey;
    _error = null;
    notifyListeners();
  }

  // Set individual user/token only
  void setUser(User user, String token) {
    _user = user;
    _token = token;
    _error = null;
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    _stores = [];
    _procureStatus = [];
    // _shopilamSurvey = null;
    notifyListeners();
  }
}
