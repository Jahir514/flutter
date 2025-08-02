import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/income/model/income_model.dart';
import 'package:personal_budget/features/income/model/income_state.dart';
import 'package:personal_budget/features/income/services/income_services.dart';

class IncomeController extends StateNotifier<IncomeState> {
  final IncomeServices _incomeServices;
  IncomeController(this._incomeServices) : super(IncomeState()) {
    getAllIncome();
  }

  Future<void> getAllIncome() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final List<IncomeModel> incomes = await _incomeServices.getAllIncome();
      state = state.copyWith(income: incomes);
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
