import 'package:assignment_app/models/transaction_model.dart';
import 'package:assignment_app/widgets/charts_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Charts(this.recentTransaction);

  List<Map<String, Object>> get groupedExpense {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedExpense.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedExpense.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartsBar(
                data['day'],
                data['amount'],
                maxSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
