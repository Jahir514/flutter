import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/features/category/providers/category_providers.dart';
import 'package:personal_budget/features/income/model/income_model.dart';
import 'package:personal_budget/features/income/providers/income_provider.dart';

class AddIncomeDialog extends ConsumerStatefulWidget {
  const AddIncomeDialog({super.key});

  @override
  ConsumerState<AddIncomeDialog> createState() => _AddIncomeDialogState();
}

class _AddIncomeDialogState extends ConsumerState<AddIncomeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    //load all income categories
    Future.microtask(() {
      final controller = ref.read(categoryControllerProvider.notifier);
      controller.getAllCategory(isIncome: true);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  //date pick method
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  //form submit method
  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      _showError('Please select a category');
      return;
    }

    if (_selectedDate == null) {
      _showError('Please select a date');
      return;
    }

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null) {
      _showError('Amount must be a valid number');
      return;
    }

    final newIncome = IncomeModel(
      id: '',
      title: _titleController.text.trim(),
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory!,
    );

    try {
      await ref.read(incomeControllerProvider.notifier).createIncome(newIncome);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryControllerProvider);

    return AlertDialog(
      title: const Text('Add Income'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Amount is required';
                  }
                  final amount = double.tryParse(value.trim());
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                dropdownColor: Colors.white,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                items:
                    categoryState.incomeCategories?.map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat.id,
                        child: Text(cat.title),
                      );
                    }).toList() ??
                    [],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${_selectedDate?.toLocal().toString().split(' ')[0] ?? 'Pick date'}',
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: const Text('Pick Date'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
