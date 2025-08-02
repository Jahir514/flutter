class IncomeModel {
  IncomeModel({required this.title, required this.amount, required this.date});
  final String title;
  final double amount;
  final DateTime date;

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  } //factory returns an instance of class. I need this method when i get api response in JSON.
  Map<String, dynamic> toJson() => {
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
  };
}
