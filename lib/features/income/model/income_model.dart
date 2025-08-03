class IncomeModel {
  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.category,
  });
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String? category;

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      id: json['_id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: json['category'] != null ? json['category']['title'] : null,
    );
  } //factory returns an instance of class. I need this method when i get api response in JSON.
  Map<String, dynamic> toJson() => {
    'title': title,
    'amount': amount,
    'category': category,
    'date': date.toIso8601String(),
  };
}
