import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/core/utils/date_format.dart';
import 'package:personal_budget/features/income/providers/income_provider.dart';

class IncomeList extends ConsumerWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomeState = ref.watch(incomeControllerProvider);
    final controller = ref.read(incomeControllerProvider.notifier);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: incomeState.income!.length,
            itemBuilder: (context, index) {
              final income = incomeState.income![index];
              //dismissible widget
              return Dismissible(
                key: ValueKey(income.title + income.date.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red.shade400,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  controller.deleteIncome(income.id, context);
                },
                //Card Widget
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SL Badge
                        // CircleAvatar(
                        //   radius: 16,
                        //   backgroundColor: Colors.green.shade400,
                        //   child: Text(
                        //     '${index + 1}',
                        //     style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(width: 10),

                        // Title
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                income.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                income.category ?? 'N/A',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Date
                        Expanded(
                          flex: 2,
                          child: Text(
                            formatDate(income.date),
                            //_formatDate(income.date),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Amount
                        Expanded(
                          flex: 2,
                          child: Text(
                            '৳${income.amount.toStringAsFixed(2)}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
