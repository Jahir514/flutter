import 'dart:convert';

import 'package:personal_budget/core/constants/api_constants.dart';
import 'package:personal_budget/features/category/model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryServices {
  final _url = '$baseUrl/category';

  //get all category method
  Future<List<CategoryModel>> getAllCategory(bool isIncome) async {
    //get data from category api
    final response = await http.get(
      Uri.parse('$_url/income-or-expense/$isIncome'),
    );
    final jsonData = json.decode(response.body);
    //return list of category
    if (response.statusCode == 200) {
      final categories = jsonData['category'];
      //convert category map data to category Model
      final List<CategoryModel> result = categories
          .map((category) {
            return CategoryModel.fromJson(category);
          })
          .toList()
          .cast<CategoryModel>();
      return result;
    } else {
      throw Exception(jsonData['message']);
    }
  }
}
