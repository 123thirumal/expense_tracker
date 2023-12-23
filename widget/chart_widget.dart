import 'package:expense_tracker/widget/chart_bucket_widget.dart';
import 'package:flutter/material.dart';

import '../model/expense_model.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key, required this.expensedata});

  final List<Expenses> expensedata;

  @override
  State<ChartWidget> createState() {
    return _ChartWidgetState();
  }
}

class _ChartWidgetState extends State<ChartWidget> {


  @override
  Widget build(context) {
    return Row(children: [
      ...Category.values.map((item) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChartBucket(specificCategory: item,expensedata:widget.expensedata),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
                      color: Color(0xFF417594),
                    ),
                    child: Icon(
                      categoryIcons[item],
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      })
    ]);
  }
}
