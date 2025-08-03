import 'package:personal_budget/features/category/model/category_model.dart';

class CategoryState {
  CategoryState({
    this.isLoading = false,
    this.error,
    this.incomeCategories,
    this.expenseCategories,
  });
  final bool? isLoading;
  final String? error;
  final List<CategoryModel>? incomeCategories;
  final List<CategoryModel>? expenseCategories;

  CategoryState copyWith({
    String? error,
    bool? isLoading,
    List<CategoryModel>? incomeCategories,
    List<CategoryModel>? expenseCategories,
  }) {
    return CategoryState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      incomeCategories: incomeCategories ?? this.incomeCategories,
      expenseCategories: expenseCategories ?? this.expenseCategories,
    );
  }
}
