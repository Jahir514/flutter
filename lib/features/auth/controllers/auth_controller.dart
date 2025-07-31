import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/core/utils/snackbar_util.dart';
import 'package:personal_budget/features/auth/model/auth_state.dart';
import 'package:personal_budget/features/auth/services/auth_services.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthServices _authServices;
  AuthController(this._authServices) : super(AuthState());

  //registration controller
  Future<void> emailRegistration(
    String email,
    String password,
    BuildContext context, {
    void Function()? onSuccess,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await _authServices.emailRegister(
        email: email,
        password: password,
      );
      state = state.copyWith(token: token);
      if (context.mounted && onSuccess != null) {
        if (context.mounted) {
          SnackBarUtil.showSuccess(context, 'Successfully create user');
        }
        onSuccess();
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceFirst('Exception: ', ''),
      );
      if (context.mounted) {
        SnackBarUtil.showError(
          context,
          e.toString().replaceFirst('Exception: ', ''),
        );
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
