import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/auth/controllers/auth_controller.dart';
import 'package:personal_budget/features/auth/services/auth_services.dart';

final authServiceProvider = Provider((ref) => AuthServices());

final authControllerProvider = StateNotifierProvider((ref) {
  final authServices = ref.read(authServiceProvider);
  return AuthController(authServices);
});
