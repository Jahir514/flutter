import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/category/controller/category_controller.dart';
import 'package:personal_budget/features/category/services/category_services.dart';

final categoryServiceProvider = Provider((ref) => CategoryServices());
final categoryControllerProvider = StateNotifierProvider((ref) {
  final categoryService = ref.read(categoryServiceProvider);
  return CategoryController(categoryService);
});
