import 'dart:convert';

import 'package:personal_budget/core/constants/api_constants.dart';
import 'package:personal_budget/features/dashboard/model/dashboard_model.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  final _uri = '$baseUrl/dashboard';

  Future<DashboardModel> getDashboardSummary() async {
    final response = await http.get(Uri.parse('$_uri/summary'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return DashboardModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to get dashboar summary');
    }
  }
}
