import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key, required this.expenseitem});

  final Expenses expenseitem;

  @override
  State<ExpenseList> createState() {
    return _ExpenseListState();
  }
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(context) {
    return Card(
        //color: const Color(0x9D744EB2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.expenseitem.name,),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('₹${widget.expenseitem.amount.toString()}'),
                  const Spacer(),
                  Icon(categoryIcons[widget.expenseitem.category]),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                      '${widget.expenseitem.date?.toLocal().day.toString()}-${widget.expenseitem.date?.toLocal().month.toString()}-${widget.expenseitem.date?.toLocal().year.toString()}'),
                ],
              ),
            ],
          ),
        ));
  }
}
