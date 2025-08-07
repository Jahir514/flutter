import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/dashboard/model/dashboard_state.dart';
import 'package:personal_budget/features/dashboard/services/dashboard_service.dart';
import '../controller/dashboard_controller.dart';

final dashboardServiceProvider = Provider((ref) => DashboardService());

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
      final dashboardService = ref.read(dashboardServiceProvider);
      return DashboardController(dashboardService);
    });
