
import 'package:expense_tracker/widget/chart_widget.dart';
import 'package:expense_tracker/widget/new_expense_widget.dart';
import 'package:expense_tracker/widget/expense_list_widget.dart';
import 'package:flutter/material.dart';
import '../model/expense_model.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() {
    return _ExpensePageState();
  }
}

class _ExpensePageState extends State<ExpensePage> {
  List<Expenses> expensedata=[];

  void _addingNewExpense(
      TextEditingController givenName,
      TextEditingController givenAmount,
      DateTime? dateSelected,
      Category? givencategory) {
    setState(() {
      expensedata.add(Expenses(
          name: givenName.text.trim(),
          amount: double.tryParse(givenAmount.text),
          date: dateSelected,
          category: givencategory));
    });
  }


  void openbottomsheet() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(addingNewExpense: _addingNewExpense);
        });
  }

  void _showSnackBar(int index,Expenses expense){
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 2),
          content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              expensedata.insert(index, expense);
            });
          },
        ),

      )
    );
  }

  void _deleteAllExpense(){
    showDialog(
        context: context,
        builder: (ctx){
          return AlertDialog(
            title: const Text('Are you sure to delete all expense?'),
            actions: [
              TextButton(onPressed:() {
                Navigator.pop(ctx);
              },
                  child: const Text("cancel") ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      expensedata=[];
                    });
                    Navigator.pop(ctx);
                  },
                  child: const Text("Yes"),)
            ],
          );
        });
  }

  @override
  Widget build(context) {

    final width=MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Expense Tracker',
          ),
          actions: [
            IconButton(
                onPressed: _deleteAllExpense,
                icon: const Icon(Icons.delete_sweep_outlined),
            )
          ],
        ),
        body: expensedata.isEmpty?const Center(child: Text('Press + to add expenses')):
            width>600
                ?Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xFF0C181A)

                      ),
                      child: ChartWidget(expensedata: expensedata),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: expensedata.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          direction: DismissDirection.startToEnd,
                          background: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust the padding as needed
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(8.0), // Adjust the radius as needed
                                ),
                              ),
                              child: const Align(
                                alignment: Alignment(-0.9, 0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          key: ValueKey(expensedata[index]),
                          onDismissed: (direction) {
                            setState(() {
                              _showSnackBar(index, expensedata[index]);
                              expensedata.remove(expensedata[index]);
                            });
                          },
                          child: ExpenseList(expenseitem: expensedata[index]),
                        );

                      }),
                ),
              ],
            )
        : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0xFF0C181A)

                ),
                child: ChartWidget(expensedata: expensedata),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: expensedata.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.startToEnd,
                      background: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust the padding as needed
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(8.0), // Adjust the radius as needed
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment(-0.9, 0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      key: ValueKey(expensedata[index]),
                      onDismissed: (direction) {
                        setState(() {
                          _showSnackBar(index, expensedata[index]);
                          expensedata.remove(expensedata[index]);
                        });
                      },
                      child: ExpenseList(expenseitem: expensedata[index]),
                    );

                  }),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: openbottomsheet,
        child: const Icon(Icons.add),
      ),);
  }
}
