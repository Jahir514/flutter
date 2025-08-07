import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/dashboard/model/dashboard_state.dart';
import 'package:personal_budget/features/dashboard/services/dashboard_service.dart';

class DashboardController extends StateNotifier<DashboardState> {
  final DashboardService _dashboardService;

  DashboardController(this._dashboardService)
    : super(DashboardState.initial()) {
    getDashboardData();
  }

  Future<void> getDashboardData() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final dashboardData = await _dashboardService.getDashboardSummary();
      state = state.copyWith(isLoading: false, data: dashboardData);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
