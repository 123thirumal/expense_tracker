import 'expense_model.dart';

class Bucket{
  Bucket({required this.specificExpenseList,required this.totalAmount,required this.specificCategory});

  Bucket.forCategory(List<Expenses> allexpense, this.specificCategory)
      : specificExpenseList = allexpense.where((element) {
    return element.category == specificCategory;
  }).toList();

  final List<Expenses> specificExpenseList;
  final Category specificCategory;
  double totalAmount=0;

  void calculateTotAmt(){
    for(int i=0;i<specificExpenseList.length;i++){
      totalAmount+=specificExpenseList[i].amount!;
    }
  }

}