// import 'package:flutter/material.dart';
// import 'income_expense_chart.dart';
// import 'category_breakdown.dart';

// class DashboardBlock extends StatelessWidget {
//   final String title;
//   final double total;
//   final List<Map<String, dynamic>> chartData;
//   final Map<String, double> categoryBreakdown;
//   final bool isEmpty;

//   const DashboardBlock({
//     super.key,
//     required this.title,
//     required this.total,
//     required this.chartData,
//     required this.categoryBreakdown,
//     required this.isEmpty,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: Theme.of(context).textTheme.headline6),
//             const SizedBox(height: 8),
//             Text('Total: \$${total.toStringAsFixed(2)}',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),
//             if (isEmpty)
//               const Center(child: Text('No data available'))
//             else ...[
//               IncomeExpenseChart(data: chartData),
//               const SizedBox(height: 16),
//               CategoryBreakdown(data: categoryBreakdown),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }
