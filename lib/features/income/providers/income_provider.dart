import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/income/controllers/income_controller.dart';
import 'package:personal_budget/features/income/model/income_state.dart';

import 'package:personal_budget/features/income/services/income_services.dart';

final incomeServiceProvider = Provider((ref) => IncomeServices());

final incomeControllerProvider =
    StateNotifierProvider<IncomeController, IncomeState>((ref) {
      final incomeService = ref.read(incomeServiceProvider);
      return IncomeController(incomeService);
    });
