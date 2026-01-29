import 'dart:convert';

import 'package:batch_four_exp/config/app_config.dart';
import 'package:batch_four_exp/features/auth/auth_response_model.dart';
import 'package:batch_four_exp/util/http_client.dart';

class AuthService {
  final HttpClientWrapper _httpClient;
  AuthService({HttpClientWrapper? httpClient})
      : _httpClient = httpClient ??
            const HttpClientWrapper(baseUrl: AppConfig.baseUrlForLogin);

  Future<AuthModelResponse> loginUser(String username, String password) async {
    try {
      final response = await _httpClient.post(
        '/login',
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("Json Response: ${response.body}");
        final data = jsonDecode(response.body);

        return AuthModelResponse.fromJson(data as Map<String, dynamic>);
      } else {
        print("Login failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        final errorMessage = 'Failed to login: ${response.statusCode}';
        return AuthModelResponse('', null, null,
            error: errorMessage, status: ResponseStatus.failure);
      }
    } catch (e) {
      print("Login error: $e");
      final errorMessage = 'Login error: $e';
      return AuthModelResponse('', null, null,
          error: errorMessage, status: ResponseStatus.failure);
    }
  }
}
