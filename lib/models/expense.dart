import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// date fromatter from intl package
final formater = DateFormat.yMd();

// uuid for generating id in string
const uuid = Uuid();

// category enum value
enum Category { food, travel, entertainment, work }

// category icons map
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.entertainment: Icons.movie,
  Category.work: Icons.work,
};

// expense class
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formater.format(date);
  }
}
