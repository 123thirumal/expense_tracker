import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category  { work, leisure, food, travel}

const categoryIcons={
  Category.work: Icons.work,
  Category.leisure: Icons.sports_tennis,
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight_rounded
};

class Expenses {
  Expenses({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();


  final String name;
  final double? amount;
  final DateTime? date;
  final String id;
  final Category? category;
}


