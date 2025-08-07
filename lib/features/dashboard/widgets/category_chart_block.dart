// features/dashboard/widgets/category_chart_block.dart
import 'package:flutter/material.dart';

class CategoryChartBlock extends StatelessWidget {
  const CategoryChartBlock({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder: Replace with actual data visualization later
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ListTile(title: Text("Category Wise Income")),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Salary: ৳ 10,000\nFreelance: ৳ 5,790.50"),
          ),
        ],
      ),
    );
  }
}
