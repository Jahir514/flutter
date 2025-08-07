// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:personal_budget/features/dashboard/providers/dashboard_provider.dart';
// import '../model/dashboard_model.dart';

// class DashboardScreen extends ConsumerStatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends ConsumerState<DashboardScreen> {
//   int selectedIndex = 0;
//   final filterOptions = ['7 Days', '14 Days', '1 Month', '1 Year'];
//   int selectedFilterIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final dashboardState = ref.watch(dashboardControllerProvider);

//     final tabs = ['Income', 'Expense', 'Profit'];

//     DashboardModel? data = dashboardState.data;
//     final isLoading = dashboardState.isLoading;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Dashboard"), centerTitle: true),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : data == null
//           ? const Center(child: Text("No dashboard data available"))
//           : Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Summary Cards
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildSummaryCard(
//                         Icons.trending_up,
//                         "Income",
//                         data.totalIncome,
//                         Colors.green,
//                       ),
//                       _buildSummaryCard(
//                         Icons.trending_down,
//                         "Expense",
//                         data.totalExpense,
//                         Colors.red,
//                       ),
//                       _buildSummaryCard(
//                         Icons.show_chart,
//                         "Profit",
//                         data.totalProfit,
//                         Colors.blue,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Tab toggle
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(tabs.length, (index) {
//                       return GestureDetector(
//                         onTap: () => setState(() => selectedIndex = index),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                           margin: const EdgeInsets.symmetric(horizontal: 8),
//                           decoration: BoxDecoration(
//                             color: selectedIndex == index
//                                 ? Colors.blue
//                                 : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             tabs[index],
//                             style: TextStyle(
//                               color: selectedIndex == index
//                                   ? Colors.white
//                                   : Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                   const SizedBox(height: 16),

//                   // Filter
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: List.generate(filterOptions.length, (index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() => selectedFilterIndex = index);
//                           // TODO: Trigger filter API call
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: selectedFilterIndex == index
//                                 ? Colors.blue
//                                 : Colors.grey[200],
//                           ),
//                           child: Text(
//                             filterOptions[index],
//                             style: TextStyle(
//                               color: selectedFilterIndex == index
//                                   ? Colors.white
//                                   : Colors.black87,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                   const SizedBox(height: 16),

//                   // Chart Block
//                   Text(
//                     "Last 7 Days",
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     height: 180,
//                     child: _buildChart(
//                       selectedIndex == 0
//                           ? data.last7DaysIncomeChart
//                           : selectedIndex == 1
//                           ? data.last7DaysExpenseChart
//                           : data.last7DaysProfitChart,
//                       selectedIndex,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Category Breakdown
//                   Text(
//                     "Category Breakdown",
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: _buildCategoryList(
//                       selectedIndex == 0
//                           ? data.categoryWiseIncome
//                           : selectedIndex == 1
//                           ? data.categoryWiseExpense
//                           : data.categoryWiseProfit,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildSummaryCard(
//     IconData icon,
//     String title,
//     double value,
//     Color color,
//   ) {
//     return Expanded(
//       child: Card(
//         elevation: 2,
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Icon(icon, color: color, size: 28),
//               const SizedBox(height: 8),
//               Text(title, style: const TextStyle(fontSize: 14)),
//               Text(
//                 "\$${value.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChart(List<ChartData> chartData, int selectedIndex) {
//     if (chartData.isEmpty) {
//       return const Center(child: Text("No chart data available"));
//     }

//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         barGroups: chartData
//             .asMap()
//             .entries
//             .map(
//               (entry) => BarChartGroupData(
//                 x: entry.key,
//                 barRods: [
//                   BarChartRodData(
//                     toY: entry.value.amount,
//                     color: selectedIndex == 0
//                         ? Colors.green
//                         : selectedIndex == 1
//                         ? Colors.red
//                         : Colors.blue,
//                     width: 14,
//                   ),
//                 ],
//               ),
//             )
//             .toList(),
//         borderData: FlBorderData(show: false),
//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (double value, meta) {
//                 if (value.toInt() >= chartData.length) {
//                   return const SizedBox.shrink();
//                 }
//                 final date = chartData[value.toInt()].date;
//                 return Text(
//                   "${date.day}/${date.month}",
//                   style: const TextStyle(fontSize: 10),
//                 );
//               },
//             ),
//           ),
//           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryList(List<CategoryAmount> data) {
//     if (data.isEmpty) {
//       return const Center(child: Text("No category data available"));
//     }

//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (_, index) {
//         final item = data[index];
//         return Card(
//           child: ListTile(
//             leading: const Icon(Icons.category),
//             title: Text(item.category),
//             trailing: Text("\$${item.amount.toStringAsFixed(2)}"),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:personal_budget/features/dashboard/providers/dashboard_provider.dart';
import '../model/dashboard_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int selectedTabIndex = 0; // For bottom navigation
  int selectedFilterIndex = 0;

  final filterOptions = ['7 Days', '14 Days', '1 Month', '1 Year'];
  final tabs = ['Income', 'Expense', 'Profit'];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardControllerProvider.notifier).getDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardControllerProvider);
    final isLoading = dashboardState.isLoading;
    final DashboardModel? data = dashboardState.data;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.login),
            tooltip: 'Login',
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            icon: const Icon(Icons.person_add),
            tooltip: 'Register',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : data == null
          ? const Center(child: Text("No dashboard data available"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSummaryCard(
                        Icons.attach_money,
                        "Income",
                        data.totalIncome,
                        Colors.green,
                      ),
                      _buildSummaryCard(
                        Icons.money_off,
                        "Expense",
                        data.totalExpense,
                        Colors.red,
                      ),
                      _buildSummaryCard(
                        Icons.pie_chart,
                        "Profit",
                        data.totalProfit,
                        Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Filter Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(filterOptions.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedFilterIndex = index);
                          // TODO: Filter logic
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedFilterIndex == index
                                ? Colors.blue
                                : Colors.grey[200],
                          ),
                          child: Text(
                            filterOptions[index],
                            style: TextStyle(
                              color: selectedFilterIndex == index
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),

                  // Chart
                  Text(
                    "Last 7 Days",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: _buildChart(
                      selectedTabIndex == 0
                          ? data.last7DaysIncomeChart
                          : selectedTabIndex == 1
                          ? data.last7DaysExpenseChart
                          : data.last7DaysProfitChart,
                      selectedTabIndex,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Category Breakdown
                  Text(
                    "Category Breakdown",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildCategoryList(
                      selectedTabIndex == 0
                          ? data.categoryWiseIncome
                          : selectedTabIndex == 1
                          ? data.categoryWiseExpense
                          : data.categoryWiseProfit,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCard(
    IconData icon,
    String title,
    double value,
    Color color,
  ) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(
                "\$${value.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(List<ChartData> chartData, int selectedIndex) {
    if (chartData.isEmpty) {
      return const Center(child: Text("No chart data available"));
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: chartData
            .asMap()
            .entries
            .map(
              (entry) => BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    toY: entry.value.amount,
                    color: selectedIndex == 0
                        ? Colors.green
                        : selectedIndex == 1
                        ? Colors.red
                        : Colors.blue,
                    width: 14,
                  ),
                ],
              ),
            )
            .toList(),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, meta) {
                if (value.toInt() >= chartData.length) {
                  return const SizedBox.shrink();
                }
                final date = chartData[value.toInt()].date;
                return Text(
                  "${date.day}/${date.month}",
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }

  Widget _buildCategoryList(List<CategoryAmount> data) {
    if (data.isEmpty) {
      return const Center(child: Text("No category data available"));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, index) {
        final item = data[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.category),
            title: Text(item.category),
            trailing: Text("\$${item.amount.toStringAsFixed(2)}"),
          ),
        );
      },
    );
  }
}
