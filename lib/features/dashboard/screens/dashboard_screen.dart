import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> filters = [
    '7 days',
    '14 days',
    '1 month',
    '1 year',
    'Custom',
  ];
  String selectedFilter = '7 days';

  final double totalIncome = 15790.50;

  final List<Map<String, dynamic>> categoryWiseIncome = [
    {'category': 'Salary', 'amount': 10000.0},
    {'category': 'Freelance', 'amount': 5790.5},
  ];

  final List<Map<String, dynamic>> last7DaysIncome = [
    {'date': 'Jul 26', 'amount': 200.0},
    {'date': 'Jul 27', 'amount': 0.0},
    {'date': 'Jul 28', 'amount': 300.0},
    {'date': 'Jul 29', 'amount': 400.0},
    {'date': 'Jul 30', 'amount': 100.0},
    {'date': 'Jul 31', 'amount': 500.0},
    {'date': 'Aug 01', 'amount': 250.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Income Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedFilter,
                  items: filters
                      .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedFilter = value;
                        // You would reload data based on filter here
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Total Income Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              color: Colors.green[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Income', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      '\$${totalIncome.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Category-wise income
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category Breakdown',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    categoryWiseIncome.isEmpty
                        ? const Text('No income data found.')
                        : Column(
                            children: categoryWiseIncome
                                .map(
                                  (item) => ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(item['category']),
                                    trailing: Text(
                                      '\$${item['amount'].toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Last 7 days chart
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: last7DaysIncome.isEmpty
                    ? const Center(child: Text('No chart data found.'))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last 7 Days Income',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY:
                                    last7DaysIncome
                                        .map((e) => e['amount'] as double)
                                        .reduce((a, b) => a > b ? a : b) +
                                    100,
                                barTouchData: BarTouchData(enabled: false),
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, _) {
                                        final index = value.toInt();
                                        if (index < 0 ||
                                            index >= last7DaysIncome.length)
                                          return const SizedBox.shrink();
                                        return Text(
                                          last7DaysIncome[index]['date'],
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                barGroups: last7DaysIncome.asMap().entries.map((
                                  entry,
                                ) {
                                  final index = entry.key;
                                  final value = entry.value;
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        toY: (value['amount'] as double),
                                        width: 18,
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
