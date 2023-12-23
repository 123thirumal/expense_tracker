import 'package:flutter/material.dart';
import '../model/bucket_model.dart';
import '../model/expense_model.dart';

class ChartBucket extends StatefulWidget {
  const ChartBucket(
      {super.key, required this.specificCategory, required this.expensedata});

  final Category specificCategory;

  final List<Expenses> expensedata;

  @override
  State<ChartBucket> createState() {
    return _ChartBucketState();
  }
}

//index for bucketList
const Map<Category, int> categoryIndex = {
  Category.work: 0,
  Category.travel: 1,
  Category.leisure: 2,
  Category.food: 3
};

class _ChartBucketState extends State<ChartBucket> {
  List<Bucket> bucketList = []; //0->work, 1->travel, 2->leisure, 3->food

  double maxOfTotAmt = 0;

  double barHeight = 0;

  void _initializeBucket() {
    bucketList = [];

    //for work
    bucketList.add(Bucket.forCategory(widget.expensedata, Category.work));
    bucketList[0].calculateTotAmt();

    //for travel
    bucketList.add(Bucket.forCategory(widget.expensedata, Category.travel));
    bucketList[1].calculateTotAmt();

    //for leisure
    bucketList.add(Bucket.forCategory(widget.expensedata, Category.leisure));
    bucketList[2].calculateTotAmt();

    //for food
    bucketList.add(Bucket.forCategory(widget.expensedata, Category.food));
    bucketList[3].calculateTotAmt();
  }

  void _calculateMaxOfTotAmt() {
    maxOfTotAmt = 0;
    for (int i = 0; i < bucketList.length; i++) {
      if (maxOfTotAmt < bucketList[i].totalAmount) {
        maxOfTotAmt = bucketList[i].totalAmount;
      }
    }
  }

  void _calculateBarHeight() {
    barHeight = 0;
    if (bucketList[categoryIndex[widget.specificCategory]!]
        .specificExpenseList
        .isEmpty) {
      barHeight = 0;
    } else {
      barHeight =
          bucketList[categoryIndex[widget.specificCategory]!].totalAmount /
              maxOfTotAmt;
    }
  }

  @override
  Widget build(context) {
    setState(() {
      _initializeBucket();
      _calculateMaxOfTotAmt();
      _calculateBarHeight();
    });
    return Expanded(
        child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            widthFactor: 1,
            heightFactor: barHeight,
            child: const DecoratedBox(
                decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: Color(0xFF417594),
            ))));
  }
}
