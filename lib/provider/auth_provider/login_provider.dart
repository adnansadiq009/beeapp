// import 'package:fuzzy/config.dart';
// import '../../plugin_list.dart';
//
// class LoginProvider with ChangeNotifier {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   GlobalKey<FormState> loginKey = GlobalKey<FormState>();
//   final FocusNode emailFocus = FocusNode();
//   final FocusNode passwordFocus = FocusNode();
//   bool isNewPassword = true;
//   bool checkedValue = false, isBack = false;
//   final AuthService _authService = AuthService();
//   LoginProvider();
// //login button
//   onLogin(context) {
//     FocusManager.instance.primaryFocus?.unfocus();
//     if (loginKey.currentState!.validate()) {
//       login(context);
//     }
//   }
//
// //page load
//   onReady(context) {
//     dynamic data = ModalRoute.of(context)!.settings.arguments;
//     isBack = data ?? false;
//   }
//
//   //login
//   Future<void> login(context) async {
//     try {
//       final request = SigninRequest(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//
//       // Call API
//       AuthResponse response = await _authService.login(request);
//
//       // TODO: Save token securely if needed
//
//       await ApiClient.setAuthToken(response.token);
//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       userProvider.setUser(response.user, response.token);
//       // Navigate to dashboard
//       if (isBack) {
//         route.pop(context);
//       } else {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => MultiProvider(
//               providers: [
//                 ChangeNotifierProvider(create: (_) => DashboardProvider()),
//               ],
//               child: const Dashboard(),
//             ),
//           ),
//           ModalRoute.withName(routeName.dashboard),
//         );
//       }
//
//       onBack();
//     } catch (e) {
//       // Show login failure
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login failed: ${e.toString()}')),
//       );
//       print(e);
//     }
//
//     notifyListeners();
//   }
//
// //onBack clear
//   onBack() {
//     emailController.text = "";
//     passwordController.text = "";
//     notifyListeners();
//   }
//
//   //new password see tap
//   newPasswordSeenTap() {
//     isNewPassword = !isNewPassword;
//     notifyListeners();
//   }
//
//   //remember me
//   bool isCheck() {
//     checkedValue = !checkedValue;
//     notifyListeners();
//     return checkedValue;
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
// }
import 'package:fuzzy/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../plugin_list.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isNewPassword = true;
  bool checkedValue = false;
  bool isBack = false;

  final AuthService _authService = AuthService();

  LoginProvider();

  // Called when user taps Sign In button
  void onLogin(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginKey.currentState!.validate()) {
      login(context);
    }
  }

  // Called on page load to check route arguments
  void onReady(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    checkedValue = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  // Main login method
  Future<void> login(BuildContext context) async {
    try {
      final request = SigninRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Call the login API
      AuthResponse response = await _authService.login(request);

      // Save auth token (if you need it globally)
      await ApiClient.setAuthToken(response.token);

      // Save user to provider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(response.user, response.token);

      // ✅ If "Remember Me" is checked, save login state
      if (checkedValue) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('authToken', response.token); // optional
      }

      // Navigate to Dashboard
      if (isBack) {
        route.pop(context);
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => DashboardProvider()),
              ],
              child: const Dashboard(),
            ),
          ),
          ModalRoute.withName(routeName.dashboard),
        );
      }

      // Clear fields after login
      onBack();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
      print("Login error: $e");
    }

    notifyListeners();
  }

  // Clear login form
  void onBack() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  // Toggle password visibility
  void newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }

  // Toggle "Remember Me"
  bool isCheck() {
    checkedValue = !checkedValue;
    notifyListeners();
    return checkedValue;
  }

  // Optionally clear login data on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('authToken');
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
