import 'package:dio/dio.dart';
import 'package:fuzzy/config.dart';
import 'api_client.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<AuthResponse> login(SigninRequest request) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/signin', // adjust path if needed
        data: request.toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);

      // Save token for future requests
      await ApiClient.setAuthToken(authResponse.token);

      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AuthResponse> signup(SignupRequest request) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/signup', // adjust path if needed
        data: request.toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);

      // Save token for future requests
      await ApiClient.setAuthToken(authResponse.token);

      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Error parser
  Exception _handleError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return Exception(e.response?.data['message'] ?? 'Something went wrong');
    } else {
      return Exception('Network error. Please try again.');
    }
  }
}
