import 'package:batch_four_exp/features/auth/auth_controller.dart';
import 'package:batch_four_exp/features/auth/auth_repo.dart';
import 'package:batch_four_exp/features/auth/auth_response_model.dart';
import 'package:batch_four_exp/features/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepo = Provider<AuthRepo>((ref) {
  return AuthRepo(AuthService());
});

final authController =
    StateNotifierProvider<AuthController, AsyncValue<AuthModelResponse>>((ref) {
  return AuthController(ref.watch(authRepo));
});
