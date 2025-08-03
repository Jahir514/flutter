import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/category/model/category_model.dart';
import 'package:personal_budget/features/category/model/category_state.dart';
import 'package:personal_budget/features/category/services/category_services.dart';

class CategoryController extends StateNotifier<CategoryState> {
  final CategoryServices _categoryServices;
  CategoryController(this._categoryServices) : super(CategoryState());

  //get all category controller
  Future<void> getAllCategory({required bool isIncome}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final List<CategoryModel> categories = await _categoryServices
          .getAllCategory(isIncome);
      //set category based on income or expense
      if (isIncome) {
        state = state.copyWith(incomeCategories: categories);
      } else {
        state = state.copyWith(expenseCategories: categories);
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
