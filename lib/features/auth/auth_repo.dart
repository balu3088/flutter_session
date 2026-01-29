import 'package:batch_four_exp/features/auth/auth_response_model.dart';
import 'package:batch_four_exp/features/auth/auth_service.dart';

class AuthRepo {
  final AuthService authService;
  AuthRepo(this.authService);
  Future<AuthModelResponse> loginUser(String username, String password) async {
    return authService.loginUser(username, password);
  }
}
