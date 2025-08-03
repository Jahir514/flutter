import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/income/model/income_model.dart';
import 'package:personal_budget/features/income/providers/income_provider.dart';
import 'package:personal_budget/features/income/widgets/add_income_dialog.dart';
import 'package:personal_budget/features/income/widgets/income_list.dart';

class IncomeScreen extends ConsumerWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomeState = ref.watch(incomeControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Income List')),
      body: incomeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : incomeState.error != null
          ? Center(child: Text(incomeState.error!))
          : IncomeList(),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<IncomeModel>(
            context: context,
            builder: (context) => const AddIncomeDialog(),
          );
          if (result != null) {
            //controller.addIncome(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
