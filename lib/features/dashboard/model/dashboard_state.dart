import 'package:personal_budget/features/dashboard/model/dashboard_model.dart';

class DashboardState {
  final bool isLoading;
  final String? error;
  final DashboardModel? data;

  DashboardState({
    required this.isLoading,
    required this.error,
    required this.data,
  });

  factory DashboardState.initial() {
    return DashboardState(isLoading: false, error: null, data: null);
  }

  DashboardState copyWith({
    bool? isLoading,
    String? error,
    DashboardModel? data,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
