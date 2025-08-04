// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class IncomeExpenseChart extends StatelessWidget {
//   final List<Map<String, dynamic>> data;

//   const IncomeExpenseChart({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     if (data.isEmpty) return const SizedBox();

//     return SizedBox(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           lineBarsData: [
//             LineChartBarData(
//               spots: data.map((e) {
//                 final index = data.indexOf(e);
//                 return FlSpot(index.toDouble(), e['amount'] as double);
//               }).toList(),
//               isCurved: true,
//               barWidth: 3,
//               color: Colors.blue,
//               dotData: FlDotData(show: false),
//             )
//           ],
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//         ),
//       ),
//     );
//   }
// }
