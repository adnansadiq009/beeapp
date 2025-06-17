import 'package:dio/dio.dart';

import '../../config.dart';
import '../../plugin_list.dart';

class RegistrationProvider with ChangeNotifier {
  GlobalKey<FormState> registrationKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isNewPassword = true;
  bool isLoading = false;

  final AuthService _authService = AuthService();

  // registration button click
  void onRegistration(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (registrationKey.currentState!.validate()) {
      registration(context);
    }
  }

  // registration logic
  Future<void> registration(context) async {
    isLoading = true;
    notifyListeners();

    try {
      final request = SignupRequest(
        name: nameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(), // Add field if needed
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      AuthResponse response = await _authService.signup(request);
      await ApiClient.setAuthToken(response.token);
      // Store user and token in UserProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(response.user, response.token);
      // Navigate to dashboard
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

      onBack();
    } catch (e) {
      String errorMessage = 'Registration failed. Please try again.';
      if (e is DioException) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // clear controllers
  void onBack() {
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    notifyListeners();
  }

  // toggle password visibility
  void newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }
}
