class DashboardModel {
  final double totalIncome;
  final double totalExpense;
  final double totalProfit;
  final List<ChartData> last7DaysIncomeChart;
  final List<ChartData> last7DaysExpenseChart;
  final List<ChartData> last7DaysProfitChart;
  final List<CategoryAmount> categoryWiseIncome;
  final List<CategoryAmount> categoryWiseExpense;
  final List<CategoryAmount> categoryWiseProfit;

  DashboardModel({
    required this.totalIncome,
    required this.totalExpense,
    required this.totalProfit,
    required this.last7DaysIncomeChart,
    required this.last7DaysExpenseChart,
    required this.last7DaysProfitChart,
    required this.categoryWiseIncome,
    required this.categoryWiseExpense,
    required this.categoryWiseProfit,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalIncome: (json['totalIncome'] ?? 0).toDouble(),
      totalExpense: (json['totalExpense'] ?? 0).toDouble(),
      totalProfit: (json['totalProfit'] ?? 0).toDouble(),
      last7DaysIncomeChart:
          (json['last7DaysIncomeChart'] as List<dynamic>?)
              ?.map((e) => ChartData.fromJson(e))
              .toList() ??
          [],
      last7DaysExpenseChart:
          (json['last7DaysExpenseChart'] as List<dynamic>?)
              ?.map((e) => ChartData.fromJson(e))
              .toList() ??
          [],
      last7DaysProfitChart:
          (json['last7DaysProfitChart'] as List<dynamic>?)
              ?.map((e) => ChartData.fromJson(e))
              .toList() ??
          [],
      categoryWiseIncome:
          (json['categoryWiseIncome'] as List<dynamic>?)
              ?.map((e) => CategoryAmount.fromJson(e))
              .toList() ??
          [],
      categoryWiseExpense:
          (json['categoryWiseExpense'] as List<dynamic>?)
              ?.map((e) => CategoryAmount.fromJson(e))
              .toList() ??
          [],
      categoryWiseProfit:
          (json['categoryWiseProfit'] as List<dynamic>?)
              ?.map((e) => CategoryAmount.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ChartData {
  final DateTime date;
  final double amount;

  ChartData({required this.date, required this.amount});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      date: DateTime.parse(json['date']),
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }
}

class CategoryAmount {
  final String category;
  final double amount;

  CategoryAmount({required this.category, required this.amount});

  factory CategoryAmount.fromJson(Map<String, dynamic> json) {
    return CategoryAmount(
      category: json['category'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }
}
