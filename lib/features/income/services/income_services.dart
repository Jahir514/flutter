import 'dart:convert';

import 'package:personal_budget/core/constants/api_constants.dart';
import 'package:personal_budget/features/income/model/income_model.dart';
import 'package:http/http.dart' as http;

class IncomeServices {
  final _url = '$baseUrl/income';

  //get all income method
  Future<IncomeModel> createIncome(Map<String, dynamic> income) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {"Content-type": "application/json"},
      body: json.encode(income),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return IncomeModel.fromJson(data['income']);
    } else {
      throw Exception('Failed to create income');
    }
  }

  //get all income method
  Future<List<IncomeModel>> getAllIncome() async {
    final response = await http.get(Uri.parse(_url));

    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> incomeList = jsonData['income'];
      final result = incomeList
          .map((e) => IncomeModel.fromJson(e))
          .toList()
          .cast<IncomeModel>();
      return result;
    } else {
      throw Exception('Failed to load income.');
    }
  }

  //remove income
  Future<String> removeIncome(String id) async {
    final deleteRoute = '$_url/$id';
    final response = await http.delete(Uri.parse(deleteRoute));
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      return data['message'];
    } else {
      throw Exception('Failed to remove income.');
    }
  }
}
