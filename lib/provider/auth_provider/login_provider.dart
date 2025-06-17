import 'package:fuzzy/config.dart';
import '../../plugin_list.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  bool isNewPassword = true;
  bool checkedValue = false, isBack = false;
  final AuthService _authService = AuthService();
  LoginProvider();
//login button
  onLogin(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginKey.currentState!.validate()) {
      login(context);
    }
  }

//page load
  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

  //login
  Future<void> login(context) async {
    try {
      final request = SigninRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Call API
      AuthResponse response = await _authService.login(request);

      // TODO: Save token securely if needed

      await ApiClient.setAuthToken(response.token);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(response.user, response.token);
      // Navigate to dashboard
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

      onBack();
    } catch (e) {
      // Show login failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
      print(e);
    }

    notifyListeners();
  }

//onBack clear
  onBack() {
    emailController.text = "";
    passwordController.text = "";
    notifyListeners();
  }

  //new password see tap
  newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }

  //remember me
  bool isCheck() {
    checkedValue = !checkedValue;
    notifyListeners();
    return checkedValue;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
