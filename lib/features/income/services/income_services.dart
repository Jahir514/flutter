import 'dart:convert';

import 'package:personal_budget/core/constants/api_constants.dart';
import 'package:personal_budget/features/income/model/income_model.dart';
import 'package:http/http.dart' as http;

class IncomeServices {
  final _url = '$baseUrl/income';

  //get all income method
  Future<List<IncomeModel>> getAllIncome() async {
    final response = await http.get(Uri.parse(_url));

    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonData['income'].map((e) => IncomeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load income');
    }
  }
}
