import 'package:expenses/models/transaction.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  final _format = DateFormat('d MMM y');

  _createCard(BuildContext context, Transaction tr) {
    //Criar como const evita a recriacao
    const deleteIcon = const Icon(Icons.delete);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$${tr.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          _format.format(tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                label: const Text('Excluir'),
                textColor: Theme.of(context).errorColor,
                icon: deleteIcon,
                onPressed: () => onRemove(tr.id),
              )
            : IconButton(
                icon: deleteIcon,
                color: Theme.of(context).errorColor,
                onPressed: () => onRemove(tr.id),
              ),
      ),
    );
  }

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
      itemBuilder: (ctx, index) => _createCard(context, transactions[index]),
    );
  }
}
