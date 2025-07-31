class AuthState {
  AuthState({this.isLoading = false, this.error, this.user, this.token});
  final bool isLoading;
  final String? error;
  final String? user;
  final String? token;

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? user,
    String? token,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }
}
