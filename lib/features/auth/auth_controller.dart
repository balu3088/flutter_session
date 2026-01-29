import 'package:batch_four_exp/common/services/shared_pref_config.dart';
import 'package:batch_four_exp/features/auth/auth_repo.dart';
import 'package:batch_four_exp/features/auth/auth_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:html' as html;

class AuthController extends StateNotifier<AsyncValue<AuthModelResponse>> {
  AuthRepo repo;
  AuthController(this.repo)
      : super(AsyncValue.data(AuthModelResponse('', '', null)));
  //AuthController() : super(AsyncValue.data(AuthModelResponse('', '', null)));
  static const _tokenKey = 'jwt_token';
  Future<void> login(String username, String password) async {
    state = AsyncValue.loading();
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));
    AuthModelResponse response = await repo.loginUser(username, password);
    final prefs = await SharedPrefConfig.getInstance();
    await prefs.setString('authToken', response.authToken);

    // For simplicity, we assume login is always successful
    state = AsyncValue.data(response);
  }

  Future<void> logout() async {
    state = AsyncValue.loading();
    // Simulate a network call
    await Future.delayed(Duration(seconds: 1));
    //state = AsyncValue.data(false);
  }
}
