import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.addingNewExpense});

  final void Function(TextEditingController,TextEditingController,DateTime?,Category?) addingNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {

  DateTime? dateSelected;

  final _givenName=TextEditingController();
  final _givenAmount=TextEditingController();
  Category? _givencategory=Category.leisure;

  void _selectedDate() async {
    final today = DateTime.now();
    final firstday = DateTime(today.year - 1, today.month, today.day);

    final date = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: firstday,
        lastDate: today);

    setState(() {
      dateSelected = date;
    });
  }

  @override
  void dispose(){
    _givenName.dispose();
    _givenAmount.dispose();
    super.dispose();
  }


  void _addingExpense(){
    if(_givenName.text.trim().isEmpty){
      showDialog(
          context: context,
          builder: (ctx){
            return AlertDialog(
              title: const Text('Enter a name for expense'),
              actions: [
                TextButton(onPressed:() {
                  Navigator.pop(ctx);
                },
                    child: const Text("Okay") )
              ],
            );
          });
    }
    else if(double.tryParse(_givenAmount.text)==null){
      showDialog(
          context: context,
          builder: (ctx){
            return AlertDialog(
              title: const Text('Enter a valid amount'),
              actions: [
                TextButton(onPressed:() {
                  Navigator.pop(ctx);
                },
                    child: const Text("Okay") )
              ],
            );
          });
    }
    else if(dateSelected==null){
      showDialog(
          context: context,
          builder: (ctx){
            return  AlertDialog(
              title: const Text('Select a date'),
              actions: [
                TextButton(onPressed:() {
                  Navigator.pop(ctx);
                },
                    child: const Text("Okay") )
              ],
            );
          });
    }
    else {
      setState(() {
        widget.addingNewExpense(_givenName,_givenAmount,dateSelected,_givencategory);
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(context) {
    final width=MediaQuery.of(context).size.width;
    return SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
          child: Column(
            children: [
              if(width<600)
              TextField(
                maxLength: 50,
                controller: _givenName,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text("New Expense"),
                ),
              )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 50,
                        controller: _givenName,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          label: Text("New Expense"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _givenAmount,
                        decoration: const InputDecoration(
                          label: Text("Amount"),
                          prefixText: '₹',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              if(width<600)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _givenAmount,
                      decoration: const InputDecoration(
                        label: Text("Amount"),
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(dateSelected == null
                      ? 'Select date'
                      : '${dateSelected?.day.toString()}/${dateSelected?.month.toString()}/${dateSelected?.year.toString()}'),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        _selectedDate();
                      },
                      icon: const Icon(Icons.calendar_month)),
                ],
              )
              else
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton(
                        value: _givencategory,
                        items: Category.values.map((item){
                          return DropdownMenuItem(
                              value: item,
                              child: Text(item.name));
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            _givencategory=value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(dateSelected == null
                        ? 'Select date'
                        : '${dateSelected?.day.toString()}/${dateSelected?.month.toString()}/${dateSelected?.year.toString()}'),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          _selectedDate();
                        },
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              const SizedBox(height: 20,),
              if(width<600)
              Row(
                children: [
                  DropdownButton(
                    value: _givencategory,
                    items: Category.values.map((item){
                      return DropdownMenuItem(
                          value: item,
                          child: Text(item.name));
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _givencategory=value;
                      });
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                      child: const Text("cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(onPressed: _addingExpense, child: const Text("add")),
                ],
              )
              else
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        child: const Text("cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: _addingExpense, child: const Text("add")),
                  ],
                ),
            ],
          ),
        ),

    );
  }
}
