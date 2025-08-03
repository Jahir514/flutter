import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/core/utils/snackbar_util.dart';
import 'package:personal_budget/features/income/model/income_model.dart';
import 'package:personal_budget/features/income/model/income_state.dart';
import 'package:personal_budget/features/income/services/income_services.dart';

class IncomeController extends StateNotifier<IncomeState> {
  final IncomeServices _incomeServices;
  IncomeController(this._incomeServices) : super(IncomeState()) {
    getAllIncome();
  }

  //get all income controller
  Future<void> createIncome(IncomeModel incomeData) async {
    //set loading state and error state
    state = state.copyWith(isLoading: true, error: null);
    try {
      final Map<String, dynamic> income = incomeData.toJson();
      //get data from service and set income state
      final newIncome = await _incomeServices.createIncome(income);
      final updatedIncome =
          // ignore: unnecessary_cast
          [...(state.income ?? []), newIncome].cast<IncomeModel>();
      state = state.copyWith(income: updatedIncome);
    } catch (e) {
      //set error state
      state = state.copyWith(
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      //set loading state after finishing task
      state = state.copyWith(isLoading: false);
    }
  }

  //get all income controller
  Future<void> getAllIncome() async {
    //set loading state and error state
    state = state.copyWith(isLoading: true, error: null);
    try {
      //get data from service and set income state
      final List<IncomeModel> incomes = await _incomeServices.getAllIncome();
      state = state.copyWith(income: incomes);
    } catch (e) {
      //set error state
      state = state.copyWith(
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      //set loading state after finishing task
      state = state.copyWith(isLoading: false);
    }
  }

  //delete income
  Future<void> deleteIncome(String id, BuildContext context) async {
    //set loading and error state begin of task
    state = state.copyWith(isLoading: true, error: null);
    try {
      final deleteMsg = await _incomeServices.removeIncome(id);
      //remove income from state
      if (state.income!.isNotEmpty) {
        final currentIncome = state.income!;
        final List<IncomeModel> income = currentIncome
            .where((data) => data.id != id)
            .toList();
        state = state.copyWith(income: income);
      }
      //show success message
      if (context.mounted) {
        SnackBarUtil.showSuccess(context, deleteMsg);
      }
    } catch (e) {
      //set error
      state = state.copyWith(
        error: e.toString().replaceFirst("Exception: ", ""),
      );
    } finally {
      //set loading state after finish task
      state = state.copyWith(isLoading: false);
    }
  }
}
