class CategoryModel {
  CategoryModel({
    required this.id,
    required this.title,
    required this.isIncome,
  });

  final String id;
  final String title;
  final bool isIncome;

  factory CategoryModel.fromJson(Map<String, dynamic> category) {
    return CategoryModel(
      id: category['_id'],
      title: category['title'],
      isIncome: category['isIncome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isIncome': isIncome};
  }
}
