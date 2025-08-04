import 'package:flutter/material.dart';

class CategoryBreakdown extends StatelessWidget {
  final Map<String, double> data;

  const CategoryBreakdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(e.key), Text('\$${e.value.toStringAsFixed(2)}')],
          ),
        );
      }).toList(),
    );
  }
}
