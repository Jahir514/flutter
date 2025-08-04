// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:personal_budget/features/dashboard/controllers/dashboard_state.dart';
// import 'package:personal_budget/features/income/service/income_service.dart';
// import 'package:personal_budget/features/expense/service/expense_service.dart';

// final dashboardControllerProvider =
//     StateNotifierProvider<DashboardController, DashboardState>((ref) {
//   return DashboardController(ref);
// });

// class DashboardController extends StateNotifier<DashboardState> {
//   final Ref ref;

//   DashboardController(this.ref) : super(DashboardState());

//   Future<void> loadData({
//     required DateTime from,
//     required DateTime to,
//   }) async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final incomeList = await IncomeService.getIncomes(from: from, to: to);
//       final expenseList = await ExpenseService.getExpenses(from: from, to: to);

//       state = state.copyWith(
//         isLoading: false,
//         incomes: incomeList,
//         expenses: expenseList,
//       );
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//     }
//   }
// }
