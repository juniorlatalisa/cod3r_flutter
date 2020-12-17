import 'package:expenses/components/transaction_card.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Text(
              'Nenhuma transação cadastrada',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.15,
            ),
            Image.asset(
              'assets/images/waiting.png',
              height: constraints.maxHeight * 0.5,
            )
          ],
        );
      });
    }

    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) => TransactionCard(
              transaction: transactions[index],
              onRemove: onRemove,
            ));
  }
}
