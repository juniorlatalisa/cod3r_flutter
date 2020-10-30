import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTransactions);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final day = DateFormat.E().format(weekDay)[0];
      double value = 0.0;

      for (var transaction in recentTransactions) {
        if (weekDay.day == transaction.date.day &&
            weekDay.month == transaction.date.month &&
            weekDay.year == transaction.date.year) {
          value += transaction.value;
        }
      }

      return {
        'day': day,
        'value': value,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
