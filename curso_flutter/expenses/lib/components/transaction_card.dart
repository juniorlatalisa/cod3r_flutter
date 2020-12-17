import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final void Function(String) onRemove;

  const TransactionCard({
    @required this.transaction,
    @required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    const deleteIcon = const Icon(Icons.delete);
    final dateFormat = DateFormat('d MMM y');
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
              child: Text('R\$${transaction.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          dateFormat.format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                label: const Text('Excluir'),
                textColor: Theme.of(context).errorColor,
                icon: deleteIcon,
                onPressed: () => onRemove(transaction.id),
              )
            : IconButton(
                icon: deleteIcon,
                color: Theme.of(context).errorColor,
                onPressed: () => onRemove(transaction.id),
              ),
      ),
    );
  }
}
