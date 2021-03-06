import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

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

      return {'day': day, 'value': value};
    }).reversed.toList();
  }

  double get _weekTotalValue =>
      groupedTransactions.fold(0.0, (sum, tr) => sum + tr['value']);

  @override
  Widget build(BuildContext context) {
    final total = _weekTotalValue;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      e['day'],
                      e['value'],
                      (total == 0) ? 0 : (e['value'] as double) / total,
                    ),
                  )) //Text(e['value'].toString())
              .toList(),
        ),
      ),
    );
  }
}
