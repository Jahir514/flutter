import 'package:personal_budget/features/income/model/income_model.dart';

class IncomeState {
  IncomeState({this.isLoading = false, this.error, this.income});

  final bool isLoading;
  final String? error;
  final List<IncomeModel>? income;

  IncomeState copyWith({
    bool? isLoading,
    String? error,
    List<IncomeModel>? income,
  }) {
    return IncomeState(
      error: error ?? this.error,
      income: income ?? this.income,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
