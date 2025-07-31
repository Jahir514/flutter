import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpnse});
  final void Function(Expense expense) onAddExpnse;
  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  // removing controller when not needed. It saves memory
  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // here showDatePicker function a future data type which is handled by async awiat
  void _openDateCalendar() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _submitExpense() {
    final selectedAmount = double.tryParse(_amountController.text);
    final isInvalidAmount = selectedAmount == null || selectedAmount <= 0;
    //check input validation
    if (_textController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Content'),
          content: Text('Please enter a valid title and amount and date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpnse(
      Expense(
        title: _textController.text.trim(),
        amount: selectedAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 60,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : formater.format(
                              _selectedDate!,
                            ), // ! sign ensures dart it nevers null or force it to use this variable.
                    ),
                    IconButton(
                      onPressed: _openDateCalendar,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1),
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: DropdownButton(
                    value: _selectedCategory,
                    icon: SizedBox.shrink(),
                    hint: Text('Select a Category'),
                    underline: SizedBox(),
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //remove the context
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text('Create Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
